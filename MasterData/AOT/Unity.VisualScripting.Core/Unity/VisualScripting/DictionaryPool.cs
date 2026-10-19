using System;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public static class DictionaryPool<TKey, TValue>
{
	private static readonly object @lock = new object();

	private static readonly Stack<Dictionary<TKey, TValue>> free = new Stack<Dictionary<TKey, TValue>>();

	private static readonly HashSet<Dictionary<TKey, TValue>> busy = new HashSet<Dictionary<TKey, TValue>>();

	public static Dictionary<TKey, TValue> New(Dictionary<TKey, TValue> source = null)
	{
		lock (@lock)
		{
			if (free.Count == 0)
			{
				free.Push(new Dictionary<TKey, TValue>());
			}
			Dictionary<TKey, TValue> dictionary = free.Pop();
			busy.Add(dictionary);
			if (source != null)
			{
				foreach (KeyValuePair<TKey, TValue> item in source)
				{
					dictionary.Add(item.Key, item.Value);
				}
			}
			return dictionary;
		}
	}

	public static void Free(Dictionary<TKey, TValue> dictionary)
	{
		lock (@lock)
		{
			if (!busy.Contains(dictionary))
			{
				throw new ArgumentException("The dictionary to free is not in use by the pool.", "dictionary");
			}
			dictionary.Clear();
			busy.Remove(dictionary);
			free.Push(dictionary);
		}
	}
}
