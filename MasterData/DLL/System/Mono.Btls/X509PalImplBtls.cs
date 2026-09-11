using System.Security.Cryptography.X509Certificates;
using Microsoft.Win32.SafeHandles;
using Mono.Security.Interface;

namespace Mono.Btls;

internal class X509PalImplBtls : X509PalImpl
{
	private MonoBtlsProvider Provider { get; }

	public X509PalImplBtls(MonoTlsProvider provider)
	{
		Provider = (MonoBtlsProvider)provider;
	}

	public override X509CertificateImpl Import(byte[] data)
	{
		return Provider.GetNativeCertificate(data, (string)null, X509KeyStorageFlags.DefaultKeySet);
	}

	public override X509Certificate2Impl Import(byte[] data, SafePasswordHandle password, X509KeyStorageFlags keyStorageFlags)
	{
		return Provider.GetNativeCertificate(data, password, keyStorageFlags);
	}

	public override X509Certificate2Impl Import(X509Certificate cert)
	{
		return Provider.GetNativeCertificate(cert);
	}
}
