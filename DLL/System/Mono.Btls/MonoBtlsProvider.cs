using System;
using System.IO;
using System.Net.Security;
using System.Security.Authentication;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using Microsoft.Win32.SafeHandles;
using Mono.Net.Security;
using Mono.Security.Interface;

namespace Mono.Btls;

internal class MonoBtlsProvider : MobileTlsProvider
{
	public override Guid ID => Mono.Net.Security.MonoTlsProviderFactory.BtlsId;

	public override string Name => "btls";

	public override bool SupportsSslStream => true;

	public override bool SupportsMonoExtensions => true;

	public override bool SupportsConnectionInfo => true;

	internal override bool SupportsCleanShutdown => true;

	public override SslProtocols SupportedProtocols => SslProtocols.Tls | SslProtocols.Tls11 | SslProtocols.Tls12;

	internal MonoBtlsProvider()
	{
		if (!Mono.Net.Security.MonoTlsProviderFactory.IsBtlsSupported())
		{
			throw new NotSupportedException("BTLS is not supported in this runtime.");
		}
	}

	internal override MobileAuthenticatedStream CreateSslStream(SslStream sslStream, Stream innerStream, bool leaveInnerStreamOpen, MonoTlsSettings settings)
	{
		return new MonoBtlsStream(innerStream, leaveInnerStreamOpen, sslStream, settings, this);
	}

	internal X509Certificate2Impl GetNativeCertificate(byte[] data, string password, X509KeyStorageFlags flags)
	{
		using SafePasswordHandle password2 = new SafePasswordHandle(password);
		return GetNativeCertificate(data, password2, flags);
	}

	internal X509Certificate2Impl GetNativeCertificate(X509Certificate certificate)
	{
		if (certificate.Impl is X509CertificateImplBtls x509CertificateImplBtls)
		{
			return (X509Certificate2Impl)x509CertificateImplBtls.Clone();
		}
		return new X509CertificateImplBtls(certificate.GetRawCertData(), MonoBtlsX509Format.DER);
	}

	internal X509Certificate2Impl GetNativeCertificate(byte[] data, SafePasswordHandle password, X509KeyStorageFlags flags)
	{
		return new X509CertificateImplBtls(data, password, flags);
	}

	internal static MonoBtlsX509VerifyParam GetVerifyParam(MonoTlsSettings settings, string targetHost, bool serverMode)
	{
		MonoBtlsX509VerifyParam monoBtlsX509VerifyParam = ((!serverMode) ? MonoBtlsX509VerifyParam.GetSslServer() : MonoBtlsX509VerifyParam.GetSslClient());
		if (targetHost == null && (settings == null || !settings.CertificateValidationTime.HasValue))
		{
			return monoBtlsX509VerifyParam;
		}
		try
		{
			MonoBtlsX509VerifyParam monoBtlsX509VerifyParam2 = monoBtlsX509VerifyParam.Copy();
			if (targetHost != null)
			{
				monoBtlsX509VerifyParam2.SetHost(targetHost);
			}
			if (settings != null && settings.CertificateValidationTime.HasValue)
			{
				monoBtlsX509VerifyParam2.SetTime(settings.CertificateValidationTime.Value);
			}
			return monoBtlsX509VerifyParam2;
		}
		finally
		{
			monoBtlsX509VerifyParam.Dispose();
		}
	}

