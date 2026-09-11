using System.Threading;

namespace System.Dynamic.Utils;

internal sealed class CacheDict<TKey, TValue>
{
	private sealed class Entry
	{
		internal readonly int _hash;

		internal readonly TKey _key;

		internal readonly TValue _value;

		internal Entry(int hash, TKey key, TValue value)
		{
			_hash = hash;
			_key = key;
			_value = value;
		}
	}

	private readonly int _mask;

	private readonly Entry[] _entries;

	internal TValue this[TKey key]
	{
		set
		{
			Add(key, value);
		}
	}

	internal CacheDict(int size)
	{
		int num = AlignSize(size);
		_mask = num - 1;
		_entries = new Entry[num];
	}

	private static int AlignSize(int size)
	{
		size--;
		size |= size >> 1;
		size |= size >> 2;
		size |= size >> 4;
		size |= size >> 8;
		size |= size >> 16;
		size++;
		return size;
	}

	internal bool TryGetValue(TKey key, out TValue value)
	{
		int hashCode = key.GetHashCode();
		int num = hashCode & _mask;
		Entry entry = Volatile.Read(ref _entries[num]);
		if (entry != null && entry._hash == hashCode && entry._key.Equals(key))
		{
			value = entry._value;
			return true;
		}
		value = default(TValue);
		return false;
	}

	internal void Add(TKey key, TValue value)
	{
		int hashCode = key.GetHashCode();
		int num = hashCode & _mask;
		Entry entry = Volatile.Read(ref _entries[num]);
		if (entry == null || entry._hash != hashCode || !entry._key.Equals(key))
		{
			Volatile.Write(ref _entries[num], new Entry(hashCode, key, value));
		}
	}
}
