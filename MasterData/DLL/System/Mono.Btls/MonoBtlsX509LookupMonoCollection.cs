using System.Security.Cryptography.X509Certificates;

namespace Mono.Btls;

internal class MonoBtlsX509LookupMonoCollection : MonoBtlsX509LookupMono
{
	private long[] hashes;

	private MonoBtlsX509[] certificates;

	private X509CertificateCollection collection;

	private MonoBtlsX509TrustKind trust;

	internal MonoBtlsX509LookupMonoCollection(X509CertificateCollection collection, MonoBtlsX509TrustKind trust)
	{
		this.collection = collection;
		this.trust = trust;
	}

	private void Initialize()
	{
		if (certificates == null)
		{
			hashes = new long[collection.Count];
			certificates = new MonoBtlsX509[collection.Count];
			for (int i = 0; i < collection.Count; i++)
			{
				byte[] rawCertData = collection[i].GetRawCertData();
				certificates[i] = MonoBtlsX509.LoadFromData(rawCertData, MonoBtlsX509Format.DER);
				certificates[i].AddExplicitTrust(trust);
				hashes[i] = certificates[i].GetSubjectNameHash();
			}
		}
	}

	protected override MonoBtlsX509 OnGetBySubject(MonoBtlsX509Name name)
	{
		Initialize();
		long hash = name.GetHash();
		MonoBtlsX509 monoBtlsX = null;
		for (int i = 0; i < certificates.Length; i++)
		{
			if (hashes[i] == hash)
			{
				monoBtlsX = certificates[i];
				AddCertificate(monoBtlsX);
			}
		}
		return monoBtlsX;
	}

	protected override void Close()
	{
		try
		{
			if (certificates == null)
			{
				return;
			}
			for (int i = 0; i < certificates.Length; i++)
			{
				if (certificates[i] != null)
				{
					certificates[i].Dispose();
					certificates[i] = null;
				}
			}
			certificates = null;
			hashes = null;
		}
		finally
		{
			base.Close();
		}
	}
}
