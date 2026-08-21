using System;
using System.Collections.Generic;

public class LinkedMap<TFirst, TSecond>
{
	private IDictionary<TFirst, TSecond> firstToSecond = new Dictionary<TFirst, TSecond>();

	private IDictionary<TSecond, TFirst> secondToFirst = new Dictionary<TSecond, TFirst>();

	public int Count => firstToSecond.Count;

	public ICollection<TFirst> GetKeys => firstToSecond.Keys;

	public ICollection<TSecond> GetValues => firstToSecond.Values;

	public void Add(TFirst first, TSecond second)
	{
		if (firstToSecond.ContainsKey(first) || secondToFirst.ContainsKey(second))
		{
			throw new ArgumentException("Duplicate first or second");
		}
		firstToSecond.Add(first, second);
		secondToFirst.Add(second, first);
	}

	public TSecond GetByFirst(TFirst first)
	{
		if (!firstToSecond.TryGetValue(first, out var value))
		{
			throw new ArgumentException("first");
		}
		return value;
	}

	public TFirst GetBySecond(TSecond second)
	{
		if (!secondToFirst.TryGetValue(second, out var value))
		{
			throw new ArgumentException("second");
		}
		return value;
	}

	public void RemoveByFirst(TFirst first)
	{
		if (!firstToSecond.TryGetValue(first, out var value))
		{
			throw new ArgumentException("first");
		}
		firstToSecond.Remove(first);
		secondToFirst.Remove(value);
	}

	public void RemoveBySecond(TSecond second)
	{
		if (!secondToFirst.TryGetValue(second, out var value))
		{
			throw new ArgumentException("second");
		}
		secondToFirst.Remove(second);
		firstToSecond.Remove(value);
	}

	public bool TryAdd(TFirst first, TSecond second)
	{
		if (firstToSecond.ContainsKey(first) || secondToFirst.ContainsKey(second))
		{
			return false;
		}
		firstToSecond.Add(first, second);
		secondToFirst.Add(second, first);
		return true;
	}

	public bool ContainsFirst(TFirst first)
	{
		return firstToSecond.ContainsKey(first);
	}

	public bool ContainsSecond(TSecond second)
	{
		return secondToFirst.ContainsKey(second);
	}

	public bool TryGetByFirst(TFirst first, out TSecond second)
	{
		return firstToSecond.TryGetValue(first, out second);
	}

	public bool TryGetBySecond(TSecond second, out TFirst first)
	{
		return secondToFirst.TryGetValue(second, out first);
	}

	public bool TryRemoveByFirst(TFirst first)
	{
		if (!firstToSecond.TryGetValue(first, out var value))
		{
			return false;
		}
		firstToSecond.Remove(first);
		secondToFirst.Remove(value);
		return true;
	}

	public bool TryRemoveBySecond(TSecond second)
	{
		if (!secondToFirst.TryGetValue(second, out var value))
		{
			return false;
		}
		secondToFirst.Remove(second);
		firstToSecond.Remove(value);
		return true;
	}

	public void Clear()
	{
		firstToSecond.Clear();
		secondToFirst.Clear();
	}
}
