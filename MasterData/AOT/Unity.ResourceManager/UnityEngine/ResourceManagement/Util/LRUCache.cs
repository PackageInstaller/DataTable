using System;
using System.Collections.Generic;

namespace UnityEngine.ResourceManagement.Util;

internal struct LRUCache<TKey, TValue>(int limit) where TKey : IEquatable<TKey>
{
	public struct Entry : IEquatable<Entry>
	{
		public LinkedListNode<TKey> lruNode;

		public TValue Value;

		public bool Equals(Entry other)
		{
			return Value.Equals(other);
		}

		public override int GetHashCode()
		{
			return Value.GetHashCode();
		}
	}

	private int entryLimit = limit;

	private Dictionary<TKey, Entry> cache = new Dictionary<TKey, Entry>();

	private LinkedList<TKey> lru = new LinkedList<TKey>();

	public bool TryAdd(TKey id, TValue obj)
	{
		if (obj == null || entryLimit <= 0)
		{
			return false;
		}
		cache.Add(id, new Entry
		{
			Value = obj,
			lruNode = lru.AddFirst(id)
		});
		while (lru.Count > entryLimit)
		{
			cache.Remove(lru.Last.Value);
			lru.RemoveLast();
		}
		return true;
	}

	public bool TryGet(TKey offset, out TValue val)
	{
		if (cache.TryGetValue(offset, out var value))
		{
			val = value.Value;
			if (value.lruNode.Previous != null)
			{
				lru.Remove(value.lruNode);
				lru.AddFirst(value.lruNode);
			}
			return true;
		}
		val = default;
		return false;
	}
}
