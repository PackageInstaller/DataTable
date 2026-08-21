using System.Security.Cryptography.X509Certificates;
using Microsoft.Win32.SafeHandles;

namespace Mono;

internal class X509PalImplMono : X509PalImpl
{
	public override X509CertificateImpl Import(byte[] data)
	{
		return ImportFallback(data);
	}

	public override X509Certificate2Impl Import(byte[] data, SafePasswordHandle password, X509KeyStorageFlags keyStorageFlags)
	{
		return ImportFallback(data, password, keyStorageFlags);
	}

	public override X509Certificate2Impl Import(X509Certificate cert)
	{
		return null;
	}
}
