using Microsoft.Win32.SafeHandles;
using Mono;

namespace System.Security.Cryptography.X509Certificates;

internal static class X509Helper
{
	private static ISystemCertificateProvider CertificateProvider => DependencyInjector.SystemProvider.CertificateProvider;

	public static X509CertificateImpl InitFromCertificate(X509Certificate cert)
	{
		return CertificateProvider.Import(cert);
	}

	public static X509CertificateImpl InitFromCertificate(X509CertificateImpl impl)
	{
		return impl?.Clone();
	}

	public static bool IsValid(X509CertificateImpl impl)
	{
		return impl?.IsValid ?? false;
	}

	internal static void ThrowIfContextInvalid(X509CertificateImpl impl)
	{
		if (!IsValid(impl))
		{
			throw GetInvalidContextException();
		}
	}

	internal static Exception GetInvalidContextException()
	{
		return new CryptographicException(Locale.GetText("Certificate instance is empty."));
	}

	public static X509CertificateImpl Import(byte[] rawData)
	{
		return CertificateProvider.Import(rawData);
	}

	public static X509CertificateImpl Import(byte[] rawData, SafePasswordHandle password, X509KeyStorageFlags keyStorageFlags)
	{
		return CertificateProvider.Import(rawData, password, keyStorageFlags);
	}
}
