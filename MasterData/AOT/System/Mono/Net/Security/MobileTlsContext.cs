using System;
using System.Runtime.CompilerServices;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;
using Mono.Security.Interface;

namespace Mono.Net.Security;

internal abstract class MobileTlsContext : IDisposable
{
	private ChainValidationHelper certificateValidator;

	[CompilerGenerated]
	private readonly MonoSslAuthenticationOptions Options__BackingField;

	[CompilerGenerated]
	private readonly SslProtocols EnabledProtocols__BackingField;

	internal MobileAuthenticatedStream Parent { get; }

	public MonoTlsSettings Settings => Parent.Settings;

	public abstract bool IsAuthenticated { get; }

	public bool IsServer { get; }

	internal string TargetHost { get; }

	protected string ServerName { get; }

	protected bool AskForClientCertificate { get; }

	protected X509CertificateCollection ClientCertificates { get; }

	internal X509Certificate LocalServerCertificate { get; private set; }

	internal abstract X509Certificate LocalClientCertificate { get; }

	public abstract X509Certificate2 RemoteCertificate { get; }

	protected MobileTlsContext(MobileAuthenticatedStream parent, MonoSslAuthenticationOptions options)
	{
		Parent = parent;
		Options__BackingField = options;
		IsServer = options.ServerMode;
		EnabledProtocols__BackingField = options.EnabledSslProtocols;
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

	public abstract void StartHandshake();

	public abstract bool ProcessHandshake();

	public abstract void FinishHandshake();

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
