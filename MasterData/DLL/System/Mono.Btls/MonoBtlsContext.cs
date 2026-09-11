using System;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using Microsoft.Win32.SafeHandles;
using Mono.Net.Security;
using Mono.Security.Interface;

namespace Mono.Btls;

internal class MonoBtlsContext : MobileTlsContext, IMonoBtlsBioMono
{
	private X509Certificate2 remoteCertificate;

	private X509Certificate clientCertificate;

	private X509CertificateImplBtls nativeServerCertificate;

	private X509CertificateImplBtls nativeClientCertificate;

	private MonoBtlsSslCtx ctx;

	private MonoBtlsSsl ssl;

	private MonoBtlsBio bio;

	private MonoBtlsBio errbio;

	private MonoTlsConnectionInfo connectionInfo;

	private bool certificateValidated;

	private bool isAuthenticated;

	private bool connected;

	public override bool IsAuthenticated => isAuthenticated;

	internal override X509Certificate LocalClientCertificate => clientCertificate;

	public override X509Certificate2 RemoteCertificate => remoteCertificate;

	public MonoBtlsContext(MobileAuthenticatedStream parent, MonoSslAuthenticationOptions options)
		: base(parent, options)
	{
		if (base.IsServer && base.LocalServerCertificate != null)
		{
			nativeServerCertificate = GetPrivateCertificate(base.LocalServerCertificate);
		}
	}

	private static X509CertificateImplBtls GetPrivateCertificate(X509Certificate certificate)
	{
		if (certificate.Impl is X509CertificateImplBtls x509CertificateImplBtls)
		{
			return (X509CertificateImplBtls)x509CertificateImplBtls.Clone();
		}
		string password = Guid.NewGuid().ToString();
		using SafePasswordHandle password2 = new SafePasswordHandle(password);
		return new X509CertificateImplBtls(certificate.Export(X509ContentType.Pfx, password), password2, X509KeyStorageFlags.DefaultKeySet);
	}

	private int VerifyCallback(MonoBtlsX509StoreCtx storeCtx)
	{
		using X509ChainImplBtls impl = new X509ChainImplBtls(storeCtx);
		using X509Chain x509Chain = new X509Chain(impl);
		X509Certificate2 certificate = x509Chain.ChainElements[0].Certificate;
		bool num = ValidateCertificate(certificate, x509Chain);
		certificateValidated = true;
		return num ? 1 : 0;
	}

	private int SelectCallback(string[] acceptableIssuers)
	{
		if (nativeClientCertificate != null)
		{
			return 1;
		}
		GetPeerCertificate();
		X509Certificate x509Certificate = SelectClientCertificate(acceptableIssuers);
		if (x509Certificate == null)
		{
			return 1;
		}
		nativeClientCertificate = GetPrivateCertificate(x509Certificate);
		clientCertificate = new X509Certificate(nativeClientCertificate);
		SetPrivateCertificate(nativeClientCertificate);
		return 1;
	}

	private int ServerNameCallback()
	{
		string serverName = ssl.GetServerName();
		X509Certificate x509Certificate = SelectServerCertificate(serverName);
		if (x509Certificate == null)
		{
			return 1;
		}
		nativeServerCertificate = GetPrivateCertificate(x509Certificate);
		SetPrivateCertificate(nativeServerCertificate);
		return 1;
	}

	public override void StartHandshake()
	{
		InitializeConnection();
		ssl = new MonoBtlsSsl(ctx);
		bio = new MonoBtlsBioMono(this);
		ssl.SetBio(bio);
		if (base.IsServer)
		{
			if (nativeServerCertificate != null)
			{
				SetPrivateCertificate(nativeServerCertificate);
			}
		}
		else
		{
			ssl.SetServerName(base.ServerName);
		}
		if (base.Options.AllowRenegotiation)
		{
			ssl.SetRenegotiateMode(MonoBtlsSslRenegotiateMode.FREELY);
		}
	}

