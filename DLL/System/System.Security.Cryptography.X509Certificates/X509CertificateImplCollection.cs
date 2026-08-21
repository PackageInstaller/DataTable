using System.Collections.Generic;

namespace System.Security.Cryptography.X509Certificates;

internal class X509CertificateImplCollection : IDisposable
{
	private List<X509CertificateImpl> list;

	public int Count => list.Count;

	public X509CertificateImpl this[int index] => list[index];

	public X509CertificateImplCollection()
	{
		list = new List<X509CertificateImpl>();
	}

	private X509CertificateImplCollection(X509CertificateImplCollection other)
	{
		list = new List<X509CertificateImpl>();
		foreach (X509CertificateImpl item in other.list)
		{
			list.Add(item.Clone());
		}
	}

	public void Add(X509CertificateImpl impl, bool takeOwnership)
	{
		if (!takeOwnership)
		{
			impl = impl.Clone();
		}
		list.Add(impl);
	}

	public X509CertificateImplCollection Clone()
	{
		return new X509CertificateImplCollection(this);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		foreach (X509CertificateImpl item in list)
		{
			try
			{
				item.Dispose();
			}
			catch
			{
			}
		}
		list.Clear();
	}

	~X509CertificateImplCollection()
	{
		Dispose(disposing: false);
	}
}