	internal override bool ValidateCertificate(ChainValidationHelper validator, string targetHost, bool serverMode, X509CertificateCollection certificates, bool wantsChain, ref X509Chain chain, ref SslPolicyErrors errors, ref int status11)
	{
		if (Environment.OSVersion.Platform == PlatformID.Unix && Environment.GetEnvironmentVariable("UNITY_THISISABUILDMACHINE") != null)
		{
			return true;
		}
		if (chain != null)
		{
			X509ChainImplBtls x509ChainImplBtls = (X509ChainImplBtls)chain.Impl;
			bool flag = x509ChainImplBtls.StoreCtx.VerifyResult == 1;
			CheckValidationResult(validator, targetHost, serverMode, certificates, wantsChain, chain, x509ChainImplBtls.StoreCtx, flag, ref errors, ref status11);
			return flag;
		}
		using MonoBtlsX509Store store = new MonoBtlsX509Store();
		using MonoBtlsX509Chain chain2 = GetNativeChain(certificates);
		using MonoBtlsX509VerifyParam verifyParam = GetVerifyParam(validator.Settings, targetHost, serverMode);
		using MonoBtlsX509StoreCtx monoBtlsX509StoreCtx = new MonoBtlsX509StoreCtx();
		SetupCertificateStore(store, validator.Settings, serverMode);
		monoBtlsX509StoreCtx.Initialize(store, chain2);
		monoBtlsX509StoreCtx.SetVerifyParam(verifyParam);
		bool flag2 = monoBtlsX509StoreCtx.Verify() == 1;
		if (wantsChain && chain == null)
		{
			chain = GetManagedChain(chain2);
		}
		CheckValidationResult(validator, targetHost, serverMode, certificates, wantsChain, null, monoBtlsX509StoreCtx, flag2, ref errors, ref status11);
		return flag2;
	}

	internal static bool ValidateCertificate(MonoBtlsX509Chain chain, MonoBtlsX509VerifyParam param)
	{
		using MonoBtlsX509Store store = new MonoBtlsX509Store();
		using MonoBtlsX509StoreCtx monoBtlsX509StoreCtx = new MonoBtlsX509StoreCtx();
		SetupCertificateStore(store, MonoTlsSettings.DefaultSettings, server: false);
		monoBtlsX509StoreCtx.Initialize(store, chain);
		if (param != null)
		{
			monoBtlsX509StoreCtx.SetVerifyParam(param);
		}
		return monoBtlsX509StoreCtx.Verify() == 1;
	}

	private void CheckValidationResult(ChainValidationHelper validator, string targetHost, bool serverMode, X509CertificateCollection certificates, bool wantsChain, X509Chain chain, MonoBtlsX509StoreCtx storeCtx, bool success, ref SslPolicyErrors errors, ref int status11)
	{
		status11 = 0;
		if (success)
		{
			return;
		}
		errors = SslPolicyErrors.RemoteCertificateChainErrors;
		if (!wantsChain || storeCtx == null || chain == null)
		{
			status11 = -2146762485;
			return;
		}
		MonoBtlsX509Error error = storeCtx.GetError();
		switch (error)
		{
		case MonoBtlsX509Error.OK:
			errors = SslPolicyErrors.None;
			break;
		case MonoBtlsX509Error.HOSTNAME_MISMATCH:
			errors = SslPolicyErrors.RemoteCertificateNameMismatch;
			chain.Impl.AddStatus(X509ChainStatusFlags.UntrustedRoot);
			status11 = -2146762485;
			break;
		default:
			chain.Impl.AddStatus(MapVerifyErrorToChainStatus(error));
			status11 = -2146762485;
			break;
		case MonoBtlsX509Error.CRL_NOT_YET_VALID:
			break;
		}
	}

