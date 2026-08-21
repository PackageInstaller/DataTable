using System.Collections;

namespace System.Security.Cryptography.X509Certificates;

public sealed class X509ChainElementCollection : ICollection, IEnumerable
{
	private ArrayList _list;

	public int Count => _list.Count;

	public bool IsSynchronized => _list.IsSynchronized;

	public X509ChainElement this[int index] => (X509ChainElement)_list[index];

	public object SyncRoot => _list.SyncRoot;

	internal X509ChainElementCollection()
	{
		_list = new ArrayList();
	}

	void ICollection.CopyTo(Array array, int index)
	{
		_list.CopyTo(array, index);
	}

	public X509ChainElementEnumerator GetEnumerator()
	{
		return new X509ChainElementEnumerator(_list);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return new X509ChainElementEnumerator(_list);
	}

	internal void Add(X509Certificate2 certificate)
	{
		_list.Add(new X509ChainElement(certificate));
	}

	internal void Clear()
	{
		_list.Clear();
	}

	internal bool Contains(X509Certificate2 certificate)
	{
		for (int i = 0; i < _list.Count; i++)
		{
			if (certificate.Equals((_list[i] as X509ChainElement).Certificate))
			{
				return true;
			}
		}
		return false;
	}
}
