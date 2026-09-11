using System;
using System.Runtime.CompilerServices;
using System.Threading;

namespace MessagePack.Internal;

internal class ThreadsafeTypeKeyHashTable<TValue>
{
	private class Entry
	{
		internal Type Key;

		internal TValue Value;

		internal int Hash;

		internal Entry Next;

		public override string ToString()
		{
			return Key?.ToString() + "(" + Count() + ")";
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

	private readonly object writerLock = new object();

	private readonly float loadFactor;

	public ThreadsafeTypeKeyHashTable(int capacity = 4, float loadFactor = 0.75f)
	{
		int num = CalculateCapacity(capacity, loadFactor);
		buckets = new Entry[num];
		this.loadFactor = loadFactor;
	}

	public bool TryAdd(Type key, TValue value)
	{
		return TryAdd(key, (Type _) => value);
	}

	public bool TryAdd(Type key, Func<Type, TValue> valueFactory)
	{
		TValue resultingValue;
		return TryAddInternal(key, valueFactory, out resultingValue);
	}

	private bool TryAddInternal(Type key, Func<Type, TValue> valueFactory, out TValue resultingValue)
	{
		lock (writerLock)
		{
			int num = CalculateCapacity(size + 1, loadFactor);
			if (buckets.Length < num)
			{
				Entry[] value = new Entry[num];
				for (int i = 0; i < buckets.Length; i++)
				{
					for (Entry entry = buckets[i]; entry != null; entry = entry.Next)
					{
						Entry newEntryOrNull = new Entry
						{
							Key = entry.Key,
							Value = entry.Value,
							Hash = entry.Hash
						};
						AddToBuckets(value, key, newEntryOrNull, null, out resultingValue);
					}
				}
				bool num2 = AddToBuckets(value, key, null, valueFactory, out resultingValue);
				VolatileWrite(ref buckets, value);
				if (num2)
				{
					size++;
				}
				return num2;
			}
			bool num3 = AddToBuckets(buckets, key, null, valueFactory, out resultingValue);
			if (num3)
			{
				size++;
			}
			return num3;
		}
	}

	private bool AddToBuckets(Entry[] buckets, Type newKey, Entry newEntryOrNull, Func<Type, TValue> valueFactory, out TValue resultingValue)
	{
		int num = newEntryOrNull?.Hash ?? newKey.GetHashCode();
		if (buckets[num & (buckets.Length - 1)] == null)
		{
			if (newEntryOrNull != null)
			{
				resultingValue = newEntryOrNull.Value;
				VolatileWrite(ref buckets[num & (buckets.Length - 1)], newEntryOrNull);
			}
			else
			{
				resultingValue = valueFactory(newKey);
				VolatileWrite(ref buckets[num & (buckets.Length - 1)], new Entry
				{
					Key = newKey,
					Value = resultingValue,
					Hash = num
				});
			}
		}
		else
		{
			Entry entry = buckets[num & (buckets.Length - 1)];
			while (true)
			{
				if (entry.Key == newKey)
				{
					resultingValue = entry.Value;
					return false;
				}
				if (entry.Next == null)
				{
					break;
				}
				entry = entry.Next;
			}
			if (newEntryOrNull != null)
			{
				resultingValue = newEntryOrNull.Value;
				VolatileWrite(ref entry.Next, newEntryOrNull);
			}
			else
			{
				resultingValue = valueFactory(newKey);
				VolatileWrite(ref entry.Next, new Entry
				{
					Key = newKey,
					Value = resultingValue,
					Hash = num
				});
			}
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool TryGetValue(Type key, out TValue value)
	{
		Entry[] array = buckets;
		int hashCode = key.GetHashCode();
		for (Entry entry = array[hashCode & (array.Length - 1)]; entry != null; entry = entry.Next)
		{
			if (entry.Key == key)
			{
				value = entry.Value;
				return true;
			}
		}
		value = default(TValue);
		return false;
	}

	public TValue GetOrAdd(Type key, Func<Type, TValue> valueFactory)
	{
		if (TryGetValue(key, out var value))
		{
			return value;
		}
		TryAddInternal(key, valueFactory, out value);
		return value;
	}

	private static int CalculateCapacity(int collectionSize, float loadFactor)
	{
		int num = (int)((float)collectionSize / loadFactor);
		int num2;
		for (num2 = 1; num2 < num; num2 <<= 1)
		{
		}
		if (num2 < 8)
		{
			return 8;
		}
		return num2;
	}

	private static void VolatileWrite(ref Entry location, Entry value)
	{
		Volatile.Write(ref location, value);
	}

	private static void VolatileWrite(ref Entry[] location, Entry[] value)
	{
		Volatile.Write(ref location, value);
	}
}
