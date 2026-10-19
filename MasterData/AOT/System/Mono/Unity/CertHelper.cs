using System;
using System.Security.Cryptography.X509Certificates;

namespace Mono.Unity;

internal static class CertHelper
{
	public unsafe static void AddCertificatesToNativeChain(UnityTls.unitytls_x509list* nativeCertificateChain, X509CertificateCollection certificates, UnityTls.unitytls_errorstate* errorState)
	{
		foreach (X509Certificate certificate in certificates)
		{
			AddCertificateToNativeChain(nativeCertificateChain, certificate, errorState);
		}
	}

	public unsafe static void AddCertificateToNativeChain(UnityTls.unitytls_x509list* nativeCertificateChain, X509Certificate certificate, UnityTls.unitytls_errorstate* errorState)
	{
		byte[] rawCertData = certificate.GetRawCertData();
		fixed (byte* buffer = rawCertData)
		{
			UnityTls.NativeInterface.unitytls_x509list_append_der(nativeCertificateChain, buffer, (IntPtr)rawCertData.Length, errorState);
		}
		if (certificate.Impl is X509Certificate2Impl { IntermediateCertificates: { Count: >0 } intermediateCertificates })
		{
			for (int i = 0; i < intermediateCertificates.Count; i++)
			{
				AddCertificateToNativeChain(nativeCertificateChain, new X509Certificate(intermediateCertificates[i]), errorState);
			}
		}
	}
}
