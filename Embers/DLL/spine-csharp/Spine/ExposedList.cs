using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;

namespace Spine;

[DebuggerDisplay("Count={Count}")]
public class ExposedList<T> : IEnumerable<T>, IEnumerable
{
	public struct Enumerator : IEnumerator<T>, IEnumerator, IDisposable
	{
		private ExposedList<T> l;

		private int next;

		private int ver;

		private T current;

		public T Current => current;

		object IEnumerator.Current
		{
			get
			{
				VerifyState();
				if (next <= 0)
				{
					throw new InvalidOperationException();
				}
				return current;
			}
		}

		internal Enumerator(ExposedList<T> l)
		{
			this = default(Enumerator);
			this.l = l;
			ver = l.version;
		}

		public void Dispose()
		{
			l = null;
		}

		private void VerifyState()
		{
			if (l == null)
			{
				throw new ObjectDisposedException(GetType().FullName);
			}
			if (ver != l.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
		}

		public bool MoveNext()
		{
			VerifyState();
			if (next < 0)
			{
				return false;
			}
			if (next < l.Count)
			{
				current = l.Items[next++];
				return true;
			}
			next = -1;
			return false;
		}

		void IEnumerator.Reset()
		{
			VerifyState();
			next = 0;
		}
	}

	public T[] Items;

	public int Count;

	private const int DefaultCapacity = 4;

	private static readonly T[] EmptyArray = new T[0];

	private int version;

	public int Capacity
	{
		get
		{
			return Items.Length;
		}
		set
		{
			if ((uint)value < (uint)Count)
			{
				throw new ArgumentOutOfRangeException();
			}
			Array.Resize(ref Items, value);
		}
	}

	public ExposedList()
	{
		Items = EmptyArray;
	}

	public ExposedList(IEnumerable<T> collection)
	{
		CheckCollection(collection);
		if (!(collection is ICollection<T> collection2))
		{
			Items = EmptyArray;
			AddEnumerable(collection);
		}
		else
		{
			Items = new T[collection2.Count];
			AddCollection(collection2);
		}
	}

	public ExposedList(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity");
		}
		Items = new T[capacity];
	}

	internal ExposedList(T[] data, int size)
	{
		Items = data;
		Count = size;
	}

	public void Add(T item)
	{
		if (Count == Items.Length)
		{
			GrowIfNeeded(1);
		}
		Items[Count++] = item;
		version++;
	}

	public void GrowIfNeeded(int addedCount)
	{
		int num = Count + addedCount;
		if (num > Items.Length)
		{
			Capacity = Math.Max(Math.Max(Capacity * 2, 4), num);
		}
	}

	public ExposedList<T> Resize(int newSize)
	{
		int num = Items.Length;
		T[] items = Items;
		if (newSize > num)
		{
			Array.Resize(ref Items, newSize);
		}
		else if (newSize < num)
		{
			for (int i = newSize; i < num; i++)
			{
				items[i] = default(T);
			}
		}
		Count = newSize;
		return this;
	}

	public void EnsureCapacity(int min)
	{
		if (Items.Length < min)
		{
			int num = ((Items.Length == 0) ? 4 : (Items.Length * 2));
			if (num < min)
			{
				num = min;
			}
			Capacity = num;
		}
	}

	private void CheckRange(int index, int count)
	{
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		if ((uint)(index + count) > (uint)Count)
		{
			throw new ArgumentException("index and count exceed length of list");
		}
	}

	private void AddCollection(ICollection<T> collection)
	{
		int count = collection.Count;
		if (count != 0)
		{
			GrowIfNeeded(count);
			collection.CopyTo(Items, Count);
			Count += count;
		}
	}

	private void AddEnumerable(IEnumerable<T> enumerable)
	{
		foreach (T item in enumerable)
		{
			Add(item);
		}
	}

	public void AddRange(ExposedList<T> list)
	{
		CheckCollection(list);
		int count = list.Count;
		if (count != 0)
		{
			GrowIfNeeded(count);
			list.CopyTo(Items, Count);
			Count += count;
			version++;
		}
	}

	public void AddRange(IEnumerable<T> collection)
	{
		CheckCollection(collection);
		if (collection is ICollection<T> collection2)
		{
			AddCollection(collection2);
		}
		else
		{
			AddEnumerable(collection);
		}
		version++;
	}

	public int BinarySearch(T item)
	{
		return Array.BinarySearch(Items, 0, Count, item);
	}

	public int BinarySearch(T item, IComparer<T> comparer)
	{
		return Array.BinarySearch(Items, 0, Count, item, comparer);
	}

	public int BinarySearch(int index, int count, T item, IComparer<T> comparer)
	{
		CheckRange(index, count);
		return Array.BinarySearch(Items, index, count, item, comparer);
	}

