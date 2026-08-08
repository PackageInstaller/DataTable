using System;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;
using Mono.Security.Interface;

namespace Mono.Net.Security;

internal abstract class MobileTlsContext : IDisposable
{
	private ChainValidationHelper certificateValidator;

	internal MonoSslAuthenticationOptions Options { get; }

	internal MobileAuthenticatedStream Parent { get; }

	public MonoTlsSettings Settings => Parent.Settings;

	public abstract bool IsAuthenticated { get; }

	public bool IsServer { get; }

	internal string TargetHost { get; }

	protected string ServerName { get; }

	protected bool AskForClientCertificate { get; }

	protected SslProtocols EnabledProtocols { get; }

	protected X509CertificateCollection ClientCertificates { get; }

	internal X509Certificate LocalServerCertificate { get; private set; }

	internal abstract X509Certificate LocalClientCertificate { get; }

	public abstract X509Certificate2 RemoteCertificate { get; }

	protected MobileTlsContext(MobileAuthenticatedStream parent, MonoSslAuthenticationOptions options)
	{
		Parent = parent;
		Options = options;
		IsServer = options.ServerMode;
		EnabledProtocols = options.EnabledSslProtocols;
		if (options.ServerMode)
		{
			LocalServerCertificate = options.ServerCertificate;
			AskForClientCertificate = options.ClientCertificateRequired;
		}
		else
		{
			ClientCertificates = options.ClientCertificates;
			TargetHost = options.TargetHost;
			ServerName = options.TargetHost;
			if (!string.IsNullOrEmpty(ServerName))
			{
				int num = ServerName.IndexOf(':');
				if (num > 0)
				{
					ServerName = ServerName.Substring(0, num);
				}
			}
		}
		certificateValidator = ChainValidationHelper.GetInternalValidator(parent.SslStream, parent.Provider, parent.Settings);
	}

	protected void GetProtocolVersions(out TlsProtocolCode? min, out TlsProtocolCode? max)
	{
		if ((EnabledProtocols & SslProtocols.Tls) != SslProtocols.None)
		{
			min = TlsProtocolCode.Tls10;
		}
		else if ((EnabledProtocols & SslProtocols.Tls11) != SslProtocols.None)
		{
			min = TlsProtocolCode.Tls11;
		}
		else if ((EnabledProtocols & SslProtocols.Tls12) != SslProtocols.None)
		{
			min = TlsProtocolCode.Tls12;
		}
		else
		{
			min = null;
		}
		if ((EnabledProtocols & SslProtocols.Tls12) != SslProtocols.None)
		{
			max = TlsProtocolCode.Tls12;
		}
		else if ((EnabledProtocols & SslProtocols.Tls11) != SslProtocols.None)
		{
			max = TlsProtocolCode.Tls11;
		}
		else if ((EnabledProtocols & SslProtocols.Tls) != SslProtocols.None)
		{
			max = TlsProtocolCode.Tls10;
		}
		else
		{
			max = null;
		}
	}

	public abstract void StartHandshake();

	public abstract bool ProcessHandshake();

	public abstract void FinishHandshake();

	public abstract void Flush();

	public abstract (int ret, bool wantMore) Read(byte[] buffer, int offset, int count);

	public abstract (int ret, bool wantMore) Write(byte[] buffer, int offset, int count);

	public abstract void Shutdown();

	public abstract bool PendingRenegotiation();

	protected bool ValidateCertificate(X509Certificate2 leaf, X509Chain chain)
	{
		ValidationResult validationResult = certificateValidator.ValidateCertificate(TargetHost, IsServer, leaf, chain);
		if (validationResult != null && validationResult.Trusted)
		{
			return !validationResult.UserDenied;
		}
		return false;
	}

	protected X509Certificate SelectServerCertificate(string serverIdentity)
	{
		if (Options.ServerCertSelectionDelegate != null)
		{
			LocalServerCertificate = Options.ServerCertSelectionDelegate(serverIdentity);
			if (LocalServerCertificate == null)
			{
				throw new AuthenticationException("The server mode SSL must use a certificate with the associated private key.");
			}
		}
		else if (Settings.ClientCertificateSelectionCallback != null)
		{
			X509CertificateCollection x509CertificateCollection = new X509CertificateCollection();
			x509CertificateCollection.Add(Options.ServerCertificate);
			LocalServerCertificate = Settings.ClientCertificateSelectionCallback(string.Empty, x509CertificateCollection, null, Array.Empty<string>());
		}
		else
		{
			LocalServerCertificate = Options.ServerCertificate;
		}
		if (LocalServerCertificate == null)
		{
			throw new NotSupportedException("The server mode SSL must use a certificate with the associated private key.");
		}
		return LocalServerCertificate;
	}

	protected X509Certificate SelectClientCertificate(string[] acceptableIssuers)
	{
		if (Settings.DisallowUnauthenticatedCertificateRequest && !IsAuthenticated)
		{
			return null;
		}
		if (RemoteCertificate == null)
		{
			throw new TlsException(AlertDescription.InternalError, "Cannot request client certificate before receiving one from the server.");
		}
		if (certificateValidator.SelectClientCertificate(TargetHost, ClientCertificates, IsAuthenticated ? RemoteCertificate : null, acceptableIssuers, out var clientCertificate))
		{
			return clientCertificate;
		}
		if (ClientCertificates == null || ClientCertificates.Count == 0)
		{
			return null;
		}
		if (acceptableIssuers == null || acceptableIssuers.Length == 0)
		{
			return ClientCertificates[0];
		}
		for (int i = 0; i < ClientCertificates.Count; i++)
		{
			if (!(ClientCertificates[i] is X509Certificate2 x509Certificate))
			{
				continue;
			}
			X509Chain x509Chain = null;
			try
			{
				x509Chain = new X509Chain();
				x509Chain.ChainPolicy.RevocationMode = X509RevocationMode.NoCheck;
				x509Chain.ChainPolicy.VerificationFlags = X509VerificationFlags.IgnoreInvalidName;
				x509Chain.Build(x509Certificate);
				if (x509Chain.ChainElements.Count == 0)
				{
					continue;
				}
				for (int j = 0; j < x509Chain.ChainElements.Count; j++)
				{
					string issuer = x509Chain.ChainElements[j].Certificate.Issuer;
					if (Array.IndexOf(acceptableIssuers, issuer) != -1)
					{
						return x509Certificate;
					}
				}
			}
			catch
			{
			}
			finally
			{
				x509Chain?.Reset();
			}
		}
		return null;
	}

	public abstract void Renegotiate();

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	~MobileTlsContext()
	{
		Dispose(disposing: false);
	}
}
