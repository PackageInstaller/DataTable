using System;
using System.Net.Security;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;

namespace Mono.Net.Security;

internal sealed class MonoSslClientAuthenticationOptions : MonoSslAuthenticationOptions
{
	public SslClientAuthenticationOptions Options { get; }

	public override bool ServerMode => false;

	public override bool AllowRenegotiation => Options.AllowRenegotiation;

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

	public override string TargetHost
	{
		get
		{
			return Options.TargetHost;
		}
		set
		{
			Options.TargetHost = value;
		}
	}

	public override bool ClientCertificateRequired
	{
		get
		{
			throw new NotSupportedException();
		}
	}

	public override X509CertificateCollection ClientCertificates
	{
		get
		{
			return Options.ClientCertificates;
		}
		set
		{
			Options.ClientCertificates = value;
		}
	}

	public override X509Certificate ServerCertificate
	{
		get
		{
			throw new NotSupportedException();
		}
	}

	public MonoSslClientAuthenticationOptions()
	{
		Options = new SslClientAuthenticationOptions();
	}
}
