using System.Collections;
using System.Collections.Generic;

namespace System.Security.Cryptography;

public sealed class OidCollection : ICollection, IEnumerable
{
	private readonly List<Oid> _list;

	public Oid this[int index] => _list[index];

	public int Count => _list.Count;

	public bool IsSynchronized => false;

	public object SyncRoot => this;

	public OidCollection()
	{
		_list = new List<Oid>();
	}

	public int Add(Oid oid)
	{
		int count = _list.Count;
		_list.Add(oid);
		return count;
	}

	public OidEnumerator GetEnumerator()
	{
		return new OidEnumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.");
		}
		if (index < 0 || index >= array.Length)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (index + Count > array.Length)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		for (int i = 0; i < Count; i++)
		{
			array.SetValue(this[i], index);
			index++;
		}
	}
}