	private void SetPrivateCertificate(X509CertificateImplBtls privateCert)
	{
		ssl.SetCertificate(privateCert.X509);
		ssl.SetPrivateKey(privateCert.NativePrivateKey);
		X509CertificateImplCollection intermediateCertificates = privateCert.IntermediateCertificates;
		if (intermediateCertificates == null)
		{
			X509Chain x509Chain = new X509Chain(useMachineContext: false);
			x509Chain.ChainPolicy.RevocationMode = X509RevocationMode.NoCheck;
			x509Chain.Build(new X509Certificate2(privateCert.X509.GetRawData(MonoBtlsX509Format.DER), ""));
			X509ChainElementCollection chainElements = x509Chain.ChainElements;
			for (int i = 1; i < chainElements.Count; i++)
			{
				X509Certificate2 certificate = chainElements[i].Certificate;
				if (!Enumerable.SequenceEqual(certificate.SubjectName.RawData, certificate.IssuerName.RawData))
				{
					ssl.AddIntermediateCertificate(MonoBtlsX509.LoadFromData(certificate.RawData, MonoBtlsX509Format.DER));
					continue;
				}
				break;
			}
		}
		else
		{
			for (int j = 0; j < intermediateCertificates.Count; j++)
			{
				X509CertificateImplBtls x509CertificateImplBtls = (X509CertificateImplBtls)intermediateCertificates[j];
				ssl.AddIntermediateCertificate(x509CertificateImplBtls.X509);
			}
		}
	}

	private static Exception GetException(MonoBtlsSslError status)
	{
		int error = MonoBtlsError.GetError(out var file, out var line);
		if (error == 0)
		{
			return new MonoBtlsException(status);
		}
		int errorReason = MonoBtlsError.GetErrorReason(error);
		if (errorReason > 0)
		{
			return new TlsException((AlertDescription)errorReason);
		}
		string errorString = MonoBtlsError.GetErrorString(error);
		string message = ((file == null) ? $"{status} {errorString}" : $"{status} {errorString}\n  at {file}:{line}");
		return new MonoBtlsException(message);
	}

	public override bool ProcessHandshake()
	{
		bool flag = false;
		while (!flag)
		{
			MonoBtlsError.ClearError();
			MonoBtlsSslError monoBtlsSslError = DoProcessHandshake();
			switch (monoBtlsSslError)
			{
			case MonoBtlsSslError.None:
				if (connected)
				{
					flag = true;
				}
				else
				{
					connected = true;
				}
				break;
			case MonoBtlsSslError.WantRead:
			case MonoBtlsSslError.WantWrite:
				return false;
			default:
				ctx.CheckLastError("ProcessHandshake");
				throw GetException(monoBtlsSslError);
			}
		}
		ssl.PrintErrors();
		return true;
	}

	private MonoBtlsSslError DoProcessHandshake()
	{
		if (connected)
		{
			return ssl.Handshake();
		}
		if (base.IsServer)
		{
			return ssl.Accept();
		}
		return ssl.Connect();
	}

	public override void FinishHandshake()
	{
		InitializeSession();
		isAuthenticated = true;
	}

