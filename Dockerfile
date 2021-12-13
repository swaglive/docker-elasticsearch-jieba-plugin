ARG     VERSION=7.7.0

FROM    gradle:5.4.1 as plugin

ARG     VERSION

RUN     echo $VERSION && wget -O- https://github.com/sing1ee/elasticsearch-jieba-plugin/archive/v$VERSION.tar.gz | tar -xzv && \
        cd elasticsearch-jieba-plugin-$VERSION && \
        gradle clean pz && \
        mkdir -p /usr/share/elasticsearch/plugins/jieba && \
        unzip -d /usr/share/elasticsearch/plugins/jieba build/distributions/elasticsearch-jieba-plugin-$VERSION.zip

###

FROM    elasticsearch:$VERSION

COPY    --chown=elasticsearch:root --from=plugin /usr/share/elasticsearch/plugins/jieba /usr/share/elasticsearch/plugins/jieba
