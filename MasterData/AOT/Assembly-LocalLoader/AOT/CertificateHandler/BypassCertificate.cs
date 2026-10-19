using UnityEngine.Networking;

namespace AOT.CertificateHandler;

public class BypassCertificate : UnityEngine.Networking.CertificateHandler
{
	protected override bool ValidateCertificate(byte[] certificateData)
	{
		return true;
	}
}
