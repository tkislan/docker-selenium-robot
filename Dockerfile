FROM ubuntu:16.04

ENV HOME=/root

RUN apt-get update && \
  apt-get install -y \
    python \
    python-dev \
    python-pip \
    chromium-browser \
    libgconf-2-4 \
    xvfb \
    x11vnc \
    bash \
    curl \
    unzip \
    postgresql-client && \
  curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz && \
  tar xzvf docker-17.05.0-ce.tgz && \
  mv docker/docker /usr/local/bin && \
  rm -r docker docker-17.05.0-ce.tgz && \
  curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose && \
  pip install -U \
    pip \
    robotframework==3.0.2 \
    robotframework-selenium2library==1.8.0 \
    selenium==2.53.6 \
    requests \
    robotframework-requests && \
  curl -L "https://chromedriver.storage.googleapis.com/2.29/chromedriver_linux64.zip" \
    -o "/tmp/chromedriver.zip" && \
  unzip "/tmp/chromedriver.zip" -d "/tmp" && \
  mv "/tmp/chromedriver" "/usr/bin/" && \
  rm "/tmp/chromedriver.zip" && \
  mkdir -p $HOME/robot

WORKDIR $HOME/robot

ENTRYPOINT ["pybot", "-P", "lib/", "-d", "/tmp/robot"]
CMD ["test/"]
