using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Text;

namespace P08Common.Collections;

public class FastSet<T> : ICollection<T>, IEnumerable<T>, IEnumerable
{
	private struct Entry
	{
		public int hashCode;

		public T item;

		public int next;
	}

	private const int Lower31BitMask = int.MaxValue;

	public static readonly int[] primes;

	private int[] buckets;

	private Entry[] entries;

	private int count;

	private int freeList;

	private int freeCount;

	private int primeIndex;

	private IEqualityComparer<T> comparer;

	public int Capacity
	{
		get
		{
			return buckets.Length;
		}
		set
		{
			if (value > buckets.Length)
			{
				primeIndex = FindPrimeIndex(value);
				IncreaseCapacity();
			}
		}
	}

	public int Count => count - freeCount;

	public bool IsReadOnly => false;

	public FastSet()
	{
		comparer = EqualityComparer<T>.Default;
		freeList = -1;
	}

	public FastSet(int capacity)
	{
		primeIndex = FindPrimeIndex(capacity);
		if (primeIndex < 0)
		{
			throw new Exception("Set exceeded maximum capacity!");
		}
		capacity = primes[primeIndex++];
		buckets = new int[capacity];
		for (int i = 0; i < capacity; i++)
		{
			buckets[i] = -1;
		}
		entries = new Entry[capacity];
		comparer = EqualityComparer<T>.Default;
		freeList = -1;
	}

	public void Add(T item)
	{
		if (item == null)
		{
			throw new ArgumentNullException();
		}
		if (buckets == null)
		{
			int num = primes[primeIndex++];
			buckets = new int[num];
			for (int i = 0; i < num; i++)
			{
				buckets[i] = -1;
			}
			entries = new Entry[num];
			freeList = -1;
		}
		int num2 = comparer.GetHashCode(item) & 0x7FFFFFFF;
		int num3 = num2 % buckets.Length;
		int num4;
		if (freeCount > 0)
		{
			num4 = freeList;
			freeList = entries[num4].next;
			freeCount--;
		}
		else
		{
			if (count == entries.Length)
			{
				IncreaseCapacity();
				num3 = num2 % buckets.Length;
			}
			num4 = count++;
		}
		entries[num4].hashCode = num2;
		entries[num4].item = item;
		entries[num4].next = buckets[num3];
		buckets[num3] = num4;
	}

	public void Add(FastSet<T> set)
	{
		for (int i = 0; i < set.count; i++)
		{
			if (set.entries[i].hashCode >= 0)
			{
				Add(set.entries[i].item);
			}
		}
	}

	public bool Remove(T item)
	{
		int num = FindEntry(item);
		if (num < 0)
		{
			throw new KeyNotFoundException("Item not found!");
		}
		entries[num].hashCode = -1;
		entries[num].next = freeList;
		entries[num].item = default(T);
		freeList = num;
		freeCount++;
		return true;
	}

	public bool Contains(T item)
	{
		if (buckets == null)
		{
			return false;
		}
		int num = comparer.GetHashCode(item) & 0x7FFFFFFF;
		for (int num2 = buckets[num % buckets.Length]; num2 >= 0; num2 = entries[num2].next)
		{
			if (entries[num2].hashCode == num && comparer.Equals(entries[num2].item, item))
			{
				return true;
			}
		}
		return false;
	}

	public void CopyTo(T[] array)
	{
		CopyTo(array, 0);
	}

	public void CopyTo(T[] array, int index)
	{
		for (int i = 0; i < count; i++)
		{
			if (entries[i].hashCode >= 0)
			{
				array[index++] = entries[i].item;
			}
		}
	}

	public void Clear()
	{
		if (count > 0)
		{
			for (int i = 0; i < buckets.Length; i++)
			{
				buckets[i] = -1;
			}
			Array.Clear(entries, 0, count);
			freeList = -1;
			count = 0;
			freeCount = 0;
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public IEnumerator<T> GetEnumerator()
	{
		for (int i = 0; i < count; i++)
		{
			if (entries[i].hashCode >= 0)
			{
				yield return entries[i].item;
			}
		}
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < buckets.Length; i++)
		{
			if (buckets[i] == -1)
			{
				stringBuilder.Append("-empty-\n");
				continue;
			}
			for (int num = buckets[i]; num >= 0; num = entries[num].next)
			{
				stringBuilder.AppendFormat("{1}{0} ", (entries[num].next == -1) ? null : ",", entries[num].item);
			}
			stringBuilder.Append("\n");
		}
		return stringBuilder.ToString();
	}

	private int FindPrimeIndex(int capacity)
	{
		for (int i = 0; i < primes.Length; i++)
		{
			if (primes[i] >= capacity)
			{
				return i;
			}
		}
		throw new Exception("Maximum set capacity exceeded!");
	}

	private void IncreaseCapacity()
	{
		int num = primes[primeIndex++];
		int[] array = new int[num];
		for (int i = 0; i < num; i++)
		{
			array[i] = -1;
		}
		Entry[] array2 = new Entry[num];
		if (count > 0)
		{
			Array.Copy(entries, 0, array2, 0, count);
			for (int j = 0; j < count; j++)
			{
				if (array2[j].hashCode >= 0)
				{
					int num2 = array2[j].hashCode % num;
					array2[j].next = array[num2];
					array[num2] = j;
				}
			}
		}
		buckets = array;
		entries = array2;
	}

	private int FindEntry(T item)
	{
		int num = comparer.GetHashCode(item) & 0x7FFFFFFF;
		for (int num2 = buckets[num % buckets.Length]; num2 >= 0; num2 = entries[num2].next)
		{
			if (entries[num2].hashCode == num && comparer.Equals(entries[num2].item, item))
			{
				return num2;
			}
		}
		return -1;
	}

	static FastSet()
	{
		//IL_000d: Field data (rva=0x490) could not be found in any section!
		//IL_000d: Field data (rva=0x490) could not be found in any section!
		int[] array = new int[21];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		primes = array;
	}
}
