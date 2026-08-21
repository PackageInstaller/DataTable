using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Internal;

internal class WeakDictionary<TKey, TValue> where TKey : class
{
	private class Entry
	{
		public WeakReference<TKey> Key;

		public TValue Value;

		public int Hash;

		public Entry Prev;

		public Entry Next;

		public override string ToString()
		{
			if (Key.TryGetTarget(out var target))
			{
				return target?.ToString() + "(" + Count() + ")";
			}
			return "(Dead)";
		}

		private int Count()
		{
			int num = 1;
			Entry entry = this;
			while (entry.Next != null)
			{
				num++;
				entry = entry.Next;
			}
			return num;
		}
	}

	private Entry[] buckets;

	private int size;

	private SpinLock gate;

	private readonly float loadFactor;

	private readonly IEqualityComparer<TKey> keyEqualityComparer;

	public WeakDictionary(int capacity = 4, float loadFactor = 0.75f, IEqualityComparer<TKey> keyComparer = null)
	{
		int num = CalculateCapacity(capacity, loadFactor);
		buckets = new Entry[num];
		this.loadFactor = loadFactor;
		gate = new SpinLock(enableThreadOwnerTracking: false);
		keyEqualityComparer = keyComparer ?? EqualityComparer<TKey>.Default;
	}

	public bool TryAdd(TKey key, TValue value)
	{
		bool lockTaken = false;
		try
		{
			gate.Enter(ref lockTaken);
			return TryAddInternal(key, value);
		}
		finally
		{
			if (lockTaken)
			{
				gate.Exit(useMemoryBarrier: false);
			}
		}
	}

	public bool TryGetValue(TKey key, out TValue value)
	{
		bool lockTaken = false;
		try
		{
			gate.Enter(ref lockTaken);
			if (TryGetEntry(key, out var _, out var entry))
			{
				value = entry.Value;
				return true;
			}
			value = default(TValue);
			return false;
		}
		finally
		{
			if (lockTaken)
			{
				gate.Exit(useMemoryBarrier: false);
			}
		}
	}

	public bool TryRemove(TKey key)
	{
		bool lockTaken = false;
		try
		{
			gate.Enter(ref lockTaken);
			if (TryGetEntry(key, out var hashIndex, out var entry))
			{
				Remove(hashIndex, entry);
				return true;
			}
			return false;
		}
		finally
		{
			if (lockTaken)
			{
				gate.Exit(useMemoryBarrier: false);
			}
		}
	}

	private bool TryAddInternal(TKey key, TValue value)
	{
		int num = CalculateCapacity(size + 1, loadFactor);
		while (buckets.Length < num)
		{
			Entry[] targetBuckets = new Entry[num];
			for (int i = 0; i < buckets.Length; i++)
			{
				for (Entry entry = buckets[i]; entry != null; entry = entry.Next)
				{
					AddToBuckets(targetBuckets, key, entry.Value, entry.Hash);
				}
			}
			buckets = targetBuckets;
		}
		bool num2 = AddToBuckets(buckets, key, value, keyEqualityComparer.GetHashCode(key));
		if (num2)
		{
			size++;
		}
		return num2;
	}

	private bool AddToBuckets(Entry[] targetBuckets, TKey newKey, TValue value, int keyHash)
	{
		int num = keyHash & (targetBuckets.Length - 1);
		while (targetBuckets[num] != null)
		{
			Entry entry = targetBuckets[num];
			while (true)
			{
				if (entry != null)
				{
					if (entry.Key.TryGetTarget(out var target))
					{
						if (keyEqualityComparer.Equals(newKey, target))
						{
							return false;
						}
					}
					else
					{
						Remove(num, entry);
						if (targetBuckets[num] == null)
						{
							break;
						}
					}
					if (entry.Next != null)
					{
						entry = entry.Next;
						continue;
					}
					entry.Next = new Entry
					{
						Key = new WeakReference<TKey>(newKey, trackResurrection: false),
						Value = value,
						Hash = keyHash
					};
					entry.Next.Prev = entry;
					continue;
				}
				return false;
			}
		}
		targetBuckets[num] = new Entry
		{
			Key = new WeakReference<TKey>(newKey, trackResurrection: false),
			Value = value,
			Hash = keyHash
		};
		return true;
	}

	private bool TryGetEntry(TKey key, out int hashIndex, out Entry entry)
	{
		Entry[] array = buckets;
		int hashCode = keyEqualityComparer.GetHashCode(key);
		hashIndex = hashCode & (array.Length - 1);
		for (entry = array[hashIndex]; entry != null; entry = entry.Next)
		{
			if (entry.Key.TryGetTarget(out var target))
			{
				if (keyEqualityComparer.Equals(key, target))
				{
					return true;
				}
			}
			else
			{
				Remove(hashIndex, entry);
			}
		}
		return false;
	}

	private void Remove(int hashIndex, Entry entry)
	{
		if (entry.Prev == null && entry.Next == null)
		{
			buckets[hashIndex] = null;
		}
		else
		{
			if (entry.Prev == null)
			{
				buckets[hashIndex] = entry.Next;
			}
			if (entry.Prev != null)
			{
				entry.Prev.Next = entry.Next;
			}
			if (entry.Next != null)
			{
				entry.Next.Prev = entry.Prev;
			}
		}
		size--;
	}

	public List<KeyValuePair<TKey, TValue>> ToList()
	{
		List<KeyValuePair<TKey, TValue>> list = new List<KeyValuePair<TKey, TValue>>(size);
		ToList(ref list, clear: false);
		return list;
	}

	public int ToList(ref List<KeyValuePair<TKey, TValue>> list, bool clear = true)
	{
		if (clear)
		{
			list.Clear();
		}
		int num = 0;
		bool flag = false;
		try
		{
			for (int i = 0; i < buckets.Length; i++)
			{
				for (Entry entry = buckets[i]; entry != null; entry = entry.Next)
				{
					if (entry.Key.TryGetTarget(out var target))
					{
						KeyValuePair<TKey, TValue> keyValuePair = new KeyValuePair<TKey, TValue>(target, entry.Value);
						if (num < list.Count)
						{
							list[num++] = keyValuePair;
						}
						else
						{
							list.Add(keyValuePair);
							num++;
						}
					}
					else
					{
						Remove(i, entry);
					}
				}
			}
			return num;
		}
		finally
		{
			if (flag)
			{
				gate.Exit(useMemoryBarrier: false);
			}
		}
	}

	private static int CalculateCapacity(int collectionSize, float loadFactor)
	{
		int num = (int)((float)collectionSize / loadFactor);
		num--;
		num |= num >> 1;
		num |= num >> 2;
		num |= num >> 4;
		num |= num >> 8;
		num |= num >> 16;
		num++;
		if (num < 8)
		{
			num = 8;
		}
		return num;
	}
}
