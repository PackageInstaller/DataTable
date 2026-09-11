using System.Security.Cryptography.X509Certificates;

namespace System.Net.Security;

internal delegate X509Certificate LocalCertSelectionCallback(string targetHost, X509CertificateCollection localCertificates, X509Certificate remoteCertificate, string[] acceptableIssuers);
