using System;
using System.Net.Security;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;

namespace Mono.Net.Security;

internal sealed class MonoSslServerAuthenticationOptions : MonoSslAuthenticationOptions
{
	public SslServerAuthenticationOptions Options { get; }

	public override bool ServerMode => true;

	public override X509RevocationMode CertificateRevocationCheckMode
	{
		set
		{
			Options.CertificateRevocationCheckMode = value;
		}
	}

	public override EncryptionPolicy EncryptionPolicy
	{
		set
		{
			Options.EncryptionPolicy = value;
		}
	}

	public override SslProtocols EnabledSslProtocols
	{
		get
		{
			return Options.EnabledSslProtocols;
		}
		set
		{
			Options.EnabledSslProtocols = value;
		}
	}

	public override bool ClientCertificateRequired
	{
		get
		{
			return Options.ClientCertificateRequired;
		}
		set
		{
			Options.ClientCertificateRequired = value;
		}
	}

	public override string TargetHost
	{
		get
		{
			throw new NotSupportedException();
		}
		set
		{
			throw new NotSupportedException();
		}
	}

	public override X509Certificate ServerCertificate
	{
		get
		{
			return Options.ServerCertificate;
		}
		set
		{
			Options.ServerCertificate = value;
		}
	}

	public override X509CertificateCollection ClientCertificates
	{
		get
		{
			throw new NotSupportedException();
		}
		set
		{
			throw new NotSupportedException();
		}
	}

	public MonoSslServerAuthenticationOptions()
	{
		Options = new SslServerAuthenticationOptions();
	}
}
