using System.Security.Cryptography.X509Certificates;

namespace System.Net;

public interface ICertificatePolicy
{
	bool CheckValidationResult(ServicePoint srvPoint, X509Certificate certificate, WebRequest request, int certificateProblem);
}
