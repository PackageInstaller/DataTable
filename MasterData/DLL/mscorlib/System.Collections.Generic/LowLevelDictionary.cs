namespace System.Collections.Generic;

internal class LowLevelDictionary<TKey, TValue>
{
	private sealed class Entry
	{
		public TKey _key;

		public TValue _value;

		public Entry _next;
	}

	private sealed class DefaultComparer<T> : IEqualityComparer<T>
	{
		public bool Equals(T x, T y)
		{
			if (x == null)
			{
				return y == null;
			}
			if (x is IEquatable<T> equatable)
			{
				return equatable.Equals(y);
			}
			return x.Equals(y);
		}

		public int GetHashCode(T obj)
		{
			return obj.GetHashCode();
		}
	}

	private Entry[] _buckets;

	private int _numEntries;

	private int _version;

	private IEqualityComparer<TKey> _comparer;

	public TValue this[TKey key]
	{
		set
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			_version++;
			Entry entry = Find(key);
			if (entry != null)
			{
				entry._value = value;
			}
			else
			{
				UncheckedAdd(key, value);
			}
		}
	}

	public LowLevelDictionary()
		: this(17, (IEqualityComparer<TKey>)new DefaultComparer<TKey>())
	{
	}

	public LowLevelDictionary(int capacity, IEqualityComparer<TKey> comparer)
	{
		_comparer = comparer;
		Clear(capacity);
	}

	public bool TryGetValue(TKey key, out TValue value)
	{
		value = default(TValue);
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		Entry entry = Find(key);
		if (entry != null)
		{
			value = entry._value;
			return true;
		}
		return false;
	}

	public void Clear(int capacity = 17)
	{
		_version++;
		_buckets = new Entry[capacity];
		_numEntries = 0;
	}

	public bool Remove(TKey key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		int bucket = GetBucket(key);
		Entry entry = null;
		for (Entry entry2 = _buckets[bucket]; entry2 != null; entry2 = entry2._next)
		{
			if (_comparer.Equals(key, entry2._key))
			{
				if (entry == null)
				{
					_buckets[bucket] = entry2._next;
				}
				else
				{
					entry._next = entry2._next;
				}
				_version++;
				_numEntries--;
				return true;
			}
			entry = entry2;
		}
		return false;
	}

	private Entry Find(TKey key)
	{
		int bucket = GetBucket(key);
		for (Entry entry = _buckets[bucket]; entry != null; entry = entry._next)
		{
			if (_comparer.Equals(key, entry._key))
			{
				return entry;
			}
		}
		return null;
	}

	private Entry UncheckedAdd(TKey key, TValue value)
	{
		Entry entry = new Entry();
		entry._key = key;
		entry._value = value;
		int bucket = GetBucket(key);
		entry._next = _buckets[bucket];
		_buckets[bucket] = entry;
		_numEntries++;
		if (_numEntries > _buckets.Length * 2)
		{
			ExpandBuckets();
		}
		return entry;
	}

	private void ExpandBuckets()
	{
		try
		{
			int num = _buckets.Length * 2 + 1;
			Entry[] array = new Entry[num];
			for (int i = 0; i < _buckets.Length; i++)
			{
				Entry entry = _buckets[i];
				while (entry != null)
				{
					Entry next = entry._next;
					int bucket = GetBucket(entry._key, num);
					entry._next = array[bucket];
					array[bucket] = entry;
					entry = next;
				}
			}
			_buckets = array;
		}
		catch (OutOfMemoryException)
		{
		}
	}

	private int GetBucket(TKey key, int numBuckets = 0)
	{
		return (_comparer.GetHashCode(key) & 0x7FFFFFFF) % ((numBuckets == 0) ? _buckets.Length : numBuckets);
	}
}
