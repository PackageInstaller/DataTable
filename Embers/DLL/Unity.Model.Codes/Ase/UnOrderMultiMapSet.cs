using System.Collections.Generic;

namespace Ase;

public class UnOrderMultiMapSet<T, K> : Dictionary<T, HashSet<K>>
{
	public new HashSet<K> this[T t]
	{
		get
		{
			if (!TryGetValue(t, out var value))
			{
				return new HashSet<K>();
			}
			return value;
		}
	}

	public new int Count
	{
		get
		{
			int num = 0;
			using Enumerator enumerator = GetEnumerator();
			while (enumerator.MoveNext())
			{
				num += enumerator.Current.Value.Count;
			}
			return num;
		}
	}

	public Dictionary<T, HashSet<K>> GetDictionary()
	{
		return this;
	}

	public void Add(T t, K k)
	{
		TryGetValue(t, out var value);
		if (value == null)
		{
			value = (base[t] = new HashSet<K>());
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

	public bool Contains(T t, K k)
	{
		TryGetValue(t, out var value);
		return value?.Contains(k) ?? false;
	}
}
