using System.Security.Cryptography.X509Certificates;
using System.Threading;
using Microsoft.Win32.SafeHandles;
using Mono.Btls;
using Mono.Net.Security;
using Mono.Security.Interface;

namespace Mono;

internal class SystemCertificateProvider : ISystemCertificateProvider
{
	private static MonoTlsProvider provider;

	private static int initialized;

	private static X509PalImpl x509pal;

	private static object syncRoot = new object();

	public X509PalImpl X509Pal
	{
		get
		{
			EnsureInitialized();
			return x509pal;
		}
	}

	private static X509PalImpl GetX509Pal()
	{
		if (provider?.ID == Mono.Net.Security.MonoTlsProviderFactory.BtlsId)
		{
			return new X509PalImplBtls(provider);
		}
		return new X509PalImplMono();
	}

	private static void EnsureInitialized()
	{
		lock (syncRoot)
		{
			if (Interlocked.CompareExchange(ref initialized, 1, 0) == 0)
			{
				provider = Mono.Security.Interface.MonoTlsProviderFactory.GetProvider();
				x509pal = GetX509Pal();
			}
		}
	}

	public X509CertificateImpl Import(byte[] data, CertificateImportFlags importFlags = CertificateImportFlags.None)
	{
		if (data == null || data.Length == 0)
		{
			return null;
		}
		X509CertificateImpl x509CertificateImpl = null;
		if ((importFlags & CertificateImportFlags.DisableNativeBackend) == 0)
		{
			x509CertificateImpl = X509Pal.Import(data);
			if (x509CertificateImpl != null)
			{
				return x509CertificateImpl;
			}
		}
		if ((importFlags & CertificateImportFlags.DisableAutomaticFallback) != CertificateImportFlags.None)
		{
			return null;
		}
		return X509Pal.ImportFallback(data);
	}

	X509CertificateImpl ISystemCertificateProvider.Import(byte[] data, SafePasswordHandle password, X509KeyStorageFlags keyStorageFlags, CertificateImportFlags importFlags)
	{
		return Import(data, password, keyStorageFlags, importFlags);
	}

	public X509Certificate2Impl Import(byte[] data, SafePasswordHandle password, X509KeyStorageFlags keyStorageFlags, CertificateImportFlags importFlags = CertificateImportFlags.None)
	{
		if (data == null || data.Length == 0)
		{
			return null;
		}
		X509Certificate2Impl x509Certificate2Impl = null;
		if ((importFlags & CertificateImportFlags.DisableNativeBackend) == 0)
		{
			x509Certificate2Impl = X509Pal.Import(data, password, keyStorageFlags);
			if (x509Certificate2Impl != null)
			{
				return x509Certificate2Impl;
			}
		}
		if ((importFlags & CertificateImportFlags.DisableAutomaticFallback) != CertificateImportFlags.None)
		{
			return null;
		}
		return X509Pal.ImportFallback(data, password, keyStorageFlags);
	}

	X509CertificateImpl ISystemCertificateProvider.Import(X509Certificate cert, CertificateImportFlags importFlags)
	{
		return Import(cert, importFlags);
	}

	public X509Certificate2Impl Import(X509Certificate cert, CertificateImportFlags importFlags = CertificateImportFlags.None)
	{
		if (cert.Impl == null)
		{
			return null;
		}
		if (cert.Impl is X509Certificate2Impl x509Certificate2Impl)
		{
			return (X509Certificate2Impl)x509Certificate2Impl.Clone();
		}
		if ((importFlags & CertificateImportFlags.DisableNativeBackend) == 0)
		{
			X509Certificate2Impl x509Certificate2Impl2 = X509Pal.Import(cert);
			if (x509Certificate2Impl2 != null)
			{
				return x509Certificate2Impl2;
			}
		}
		if ((importFlags & CertificateImportFlags.DisableAutomaticFallback) != CertificateImportFlags.None)
		{
			return null;
		}
		return X509Pal.ImportFallback(cert.GetRawCertData());
	}
}
