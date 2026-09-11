using System.Security.Cryptography.X509Certificates;
using Mono.Security.Interface;

namespace Mono.Net.Security;

internal static class SystemCertificateValidator
{
	private static bool is_macosx;

	private static X509KeyUsageFlags s_flags;

	static SystemCertificateValidator()
	{
		s_flags = X509KeyUsageFlags.KeyAgreement | X509KeyUsageFlags.KeyEncipherment | X509KeyUsageFlags.DigitalSignature;
		is_macosx = false;
	}

	internal static bool NeedsChain(MonoTlsSettings settings)
	{
		return false;
	}
}