	internal static X509ChainStatusFlags MapVerifyErrorToChainStatus(MonoBtlsX509Error code)
	{
		switch (code)
		{
		case MonoBtlsX509Error.OK:
			return X509ChainStatusFlags.NoError;
		case MonoBtlsX509Error.CERT_NOT_YET_VALID:
		case MonoBtlsX509Error.CERT_HAS_EXPIRED:
		case MonoBtlsX509Error.ERROR_IN_CERT_NOT_BEFORE_FIELD:
		case MonoBtlsX509Error.ERROR_IN_CERT_NOT_AFTER_FIELD:
			return X509ChainStatusFlags.NotTimeValid;
		case MonoBtlsX509Error.CERT_REVOKED:
			return X509ChainStatusFlags.Revoked;
		case MonoBtlsX509Error.UNABLE_TO_DECODE_ISSUER_PUBLIC_KEY:
		case MonoBtlsX509Error.CERT_SIGNATURE_FAILURE:
			return X509ChainStatusFlags.NotSignatureValid;
		case MonoBtlsX509Error.DEPTH_ZERO_SELF_SIGNED_CERT:
		case MonoBtlsX509Error.SELF_SIGNED_CERT_IN_CHAIN:
		case MonoBtlsX509Error.CERT_UNTRUSTED:
			return X509ChainStatusFlags.UntrustedRoot;
		case MonoBtlsX509Error.CRL_HAS_EXPIRED:
			return X509ChainStatusFlags.OfflineRevocation;
		case MonoBtlsX509Error.UNABLE_TO_GET_CRL:
		case MonoBtlsX509Error.UNABLE_TO_DECRYPT_CRL_SIGNATURE:
		case MonoBtlsX509Error.CRL_SIGNATURE_FAILURE:
		case MonoBtlsX509Error.CRL_NOT_YET_VALID:
		case MonoBtlsX509Error.ERROR_IN_CRL_LAST_UPDATE_FIELD:
		case MonoBtlsX509Error.ERROR_IN_CRL_NEXT_UPDATE_FIELD:
		case MonoBtlsX509Error.UNABLE_TO_GET_CRL_ISSUER:
		case MonoBtlsX509Error.KEYUSAGE_NO_CRL_SIGN:
		case MonoBtlsX509Error.UNHANDLED_CRITICAL_CRL_EXTENSION:
			return X509ChainStatusFlags.RevocationStatusUnknown;
		case MonoBtlsX509Error.INVALID_EXTENSION:
			return X509ChainStatusFlags.InvalidExtension;
		case MonoBtlsX509Error.UNABLE_TO_GET_ISSUER_CERT:
		case MonoBtlsX509Error.UNABLE_TO_GET_ISSUER_CERT_LOCALLY:
		case MonoBtlsX509Error.UNABLE_TO_VERIFY_LEAF_SIGNATURE:
			return X509ChainStatusFlags.PartialChain;
		case MonoBtlsX509Error.INVALID_PURPOSE:
			return X509ChainStatusFlags.NotValidForUsage;
		case MonoBtlsX509Error.INVALID_CA:
		case MonoBtlsX509Error.PATH_LENGTH_EXCEEDED:
		case MonoBtlsX509Error.KEYUSAGE_NO_CERTSIGN:
		case MonoBtlsX509Error.INVALID_NON_CA:
		case MonoBtlsX509Error.KEYUSAGE_NO_DIGITAL_SIGNATURE:
			return X509ChainStatusFlags.InvalidBasicConstraints;
		case MonoBtlsX509Error.INVALID_POLICY_EXTENSION:
		case MonoBtlsX509Error.NO_EXPLICIT_POLICY:
			return X509ChainStatusFlags.InvalidPolicyConstraints;
		case MonoBtlsX509Error.CERT_REJECTED:
			return X509ChainStatusFlags.ExplicitDistrust;
		case MonoBtlsX509Error.UNHANDLED_CRITICAL_EXTENSION:
			return X509ChainStatusFlags.HasNotSupportedCriticalExtension;
		case MonoBtlsX509Error.HOSTNAME_MISMATCH:
			return X509ChainStatusFlags.UntrustedRoot;
		case MonoBtlsX509Error.CERT_CHAIN_TOO_LONG:
			throw new CryptographicException();
		case MonoBtlsX509Error.OUT_OF_MEM:
			throw new OutOfMemoryException();
		default:
			throw new CryptographicException("Unrecognized X509VerifyStatusCode:" + code);
		}
	}

