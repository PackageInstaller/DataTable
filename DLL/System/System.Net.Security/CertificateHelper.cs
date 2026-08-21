using System.Security.Cryptography.X509Certificates;

namespace System.Net.Security;

internal static class CertificateHelper
{
	internal static X509Certificate2 GetEligibleClientCertificate()
	{
		X509Certificate2Collection certificates;
		using (X509Store x509Store = new X509Store(StoreName.My, StoreLocation.CurrentUser))
		{
			x509Store.Open(OpenFlags.ReadOnly);
			certificates = x509Store.Certificates;
		}
		return GetEligibleClientCertificate(certificates);
	}

	internal static X509Certificate2 GetEligibleClientCertificate(X509CertificateCollection candidateCerts)
	{
		if (candidateCerts.Count == 0)
		{
			return null;
		}
		X509Certificate2Collection x509Certificate2Collection = new X509Certificate2Collection();
		x509Certificate2Collection.AddRange(candidateCerts);
		return GetEligibleClientCertificate(x509Certificate2Collection);
	}

	internal static X509Certificate2 GetEligibleClientCertificate(X509Certificate2Collection candidateCerts)
	{
		if (candidateCerts.Count == 0)
		{
			return null;
		}
		X509Certificate2Collection x509Certificate2Collection = new X509Certificate2Collection();
		foreach (X509Certificate2 candidateCert in candidateCerts)
		{
			if (candidateCert.HasPrivateKey)
			{
				x509Certificate2Collection.Add(candidateCert);
			}
		}
		if (x509Certificate2Collection.Count == 0)
		{
			return null;
		}
		x509Certificate2Collection = x509Certificate2Collection.Find(X509FindType.FindByApplicationPolicy, "1.3.6.1.5.5.7.3.2", validOnly: false);
		x509Certificate2Collection = x509Certificate2Collection.Find(X509FindType.FindByKeyUsage, X509KeyUsageFlags.DigitalSignature, validOnly: false);
		if (x509Certificate2Collection.Count > 0)
		{
			return x509Certificate2Collection[0];
		}
		return null;
	}
}
