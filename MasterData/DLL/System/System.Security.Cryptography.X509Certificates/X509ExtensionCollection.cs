using System.Collections;

namespace System.Security.Cryptography.X509Certificates;

public sealed class X509ExtensionCollection : ICollection, IEnumerable
{
	private static byte[] Empty = new byte[0];

	private ArrayList _list;

	public int Count => _list.Count;

	public bool IsSynchronized => _list.IsSynchronized;

	public object SyncRoot => this;

	public X509Extension this[string oid]
	{
		get
		{
			if (oid == null)
			{
				throw new ArgumentNullException("oid");
			}
			if (_list.Count == 0 || oid.Length == 0)
			{
				return null;
			}
			foreach (X509Extension item in _list)
			{
				if (item.Oid.Value.Equals(oid))
				{
					return item;
				}
			}
			return null;
		}
	}

	public X509ExtensionCollection()
	{
		_list = new ArrayList();
	}

	public int Add(X509Extension extension)
	{
		if (extension == null)
		{
			throw new ArgumentNullException("extension");
		}
		return _list.Add(extension);
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("negative index");
		}
		if (index >= array.Length)
		{
			throw new ArgumentOutOfRangeException("index >= array.Length");
		}
		_list.CopyTo(array, index);
	}

	public X509ExtensionEnumerator GetEnumerator()
	{
		return new X509ExtensionEnumerator(_list);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return new X509ExtensionEnumerator(_list);
	}
}