	public void Clear(bool clearArray = true)
	{
		if (clearArray)
		{
			Array.Clear(Items, 0, Items.Length);
		}
		Count = 0;
		version++;
	}

	public bool Contains(T item)
	{
		return Array.IndexOf(Items, item, 0, Count) != -1;
	}

	public ExposedList<TOutput> ConvertAll<TOutput>(Converter<T, TOutput> converter)
	{
		if (converter == null)
		{
			throw new ArgumentNullException("converter");
		}
		ExposedList<TOutput> exposedList = new ExposedList<TOutput>(Count);
		exposedList.Count = Count;
		T[] items = Items;
		TOutput[] items2 = exposedList.Items;
		for (int i = 0; i < Count; i++)
		{
			items2[i] = converter(items[i]);
		}
		return exposedList;
	}

	public void CopyTo(T[] array)
	{
		Array.Copy(Items, 0, array, 0, Count);
	}

	public void CopyTo(T[] array, int arrayIndex)
	{
		Array.Copy(Items, 0, array, arrayIndex, Count);
	}

	public void CopyTo(int index, T[] array, int arrayIndex, int count)
	{
		CheckRange(index, count);
		Array.Copy(Items, index, array, arrayIndex, count);
	}

	public bool Exists(Predicate<T> match)
	{
		CheckMatch(match);
		return GetIndex(0, Count, match) != -1;
	}

	public T Find(Predicate<T> match)
	{
		CheckMatch(match);
		int index = GetIndex(0, Count, match);
		if (index == -1)
		{
			return default(T);
		}
		return Items[index];
	}

	private static void CheckMatch(Predicate<T> match)
	{
		if (match == null)
		{
			throw new ArgumentNullException("match");
		}
	}

	public ExposedList<T> FindAll(Predicate<T> match)
	{
		CheckMatch(match);
		return FindAllList(match);
	}

	private ExposedList<T> FindAllList(Predicate<T> match)
	{
		ExposedList<T> exposedList = new ExposedList<T>();
		for (int i = 0; i < Count; i++)
		{
			if (match(Items[i]))
			{
				exposedList.Add(Items[i]);
			}
		}
		return exposedList;
	}

	public int FindIndex(Predicate<T> match)
	{
		CheckMatch(match);
		return GetIndex(0, Count, match);
	}

	public int FindIndex(int startIndex, Predicate<T> match)
	{
		CheckMatch(match);
		CheckIndex(startIndex);
		return GetIndex(startIndex, Count - startIndex, match);
	}

	public int FindIndex(int startIndex, int count, Predicate<T> match)
	{
		CheckMatch(match);
		CheckRange(startIndex, count);
		return GetIndex(startIndex, count, match);
	}

	private int GetIndex(int startIndex, int count, Predicate<T> match)
	{
		int num = startIndex + count;
		for (int i = startIndex; i < num; i++)
		{
			if (match(Items[i]))
			{
				return i;
			}
		}
		return -1;
	}

	public T FindLast(Predicate<T> match)
	{
		CheckMatch(match);
		int lastIndex = GetLastIndex(0, Count, match);
		if (lastIndex != -1)
		{
			return Items[lastIndex];
		}
		return default(T);
	}

	public int FindLastIndex(Predicate<T> match)
	{
		CheckMatch(match);
		return GetLastIndex(0, Count, match);
	}

	public int FindLastIndex(int startIndex, Predicate<T> match)
	{
		CheckMatch(match);
		CheckIndex(startIndex);
		return GetLastIndex(0, startIndex + 1, match);
	}

	public int FindLastIndex(int startIndex, int count, Predicate<T> match)
	{
		CheckMatch(match);
		int num = startIndex - count + 1;
		CheckRange(num, count);
		return GetLastIndex(num, count, match);
	}

	private int GetLastIndex(int startIndex, int count, Predicate<T> match)
	{
		int num = startIndex + count;
		while (num != startIndex)
		{
			if (match(Items[--num]))
			{
				return num;
			}
		}
		return -1;
	}

	public void ForEach(Action<T> action)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		for (int i = 0; i < Count; i++)
		{
			action(Items[i]);
		}
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	public ExposedList<T> GetRange(int index, int count)
	{
		CheckRange(index, count);
		T[] array = new T[count];
		Array.Copy(Items, index, array, 0, count);
		return new ExposedList<T>(array, count);
	}

	public int IndexOf(T item)
	{
		return Array.IndexOf(Items, item, 0, Count);
	}

	public int IndexOf(T item, int index)
	{
		CheckIndex(index);
		return Array.IndexOf(Items, item, index, Count - index);
	}

	public int IndexOf(T item, int index, int count)
	{
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		if ((uint)(index + count) > (uint)Count)
		{
			throw new ArgumentOutOfRangeException("index and count exceed length of list");
		}
		return Array.IndexOf(Items, item, index, count);
	}

