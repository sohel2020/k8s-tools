FROM alpine:3.12.0

ENV KUBECTL_VERSION=1.20.14
ENV HELM_VERSION=3.5.2
ENV IAM_AUTHENTICATOR_VERSION=0.5.5
ENV HELM_RELEASE_ROOT="https://get.helm.sh"
ENV HELM_RELEASE_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
ENV HELMFILE_VERSION=0.144.0
ENV SOPS_VERSION=3.7.2
ENV HELM_SECRET_VERSION=3.10.0
RUN apk add --update git openssh openssl ca-certificates curl bash gnupg && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    curl -L https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${IAM_AUTHENTICATOR_VERSION}/aws-iam-authenticator_${IAM_AUTHENTICATOR_VERSION}_linux_amd64 -o /usr/local/bin/aws-iam-authenticator && \
    chmod +x /usr/local/bin/aws-iam-authenticator && \
    curl -L ${HELM_RELEASE_ROOT}/${HELM_RELEASE_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    rm -rf linux-amd64 && \
    mkdir /root/.kube && \
    curl -L https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.amd64 -o /usr/local/bin/sops && \
    chmod +x /usr/local/bin/sops && \
    curl -L https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 -o /usr/local/bin/helmfile && \
    chmod +x /usr/local/bin/helmfile && \
    helm plugin install https://github.com/jkroepke/helm-secrets --version v${HELM_SECRET_VERSION}
