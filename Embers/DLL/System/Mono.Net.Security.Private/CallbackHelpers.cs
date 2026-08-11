using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using Mono.Security.Interface;

namespace Mono.Net.Security.Private;

internal static class CallbackHelpers
{
	internal static MonoRemoteCertificateValidationCallback PublicToMono(RemoteCertificateValidationCallback callback)
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Expected O, but got Unknown
		if (callback == null)
		{
			return null;
		}
		return (MonoRemoteCertificateValidationCallback)delegate(string h, X509Certificate c, X509Chain ch, MonoSslPolicyErrors e)
		{
			//IL_0009: Unknown result type (might be due to invalid IL or missing references)
			//IL_0010: Expected I4, but got Unknown
			return callback(h, c, ch, (SslPolicyErrors)e);
		};
	}

	internal static LocalCertSelectionCallback MonoToInternal(MonoLocalCertificateSelectionCallback callback)
	{
		if (callback == null)
		{
			return null;
		}
		return (string t, X509CertificateCollection lc, X509Certificate rc, string[] ai) => callback.Invoke(t, lc, rc, ai);
	}
}
