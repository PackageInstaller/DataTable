using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Ase.Serializing.Helping;

public class ListCache<T>
{
	public List<T> Collection = new List<T>();

	private Stack<T> _cache = new Stack<T>();

	public int Written => Collection.Count;

	public ListCache()
	{
		Collection = new List<T>();
	}

	public ListCache(int capacity)
	{
		Collection = new List<T>(capacity);
	}

	private T Retrieve()
	{
		if (_cache.Count > 0)
		{
			return _cache.Pop();
		}
		return Activator.CreateInstance<T>();
	}

	private void Store(T value)
	{
		_cache.Push(value);
	}

	public T AddReference()
	{
		T val = Retrieve();
		Collection.Add(val);
		return val;
	}

	public T InsertReference(int index)
	{
		if (index >= Collection.Count)
		{
			return AddReference();
		}
		T val = Retrieve();
		Collection.Insert(index, val);
		return val;
	}

	public void AddValue(T value)
	{
		Collection.Add(value);
	}

	public void InsertValue(int index, T value)
	{
		if (index >= Collection.Count)
		{
			AddValue(value);
		}
		else
		{
			Collection.Insert(index, value);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void AddValues(ListCache<T> values)
	{
		int written = values.Written;
		List<T> collection = values.Collection;
		for (int i = 0; i < written; i++)
		{
			AddValue(collection[i]);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void AddValues(T[] values)
	{
		for (int i = 0; i < values.Length; i++)
		{
			AddValue(values[i]);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void AddValues(List<T> values)
	{
		for (int i = 0; i < values.Count; i++)
		{
			AddValue(values[i]);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void AddValues(HashSet<T> values)
	{
		foreach (T value in values)
		{
			AddValue(value);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void AddValues(ISet<T> values)
	{
		foreach (T value in values)
		{
			AddValue(value);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void AddValues(IReadOnlyCollection<T> values)
	{
		foreach (T value in values)
		{
			AddValue(value);
		}
	}

	public void Reset()
	{
		foreach (T item in Collection)
		{
			Store(item);
		}
		Collection.Clear();
	}
}
