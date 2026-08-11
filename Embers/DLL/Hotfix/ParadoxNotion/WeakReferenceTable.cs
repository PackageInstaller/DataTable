using System;
using System.Collections.Generic;

namespace ParadoxNotion;

public class WeakReferenceTable<TKey, TValue> where TKey : class where TValue : IDisposable
{
	private List<WeakReference<TKey>> keys;

	private List<TValue> values;

	public int Count => keys.Count;

	public WeakReferenceTable()
	{
		keys = new List<WeakReference<TKey>>();
		values = new List<TValue>();
	}

	public void Clear()
	{
		keys.Clear();
		values.Clear();
	}

	public void Add(TKey key, TValue value)
	{
		CheckCount();
		keys.Insert(0, new WeakReference<TKey>(key));
		values.Insert(0, value);
	}

	public void Remove(TKey key)
	{
		CheckCount();
		int count = keys.Count;
		while (count-- > 0)
		{
			if (keys[count].TryGetTarget(out var target) && target == key)
			{
				keys.RemoveAt(count);
				values[count].Dispose();
				values.RemoveAt(count);
			}
		}
	}

	public bool TryGetValueWithRefCheck(TKey key, out TValue value)
	{
		CheckCount();
		int count = keys.Count;
		while (count-- > 0)
		{
			if (!keys[count].TryGetTarget(out var target))
			{
				keys.RemoveAt(count);
				values[count].Dispose();
				values.RemoveAt(count);
			}
			if (target == key)
			{
				value = values[count];
				return true;
			}
		}
		value = default(TValue);
		return false;
	}

	public void RemoveMissingReferences()
	{
		CheckCount();
		int count = keys.Count;
		while (count-- > 0)
		{
			if (!keys[count].TryGetTarget(out var _))
			{
				keys.RemoveAt(count);
				values[count].Dispose();
				values.RemoveAt(count);
			}
		}
	}

	private void CheckCount()
	{
		if (keys.Count != values.Count)
		{
			throw new Exception("Mismatched indeces");
		}
	}
}
