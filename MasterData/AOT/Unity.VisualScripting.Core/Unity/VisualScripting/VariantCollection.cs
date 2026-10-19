using System;
using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public class VariantCollection<TBase, TImplementation> : ICollection<TBase>, IEnumerable<TBase>, IEnumerable where TImplementation : TBase
{
	public ICollection<TImplementation> implementation { get; private set; }

	public int Count => implementation.Count;

	public bool IsReadOnly => implementation.IsReadOnly;

	public VariantCollection(ICollection<TImplementation> implementation)
	{
		if (implementation == null)
		{
			throw new ArgumentNullException("implementation");
		}
		this.implementation = implementation;
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public IEnumerator<TBase> GetEnumerator()
	{
		foreach (TImplementation item in implementation)
		{
			yield return (TBase)(object)item;
		}
	}

	public void Add(TBase item)
	{
		if (!(item is TImplementation))
		{
			throw new NotSupportedException();
		}
		implementation.Add((TImplementation)(object)item);
	}

	public void Clear()
	{
		implementation.Clear();
	}

	public bool Contains(TBase item)
	{
		if (!(item is TImplementation))
		{
			throw new NotSupportedException();
		}
		return implementation.Contains((TImplementation)(object)item);
	}

	public bool Remove(TBase item)
	{
		if (!(item is TImplementation))
		{
			throw new NotSupportedException();
		}
		return implementation.Remove((TImplementation)(object)item);
	}

	public void CopyTo(TBase[] array, int arrayIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (arrayIndex < 0)
		{
			throw new ArgumentOutOfRangeException("arrayIndex");
		}
		if (array.Length - arrayIndex < Count)
		{
			throw new ArgumentException();
		}
		TImplementation[] array2 = new TImplementation[Count];
		implementation.CopyTo(array2, 0);
		for (int i = 0; i < Count; i++)
		{
			array[i + arrayIndex] = (TBase)(object)array2[i];
		}
	}
}
