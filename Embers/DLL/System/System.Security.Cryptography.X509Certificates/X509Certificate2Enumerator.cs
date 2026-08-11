using System.Collections;

namespace System.Security.Cryptography.X509Certificates;

public sealed class X509Certificate2Enumerator : IEnumerator
{
	private IEnumerator enumerator;

	public X509Certificate2 Current => (X509Certificate2)enumerator.Current;

	object IEnumerator.Current => enumerator.Current;

	internal X509Certificate2Enumerator(X509Certificate2Collection collection)
	{
		enumerator = ((IEnumerable)collection).GetEnumerator();
	}

	public bool MoveNext()
	{
		return enumerator.MoveNext();
	}

	bool IEnumerator.MoveNext()
	{
		return enumerator.MoveNext();
	}

	void IEnumerator.Reset()
	{
		enumerator.Reset();
	}
}
