using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;

namespace System.Net.Security;

public class SslClientAuthenticationOptions
{
	private EncryptionPolicy _encryptionPolicy;

	private X509RevocationMode _checkCertificateRevocation;

	private SslProtocols _enabledSslProtocols;

	private bool _allowRenegotiation = true;

	public bool AllowRenegotiation => _allowRenegotiation;

	public string TargetHost { get; set; }

	public X509CertificateCollection ClientCertificates { get; set; }

	public X509RevocationMode CertificateRevocationCheckMode
	{
		set
		{
			if (value != X509RevocationMode.NoCheck && value != X509RevocationMode.Offline && value != X509RevocationMode.Online)
			{
				throw new ArgumentException(global::SR.Format("The specified value is not valid in the '{0}' enumeration.", "X509RevocationMode"), "value");
			}
			_checkCertificateRevocation = value;
		}
	}

	public EncryptionPolicy EncryptionPolicy
	{
		set
		{
			if (value != EncryptionPolicy.RequireEncryption && value != EncryptionPolicy.AllowNoEncryption && value != EncryptionPolicy.NoEncryption)
			{
				throw new ArgumentException(global::SR.Format("The specified value is not valid in the '{0}' enumeration.", "EncryptionPolicy"), "value");
			}
			_encryptionPolicy = value;
		}
	}

	public SslProtocols EnabledSslProtocols
	{
		get
		{
			return _enabledSslProtocols;
		}
		set
		{
			_enabledSslProtocols = value;
		}
	}
}
