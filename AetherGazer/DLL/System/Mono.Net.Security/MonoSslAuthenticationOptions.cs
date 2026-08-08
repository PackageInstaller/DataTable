using System.Net.Security;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;

namespace Mono.Net.Security;

internal abstract class MonoSslAuthenticationOptions
{
	public abstract bool ServerMode { get; }

	public abstract bool AllowRenegotiation { get; }

	public abstract SslProtocols EnabledSslProtocols { get; set; }

	public abstract EncryptionPolicy EncryptionPolicy { set; }

	public abstract X509RevocationMode CertificateRevocationCheckMode { set; }

	public abstract string TargetHost { get; set; }

	public abstract X509Certificate ServerCertificate { get; }

	public abstract X509CertificateCollection ClientCertificates { get; set; }

	public abstract bool ClientCertificateRequired { get; }

	internal ServerCertSelectionCallback ServerCertSelectionDelegate { get; }
}
