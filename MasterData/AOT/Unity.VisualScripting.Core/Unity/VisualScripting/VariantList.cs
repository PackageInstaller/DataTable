using System;
using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public class VariantList<TBase, TImplementation> : IList<TBase>, ICollection<TBase>, IEnumerable<TBase>, IEnumerable where TImplementation : TBase
{
	public TBase this[int index]
	{
		get
		{
			return (TBase)(object)implementation[index];
		}
		set
		{
			if (!(value is TImplementation))
			{
				throw new NotSupportedException();
			}
			implementation[index] = (TImplementation)(object)value;
		}
	}

	public IList<TImplementation> implementation { get; private set; }

	public int Count => implementation.Count;

	public bool IsReadOnly => implementation.IsReadOnly;

	public VariantList(IList<TImplementation> implementation)
	{
		if (implementation == null)
		{
			throw new ArgumentNullException("implementation");
		}
		this.implementation = implementation;
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

	public int IndexOf(TBase item)
	{
		if (!(item is TImplementation))
		{
			throw new NotSupportedException();
		}
		return implementation.IndexOf((TImplementation)(object)item);
	}

	public void Insert(int index, TBase item)
	{
		if (!(item is TImplementation))
		{
			throw new NotSupportedException();
		}
		implementation.Insert(index, (TImplementation)(object)item);
	}

	public void RemoveAt(int index)
	{
		implementation.RemoveAt(index);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	IEnumerator<TBase> IEnumerable<TBase>.GetEnumerator()
	{
		return GetEnumerator();
	}

	public NoAllocEnumerator<TBase> GetEnumerator()
	{
		return new NoAllocEnumerator<TBase>(this);
	}
}
