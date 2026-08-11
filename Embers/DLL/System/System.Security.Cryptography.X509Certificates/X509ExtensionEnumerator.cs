using System.Collections;

namespace System.Security.Cryptography.X509Certificates;

public sealed class X509ExtensionEnumerator : IEnumerator
{
	private IEnumerator enumerator;

	public X509Extension Current => (X509Extension)enumerator.Current;

	object IEnumerator.Current => enumerator.Current;

	internal X509ExtensionEnumerator(ArrayList list)
	{
		enumerator = list.GetEnumerator();
	}

	public bool MoveNext()
	{
		return enumerator.MoveNext();
	}

	public void Reset()
	{
		enumerator.Reset();
	}
}
