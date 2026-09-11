using System;
using System.Buffers;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Text;

namespace MessagePack.Internal;

public class ByteArrayStringHashTable : IEnumerable<KeyValuePair<string, int>>, IEnumerable
{
	private struct Entry
	{
		public byte[] Key;

		public int Value;

		public override string ToString()
		{
			return "(" + Encoding.UTF8.GetString(Key) + ", " + Value + ")";
		}
	}

	private readonly Entry[][] buckets;

	private readonly ulong indexFor;

	private static readonly bool Is32Bit = IntPtr.Size == 4;

	public ByteArrayStringHashTable(int capacity)
		: this(capacity, 0.42f)
	{
	}

	public ByteArrayStringHashTable(int capacity, float loadFactor)
	{
		int num = CalculateCapacity(capacity, loadFactor);
		buckets = new Entry[num][];
		indexFor = (ulong)buckets.Length - 1uL;
	}

	public void Add(string key, int value)
	{
		if (!TryAddInternal(Encoding.UTF8.GetBytes(key), value))
		{
			throw new ArgumentException("Key was already exists. Key:" + key);
		}
	}

	public void Add(byte[] key, int value)
	{
		if (!TryAddInternal(key, value))
		{
			throw new ArgumentException("Key was already exists. Key:" + key);
		}
	}

	private bool TryAddInternal(byte[] key, int value)
	{
		ulong num = ByteArrayGetHashCode(key);
		Entry entry = new Entry
		{
			Key = key,
			Value = value
		};
		Entry[] array = buckets[num & indexFor];
		if (array == null)
		{
			buckets[num & indexFor] = new Entry[1] { entry };
		}
		else
		{
			for (int i = 0; i < array.Length; i++)
			{
				byte[] key2 = array[i].Key;
				if (key.AsSpan().SequenceEqual(key2))
				{
					return false;
				}
			}
			Entry[] array2 = new Entry[array.Length + 1];
			Array.Copy(array, array2, array.Length);
			array = array2;
			array[array.Length - 1] = entry;
			buckets[num & indexFor] = array;
		}
		return true;
	}

	public bool TryGetValue(in ReadOnlySequence<byte> key, out int value)
	{
		return TryGetValue(CodeGenHelpers.GetSpanFromSequence(in key), out value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool TryGetValue(ReadOnlySpan<byte> key, out int value)
	{
		Entry[][] array = buckets;
		ulong num = ByteArrayGetHashCode(key);
		Entry[] array2 = array[num & indexFor];
		if (array2 == null)
		{
			value = 0;
			return false;
		}
		ref Entry reference = ref array2[0];
		if (key.SequenceEqual(reference.Key))
		{
			value = reference.Value;
			return true;
		}
		return TryGetValueSlow(key, array2, out value);
	}

	private bool TryGetValueSlow(ReadOnlySpan<byte> key, Entry[] entry, out int value)
	{
		for (int i = 1; i < entry.Length; i++)
		{
			ref Entry reference = ref entry[i];
			if (key.SequenceEqual(reference.Key))
			{
				value = reference.Value;
				return true;
			}
		}
		value = 0;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static ulong ByteArrayGetHashCode(ReadOnlySpan<byte> x)
	{
		if (Is32Bit)
		{
			return FarmHash.Hash32(x);
		}
		return FarmHash.Hash64(x);
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

	public IEnumerator<KeyValuePair<string, int>> GetEnumerator()
	{
		Entry[][] array = buckets;
		Entry[][] array2 = array;
		foreach (Entry[] array3 in array2)
		{
			if (array3 != null)
			{
				Entry[] array4 = array3;
				for (int j = 0; j < array4.Length; j++)
				{
					Entry entry = array4[j];
					yield return new KeyValuePair<string, int>(Encoding.UTF8.GetString(entry.Key), entry.Value);
				}
			}
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