	private void InitializeConnection()
	{
		ctx = new MonoBtlsSslCtx();
		MonoBtlsProvider.SetupCertificateStore(ctx.CertificateStore, base.Settings, base.IsServer);
		if (!base.IsServer || base.AskForClientCertificate)
		{
			ctx.SetVerifyCallback(VerifyCallback, client_cert_required: false);
		}
		if (!base.IsServer)
		{
			ctx.SetSelectCallback(SelectCallback);
		}
		if (base.IsServer && (base.Options.ServerCertSelectionDelegate != null || base.Settings.ClientCertificateSelectionCallback != null))
		{
			ctx.SetServerNameCallback(ServerNameCallback);
		}
		ctx.SetVerifyParam(MonoBtlsProvider.GetVerifyParam(base.Settings, base.ServerName, base.IsServer));
		GetProtocolVersions(out var min, out var max);
		if (min.HasValue)
		{
			ctx.SetMinVersion((int)min.Value);
		}
		if (max.HasValue)
		{
			ctx.SetMaxVersion((int)max.Value);
		}
		if (base.Settings != null && base.Settings.EnabledCiphers != null)
		{
			short[] array = new short[base.Settings.EnabledCiphers.Length];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = (short)base.Settings.EnabledCiphers[i];
			}
			ctx.SetCiphers(array, allow_unsupported: true);
		}
		if (base.IsServer && base.Settings?.ClientCertificateIssuers != null)
		{
			ctx.SetClientCertificateIssuers(base.Settings.ClientCertificateIssuers);
		}
	}

	private void GetPeerCertificate()
	{
		if (remoteCertificate != null)
		{
			return;
		}
		using MonoBtlsX509 monoBtlsX = ssl.GetPeerCertificate();
		if (monoBtlsX != null)
		{
			remoteCertificate = MonoBtlsProvider.CreateCertificate(monoBtlsX);
		}
	}

	private void InitializeSession()
	{
		GetPeerCertificate();
		if (base.IsServer && base.AskForClientCertificate && !certificateValidated && !ValidateCertificate(null, null))
		{
			throw new TlsException(AlertDescription.CertificateUnknown);
		}
		CipherSuiteCode cipherSuiteCode = (CipherSuiteCode)ssl.GetCipher();
		TlsProtocolCode protocol = (TlsProtocolCode)ssl.GetVersion();
		string serverName = ssl.GetServerName();
		connectionInfo = new MonoTlsConnectionInfo
		{
			CipherSuiteCode = cipherSuiteCode,
			ProtocolVersion = GetProtocol(protocol),
			PeerDomainName = serverName
		};
	}

	private static TlsProtocols GetProtocol(TlsProtocolCode protocol)
	{
		return protocol switch
		{
			TlsProtocolCode.Tls10 => TlsProtocols.Tls10, 
			TlsProtocolCode.Tls11 => TlsProtocols.Tls11, 
			TlsProtocolCode.Tls12 => TlsProtocols.Tls12, 
			_ => throw new NotSupportedException(), 
		};
	}

	public override void Flush()
	{
		throw new NotImplementedException();
	}

	public override (int ret, bool wantMore) Read(byte[] buffer, int offset, int size)
	{
		IntPtr intPtr = Marshal.AllocHGlobal(size);
		if (intPtr == IntPtr.Zero)
		{
			throw new OutOfMemoryException();
		}
		try
		{
			MonoBtlsError.ClearError();
			MonoBtlsSslError monoBtlsSslError = ssl.Read(intPtr, ref size);
			switch (monoBtlsSslError)
			{
			case MonoBtlsSslError.WantRead:
				return (ret: 0, wantMore: true);
			case MonoBtlsSslError.ZeroReturn:
				return (ret: size, wantMore: false);
			default:
				throw GetException(monoBtlsSslError);
			case MonoBtlsSslError.None:
				if (size > 0)
				{
					Marshal.Copy(intPtr, buffer, offset, size);
				}
				return (ret: size, wantMore: false);
			}
		}
		finally
		{
			Marshal.FreeHGlobal(intPtr);
		}
	}

	public override (int ret, bool wantMore) Write(byte[] buffer, int offset, int size)
	{
		IntPtr intPtr = Marshal.AllocHGlobal(size);
		if (intPtr == IntPtr.Zero)
		{
			throw new OutOfMemoryException();
		}
		try
		{
			MonoBtlsError.ClearError();
			Marshal.Copy(buffer, offset, intPtr, size);
			MonoBtlsSslError monoBtlsSslError = ssl.Write(intPtr, ref size);
			return monoBtlsSslError switch
			{
				MonoBtlsSslError.WantWrite => (ret: 0, wantMore: true), 
				MonoBtlsSslError.None => (ret: size, wantMore: false), 
				_ => throw GetException(monoBtlsSslError), 
			};
		}
		finally
		{
			Marshal.FreeHGlobal(intPtr);
		}
	}

	public override void Renegotiate()
	{
		throw new NotSupportedException();
	}

	public override void Shutdown()
	{
		if (base.Settings == null || !base.Settings.SendCloseNotify)
		{
			ssl.SetQuietShutdown();
		}
		ssl.Shutdown();
	}

	public override bool PendingRenegotiation()
	{
		return ssl.RenegotiatePending();
	}

	private void Dispose<T>(ref T disposable) where T : class, IDisposable
	{
		try
		{
			if (disposable != null)
			{
				disposable.Dispose();
			}
		}
		catch
		{
		}
		finally
		{
			disposable = null;
		}
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (disposing)
			{
				Dispose(ref ssl);
				Dispose(ref ctx);
				Dispose(ref remoteCertificate);
				Dispose(ref nativeServerCertificate);
				Dispose(ref nativeClientCertificate);
				Dispose(ref clientCertificate);
				Dispose(ref bio);
				Dispose(ref errbio);
			}
		}
		finally
		{
			base.Dispose(disposing);
		}
	}

	int IMonoBtlsBioMono.Read(byte[] buffer, int offset, int size, out bool wantMore)
	{
		return base.Parent.InternalRead(buffer, offset, size, out wantMore);
	}

	bool IMonoBtlsBioMono.Write(byte[] buffer, int offset, int size)
	{
		return base.Parent.InternalWrite(buffer, offset, size);
	}

	void IMonoBtlsBioMono.Flush()
	{
	}

	void IMonoBtlsBioMono.Close()
	{
	}
}
