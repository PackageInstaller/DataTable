using System.Collections;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq.Expressions;

namespace System.Dynamic.Utils;

internal abstract class ListProvider<T> : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable where T : class
{
	protected abstract T First { get; }

	protected abstract int ElementCount { get; }

	public T this[int index]
	{
		get
		{
			if (index == 0)
			{
				return First;
			}
			return GetElement(index);
		}
		[ExcludeFromCodeCoverage]
		set
		{
			throw ContractUtils.Unreachable;
		}
	}

	public int Count => ElementCount;

	[ExcludeFromCodeCoverage]
	public bool IsReadOnly => true;

	protected abstract T GetElement(int index);

	public int IndexOf(T item)
	{
		if (First == item)
		{
			return 0;
		}
		int i = 1;
		for (int elementCount = ElementCount; i < elementCount; i++)
		{
			if (GetElement(i) == item)
			{
				return i;
			}
		}
		return -1;
	}

	[ExcludeFromCodeCoverage]
	public void Insert(int index, T item)
	{
		throw ContractUtils.Unreachable;
	}

	[ExcludeFromCodeCoverage]
	public void RemoveAt(int index)
	{
		throw ContractUtils.Unreachable;
	}

	[ExcludeFromCodeCoverage]
	public void Add(T item)
	{
		throw ContractUtils.Unreachable;
	}

	[ExcludeFromCodeCoverage]
	public void Clear()
	{
		throw ContractUtils.Unreachable;
	}

	public bool Contains(T item)
	{
		return IndexOf(item) != -1;
	}

	public void CopyTo(T[] array, int index)
	{
		ContractUtils.RequiresNotNull(array, "array");
		if (index < 0)
		{
			throw Error.ArgumentOutOfRange("index");
		}
		int elementCount = ElementCount;
		if (index + elementCount > array.Length)
		{
			throw new ArgumentException();
		}
		array[index++] = First;
		for (int i = 1; i < elementCount; i++)
		{
			array[index++] = GetElement(i);
		}
	}

	[ExcludeFromCodeCoverage]
	public bool Remove(T item)
	{
		throw ContractUtils.Unreachable;
	}

	public IEnumerator<T> GetEnumerator()
	{
		yield return First;
		int i = 1;
		for (int n = ElementCount; i < n; i++)
		{
			yield return GetElement(i);
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
