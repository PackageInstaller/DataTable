using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using Mono.Security.Interface;

namespace Mono.Net.Security.Private;

internal static class CallbackHelpers
{
	internal static MonoRemoteCertificateValidationCallback PublicToMono(RemoteCertificateValidationCallback callback)
	{
		if (callback == null)
		{
			return null;
		}
		return (string h, X509Certificate c, X509Chain ch, MonoSslPolicyErrors e) => callback(h, c, ch, (SslPolicyErrors)e);
	}

	internal static LocalCertSelectionCallback MonoToInternal(MonoLocalCertificateSelectionCallback callback)
	{
		if (callback == null)
		{
			return null;
		}
		return (string t, X509CertificateCollection lc, X509Certificate rc, string[] ai) => callback(t, lc, rc, ai);
	}
}