	internal static void SetupCertificateStore(MonoBtlsX509Store store, MonoTlsSettings settings, bool server)
	{
		if (server || settings?.CertificateSearchPaths == null)
		{
			AddTrustedRoots(store, settings, server);
			if (!server)
			{
				SetupDefaultCertificateStore(store);
			}
			return;
		}
		string[] certificateSearchPaths = settings.CertificateSearchPaths;
		foreach (string text in certificateSearchPaths)
		{
			switch (text)
			{
			case "@default":
				AddTrustedRoots(store, settings, server);
				AddUserStore(store);
				AddMachineStore(store);
				continue;
			case "@trusted":
				AddTrustedRoots(store, settings, server);
				continue;
			case "@user":
				AddUserStore(store);
				continue;
			case "@machine":
				AddMachineStore(store);
				continue;
			}
			if (text.StartsWith("@pem:"))
			{
				string text2 = text.Substring(5);
				if (Directory.Exists(text2))
				{
					store.AddDirectoryLookup(text2, MonoBtlsX509FileType.PEM);
				}
				continue;
			}
			if (text.StartsWith("@der:"))
			{
				string text3 = text.Substring(5);
				if (Directory.Exists(text3))
				{
					store.AddDirectoryLookup(text3, MonoBtlsX509FileType.ASN1);
				}
				continue;
			}
			throw new NotSupportedException($"Invalid item `{text}' in MonoTlsSettings.CertificateSearchPaths.");
		}
	}

	private static void SetupDefaultCertificateStore(MonoBtlsX509Store store)
	{
		AddUserStore(store);
		AddMachineStore(store);
	}

	private static void AddUserStore(MonoBtlsX509Store store)
	{
		string storePath = MonoBtlsX509StoreManager.GetStorePath(MonoBtlsX509StoreType.UserTrustedRoots);
		if (Directory.Exists(storePath))
		{
			store.AddDirectoryLookup(storePath, MonoBtlsX509FileType.PEM);
		}
	}

	private static void AddMachineStore(MonoBtlsX509Store store)
	{
		string storePath = MonoBtlsX509StoreManager.GetStorePath(MonoBtlsX509StoreType.MachineTrustedRoots);
		if (Directory.Exists(storePath))
		{
			store.AddDirectoryLookup(storePath, MonoBtlsX509FileType.PEM);
		}
	}

	private static void AddTrustedRoots(MonoBtlsX509Store store, MonoTlsSettings settings, bool server)
	{
		if (settings?.TrustAnchors != null)
		{
			MonoBtlsX509TrustKind trust = (server ? MonoBtlsX509TrustKind.TRUST_CLIENT : MonoBtlsX509TrustKind.TRUST_SERVER);
			store.AddCollection(settings.TrustAnchors, trust);
		}
	}

	public static X509Certificate2 CreateCertificate(MonoBtlsX509 x509)
	{
		using X509CertificateImplBtls impl = new X509CertificateImplBtls(x509);
		return new X509Certificate2(impl);
	}

	public static X509Chain GetManagedChain(MonoBtlsX509Chain chain)
	{
		return new X509Chain(new X509ChainImplBtls(chain));
	}

	public static MonoBtlsX509 GetBtlsCertificate(X509Certificate certificate)
	{
		if (certificate.Impl is X509CertificateImplBtls x509CertificateImplBtls)
		{
			return x509CertificateImplBtls.X509.Copy();
		}
		return MonoBtlsX509.LoadFromData(certificate.GetRawCertData(), MonoBtlsX509Format.DER);
	}

	public static MonoBtlsX509Chain GetNativeChain(X509CertificateCollection certificates)
	{
		MonoBtlsX509Chain monoBtlsX509Chain = new MonoBtlsX509Chain();
		try
		{
			foreach (X509Certificate certificate in certificates)
			{
				using MonoBtlsX509 x = GetBtlsCertificate(certificate);
				monoBtlsX509Chain.AddCertificate(x);
			}
			return monoBtlsX509Chain;
		}
		catch
		{
			monoBtlsX509Chain.Dispose();
			throw;
		}
	}
}
