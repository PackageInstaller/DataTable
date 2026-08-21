using System;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public class MultiMap<T, K> : SortedDictionary<T, List<K>>
{
	private readonly List<K> m_Empty = new List<K>();

	public new List<K> this[T t]
	{
		get
		{
			TryGetValue(t, out var value);
			return value ?? m_Empty;
		}
	}

	public void Add(T t, K k)
	{
		TryGetValue(t, out var value);
		if (value == null)
		{
			value = new List<K>();
			Add(t, value);
		}
		value.Add(k);
	}

	public bool Remove(T t, K k)
	{
		TryGetValue(t, out var value);
		if (value == null)
		{
			return false;
		}
		if (!value.Remove(k))
		{
			return false;
		}
		if (value.Count == 0)
		{
			Remove(t);
		}
		return true;
	}

	public K[] GetAll(T t)
	{
		TryGetValue(t, out var value);
		if (value == null)
		{
			return Array.Empty<K>();
		}
		return value.ToArray();
	}

	public K GetOne(T t)
	{
		TryGetValue(t, out var value);
		if (value != null && value.Count > 0)
		{
			return value[0];
		}
		return default(K);
	}

	public bool Contains(T t, K k)
	{
		TryGetValue(t, out var value);
		return value?.Contains(k) ?? false;
	}
}