	private void Shift(int start, int delta)
	{
		if (delta < 0)
		{
			start -= delta;
		}
		if (start < Count)
		{
			Array.Copy(Items, start, Items, start + delta, Count - start);
		}
		Count += delta;
		if (delta < 0)
		{
			Array.Clear(Items, Count, -delta);
		}
	}

	private void CheckIndex(int index)
	{
		if (index < 0 || (uint)index > (uint)Count)
		{
			throw new ArgumentOutOfRangeException("index");
		}
	}

	public void Insert(int index, T item)
	{
		CheckIndex(index);
		if (Count == Items.Length)
		{
			GrowIfNeeded(1);
		}
		Shift(index, 1);
		Items[index] = item;
		version++;
	}

	private void CheckCollection(IEnumerable<T> collection)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
	}

	public void InsertRange(int index, IEnumerable<T> collection)
	{
		CheckCollection(collection);
		CheckIndex(index);
		if (collection == this)
		{
			T[] array = new T[Count];
			CopyTo(array, 0);
			GrowIfNeeded(Count);
			Shift(index, array.Length);
			Array.Copy(array, 0, Items, index, array.Length);
		}
		else if (collection is ICollection<T> collection2)
		{
			InsertCollection(index, collection2);
		}
		else
		{
			InsertEnumeration(index, collection);
		}
		version++;
	}

	private void InsertCollection(int index, ICollection<T> collection)
	{
		int count = collection.Count;
		GrowIfNeeded(count);
		Shift(index, count);
		collection.CopyTo(Items, index);
	}

	private void InsertEnumeration(int index, IEnumerable<T> enumerable)
	{
		foreach (T item in enumerable)
		{
			Insert(index++, item);
		}
	}

	public int LastIndexOf(T item)
	{
		return Array.LastIndexOf(Items, item, Count - 1, Count);
	}

	public int LastIndexOf(T item, int index)
	{
		CheckIndex(index);
		return Array.LastIndexOf(Items, item, index, index + 1);
	}

	public int LastIndexOf(T item, int index, int count)
	{
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", index, "index is negative");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", count, "count is negative");
		}
		if (index - count + 1 < 0)
		{
			throw new ArgumentOutOfRangeException("count", count, "count is too large");
		}
		return Array.LastIndexOf(Items, item, index, count);
	}

	public bool Remove(T item)
	{
		int num = IndexOf(item);
		if (num != -1)
		{
			RemoveAt(num);
		}
		return num != -1;
	}

	public int RemoveAll(Predicate<T> match)
	{
		CheckMatch(match);
		int num = 0;
		int num2 = 0;
		for (num = 0; num < Count && !match(Items[num]); num++)
		{
		}
		if (num == Count)
		{
			return 0;
		}
		version++;
		for (num2 = num + 1; num2 < Count; num2++)
		{
			if (!match(Items[num2]))
			{
				Items[num++] = Items[num2];
			}
		}
		if (num2 - num > 0)
		{
			Array.Clear(Items, num, num2 - num);
		}
		Count = num;
		return num2 - num;
	}

	public void RemoveAt(int index)
	{
		if (index < 0 || (uint)index >= (uint)Count)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		Shift(index, -1);
		Array.Clear(Items, Count, 1);
		version++;
	}

	public T Pop()
	{
		if (Count == 0)
		{
			throw new InvalidOperationException("List is empty. Nothing to pop.");
		}
		int num = Count - 1;
		T result = Items[num];
		Items[num] = default(T);
		Count--;
		version++;
		return result;
	}

	public void RemoveRange(int index, int count)
	{
		CheckRange(index, count);
		if (count > 0)
		{
			Shift(index, -count);
			Array.Clear(Items, Count, count);
			version++;
		}
	}

	public void Reverse()
	{
		Array.Reverse(Items, 0, Count);
		version++;
	}

	public void Reverse(int index, int count)
	{
		CheckRange(index, count);
		Array.Reverse(Items, index, count);
		version++;
	}

	public void Sort()
	{
		Array.Sort(Items, 0, Count, Comparer<T>.Default);
		version++;
	}

	public void Sort(IComparer<T> comparer)
	{
		Array.Sort(Items, 0, Count, comparer);
		version++;
	}

	public void Sort(Comparison<T> comparison)
	{
		Array.Sort(Items, comparison);
		version++;
	}

	public void Sort(int index, int count, IComparer<T> comparer)
	{
		CheckRange(index, count);
		Array.Sort(Items, index, count, comparer);
		version++;
	}

	public T[] ToArray()
	{
		T[] array = new T[Count];
		Array.Copy(Items, array, Count);
		return array;
	}

	public void TrimExcess()
	{
		Capacity = Count;
	}

	public bool TrueForAll(Predicate<T> match)
	{
		CheckMatch(match);
		for (int i = 0; i < Count; i++)
		{
			if (!match(Items[i]))
			{
				return false;
			}
		}
		return true;
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
