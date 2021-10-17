FROM debian:10-slim

WORKDIR /build

RUN \
    apt-get update && \
    apt-get install -y wget && \
    wget -q https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.2.0/graalvm-ce-java11-linux-amd64-21.2.0.tar.gz && \
    tar -xzf graalvm-ce-java11-linux-amd64-21.2.0.tar.gz

FROM debian:10-slim

COPY --from=0 /build/graalvm-ce-java11-21.2.0 /opt/graalvm-ce-java11-21.2.0

ENV PATH="/opt/graalvm-ce-java11-21.2.0/bin:$PATH"

RUN \
    apt-get update && \
    apt-get install -y build-essential gcc libc-dev zlib1g-dev && \
    gu install native-image

CMD ["/bin/bash"]
