using System.Security.Cryptography.X509Certificates;
using Microsoft.Win32.SafeHandles;

namespace Mono;

internal interface ISystemCertificateProvider
{
	X509CertificateImpl Import(byte[] data, CertificateImportFlags importFlags = CertificateImportFlags.None);

	X509CertificateImpl Import(byte[] data, SafePasswordHandle password, X509KeyStorageFlags keyStorageFlags, CertificateImportFlags importFlags = CertificateImportFlags.None);

	X509CertificateImpl Import(X509Certificate cert, CertificateImportFlags importFlags = CertificateImportFlags.None);
}
