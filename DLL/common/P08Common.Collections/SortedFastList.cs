using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace P08Common.Collections;

public sealed class SortedFastList<T> : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable where T : IComparable<T>
{
	public T[] array;

	public int count;

	private static readonly T[] EMPTY_ARRAY = new T[0];

	private const int STARTING_SIZE = 8;

	private const int GROW_FACTOR = 2;

	public int Count => count;

	public int Capacity
	{
		get
		{
			return array.Length;
		}
		set
		{
			if (value == 0)
			{
				Array.Clear(array, 0, count);
				count = 0;
				array = EMPTY_ARRAY;
			}
			else if (count > 0)
			{
				T[] destinationArray = new T[value];
				Array.Copy(array, 0, destinationArray, 0, Math.Min(count, value));
				Array.Clear(array, 0, count);
				count = Math.Min(count, value);
				array = destinationArray;
			}
			else
			{
				array = new T[value];
			}
		}
	}

	public bool IsReadOnly => false;

	public T Last => array[count - 1];

	public T SecondLast
	{
		get
		{
			return array[count - 2];
		}
		set
		{
			array[count - 2] = value;
		}
	}

	public T this[int index]
	{
		get
		{
			if (index < count)
			{
				return array[index];
			}
			throw new ArgumentOutOfRangeException();
		}
		set
		{
			Add(value);
		}
	}

	public SortedFastList()
	{
		array = EMPTY_ARRAY;
	}

	public SortedFastList(int capacity)
	{
		array = new T[capacity];
	}

	public SortedFastList(SortedFastList<T> list)
	{
		array = new T[list.Count];
		Array.Copy(list.array, array, list.count);
		count = list.count;
	}

	public void Add(T item)
	{
		if (count == array.Length)
		{
			if (count == 0)
			{
				array = new T[8];
			}
			else
			{
				Capacity = count * 2;
			}
		}
		int num = BinarySearch(item);
		Insert((num < 0) ? (~num) : num, item);
		count++;
	}

	public void Add(SortedFastList<T> list)
	{
		if (count == 0)
		{
			if (array.Length < list.count)
			{
				array = new T[Math.Max(8, list.count)];
			}
			Array.Copy(list.array, array, list.count);
			count = list.count;
			return;
		}
		if (array.Length < count + list.count)
		{
			Capacity = Math.Max(array.Length * 2, count + list.count);
		}
		for (int i = 0; i < list.count; i++)
		{
			T item = list.array[i];
			int num = BinarySearch(item);
			Insert((num < 0) ? (~num) : num, item);
			count++;
		}
	}

	public void Add(FastList<T> list)
	{
		if (array.Length < count + list.count)
		{
			Capacity = Max(8, array.Length * 2, count + list.count);
		}
		for (int i = 0; i < list.count; i++)
		{
			T item = list.array[i];
			int num = BinarySearch(item);
			Insert((num < 0) ? (~num) : num, item);
			count++;
		}
	}

	private int Max(int a, int b, int c)
	{
		if (a <= b)
		{
			return Max(b, c);
		}
		return Max(a, c);
	}

	private int Max(int a, int b)
	{
		if (a > b)
		{
			return a;
		}
		return b;
	}

	public void Insert(int index, T item)
	{
		if (index < count)
		{
			Array.Copy(array, index, array, index + 1, count - index);
		}
		array[index] = item;
	}

	public void RemoveLast()
	{
		count--;
		array[count] = default(T);
	}

	public T Pop()
	{
		T result = array[--count];
		array[count] = default(T);
		return result;
	}

	public void RemoveAt(int index)
	{
		count--;
		if (index < count)
		{
			Array.Copy(array, index + 1, array, index, count - index);
		}
		array[count] = default(T);
	}

	public bool Remove(T item)
	{
		int num = BinarySearch(item);
		if (num >= 0)
		{
			RemoveAt(num);
			return true;
		}
		return false;
	}

	public void RemoveAll(T item)
	{
		for (int num = BinarySearch(item); num >= 0; num = BinarySearch(item))
		{
			RemoveAt(num);
		}
	}

	public void Clear()
	{
		Array.Clear(array, 0, count);
		count = 0;
	}

	public void TrimExcess()
	{
		Capacity = count;
	}

	public void CopyTo(T[] array)
	{
		Array.Copy(this.array, 0, array, 0, count);
	}

	public void CopyTo(T[] array, int index)
	{
		Array.Copy(this.array, 0, array, index, count);
	}

	public void CopyTo(T[] array, int index, int length)
	{
		Array.Copy(this.array, 0, array, index, length);
	}

	public T[] ToArray()
	{
		T[] array = new T[count];
		Array.Copy(this.array, 0, array, 0, count);
		return array;
	}

	public bool IsCopyOf(SortedFastList<T> list)
	{
		if (list == null)
		{
			return this == null;
		}
		if (this == list)
		{
			return true;
		}
		if (count != list.count)
		{
			return false;
		}
		EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		for (int i = 0; i < count; i++)
		{
			if (!equalityComparer.Equals(array[i], list.array[i]))
			{
				return false;
			}
		}
		return true;
	}

	public bool Contains(T item)
	{
		return BinarySearch(item) >= 0;
	}

	public bool TrueForAll(Predicate<T> predicate)
	{
		for (int i = 0; i < count; i++)
		{
			if (!predicate(array[i]))
			{
				return false;
			}
		}
		return true;
	}

	public bool TrueForAny(Predicate<T> predicate)
	{
		for (int i = 0; i < count; i++)
		{
			if (predicate(array[i]))
			{
				return true;
			}
		}
		return false;
	}

	public void ForEach(Action<T> action)
	{
		for (int i = 0; i < count; i++)
		{
			action(array[i]);
		}
	}

	public int IndexOf(T item)
	{
		return BinarySearch(item);
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < count; i++)
		{
			stringBuilder.Append(this[i].ToString());
			stringBuilder.Append("\n");
		}
		return stringBuilder.ToString();
	}

	private int BinarySearch(T item)
	{
		int num = 0;
		int num2 = count - 1;
		while (num <= num2)
		{
			int num3 = num + (num2 - num >> 1);
			int num4 = num3;
			int num5 = array[num4].CompareTo(item);
			if (num5 == 0)
			{
				return num4;
			}
			if (num5 < 0)
			{
				num = num3 + 1;
			}
			else
			{
				num2 = num3 - 1;
			}
		}
		return ~num;
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public IEnumerator<T> GetEnumerator()
	{
		for (int i = 0; i < count; i++)
		{
			yield return array[i];
		}
	}
}
public sealed class SortedFastList<TKey, TValue> where TKey : IComparable<TKey>
{
	public KeyValuePair<TKey, TValue>[] array;

	public int count;

	private static readonly KeyValuePair<TKey, TValue>[] EMPTY_ARRAY = new KeyValuePair<TKey, TValue>[0];

	private const int STARTING_SIZE = 8;

	private const int GROW_FACTOR = 2;

	public int Count => count;

	public int Capacity
	{
		get
		{
			return array.Length;
		}
		set
		{
			if (value == 0)
			{
				Array.Clear(array, 0, count);
				count = 0;
				array = EMPTY_ARRAY;
			}
			else if (count > 0)
			{
				KeyValuePair<TKey, TValue>[] destinationArray = new KeyValuePair<TKey, TValue>[value];
				Array.Copy(array, 0, destinationArray, 0, Math.Min(count, value));
				Array.Clear(array, 0, count);
				count = Math.Min(count, value);
				array = destinationArray;
			}
			else
			{
				array = new KeyValuePair<TKey, TValue>[value];
			}
		}
	}

	public bool IsReadOnly => false;

	public KeyValuePair<TKey, TValue> Last => array[count - 1];

	public KeyValuePair<TKey, TValue> SecondLast
	{
		get
		{
			return array[count - 2];
		}
		set
		{
			array[count - 2] = value;
		}
	}

	public KeyValuePair<TKey, TValue> this[int index]
	{
		get
		{
			if (index < count)
			{
				return array[index];
			}
			throw new ArgumentOutOfRangeException();
		}
		set
		{
			Add(value);
		}
	}

	public SortedFastList()
	{
		array = EMPTY_ARRAY;
	}

	public SortedFastList(int capacity)
	{
		array = new KeyValuePair<TKey, TValue>[capacity];
	}

	public SortedFastList(SortedFastList<TKey, TValue> list)
	{
		array = new KeyValuePair<TKey, TValue>[list.Count];
		Array.Copy(list.array, array, list.count);
		count = list.count;
	}

	public void Add(KeyValuePair<TKey, TValue> item)
	{
		if (count == array.Length)
		{
			if (count == 0)
			{
				array = new KeyValuePair<TKey, TValue>[8];
			}
			else
			{
				Capacity = count * 2;
			}
		}
		int num = BinarySearch(item);
		Insert((num < 0) ? (~num) : num, item);
		count++;
	}

	public void Add(TKey key, TValue value)
	{
		if (count == array.Length)
		{
			if (count == 0)
			{
				array = new KeyValuePair<TKey, TValue>[8];
			}
			else
			{
				Capacity = count * 2;
			}
		}
		KeyValuePair<TKey, TValue> item = new KeyValuePair<TKey, TValue>(key, value);
		int num = BinarySearch(item);
		Insert((num < 0) ? (~num) : num, item);
		count++;
	}

	public void Add(SortedFastList<TKey, TValue> list)
	{
		if (count == 0)
		{
			if (array.Length < list.count)
			{
				array = new KeyValuePair<TKey, TValue>[Math.Max(8, list.count)];
			}
			Array.Copy(list.array, array, list.count);
			count = list.count;
			return;
		}
		if (array.Length < count + list.count)
		{
			Capacity = Math.Max(array.Length * 2, count + list.count);
		}
		for (int i = 0; i < list.count; i++)
		{
			KeyValuePair<TKey, TValue> item = list.array[i];
			int num = BinarySearch(item);
			Insert((num < 0) ? (~num) : num, item);
			count++;
		}
	}

	public void Add(FastList<KeyValuePair<TKey, TValue>> list)
	{
		if (array.Length < count + list.count)
		{
			Capacity = Max(8, array.Length * 2, count + list.count);
		}
		for (int i = 0; i < list.count; i++)
		{
			KeyValuePair<TKey, TValue> item = list.array[i];
			int num = BinarySearch(item);
			Insert((num < 0) ? (~num) : num, item);
			count++;
		}
	}

	private int Max(int a, int b, int c)
	{
		if (a <= b)
		{
			return Max(b, c);
		}
		return Max(a, c);
	}

	private int Max(int a, int b)
	{
		if (a > b)
		{
			return a;
		}
		return b;
	}

	public void Insert(int index, KeyValuePair<TKey, TValue> item)
	{
		if (index < count)
		{
			Array.Copy(array, index, array, index + 1, count - index);
		}
		array[index] = item;
	}

	public void RemoveLast()
	{
		count--;
		array[count] = default(KeyValuePair<TKey, TValue>);
	}

	public KeyValuePair<TKey, TValue> Pop()
	{
		KeyValuePair<TKey, TValue> result = array[--count];
		array[count] = default(KeyValuePair<TKey, TValue>);
		return result;
	}

	public void RemoveAt(int index)
	{
		count--;
		if (index < count)
		{
			Array.Copy(array, index + 1, array, index, count - index);
		}
		array[count] = default(KeyValuePair<TKey, TValue>);
	}

	public bool Remove(KeyValuePair<TKey, TValue> item)
	{
		int num = BinarySearch(item);
		if (num >= 0)
		{
			RemoveAt(num);
			return true;
		}
		return false;
	}

	public void RemoveAll(KeyValuePair<TKey, TValue> item)
	{
		for (int num = BinarySearch(item); num >= 0; num = BinarySearch(item))
		{
			RemoveAt(num);
		}
	}

	public void Clear()
	{
		Array.Clear(array, 0, count);
		count = 0;
	}

	public void TrimExcess()
	{
		Capacity = count;
	}

	public void CopyTo(KeyValuePair<TKey, TValue>[] array)
	{
		Array.Copy(this.array, 0, array, 0, count);
	}

	public void CopyTo(KeyValuePair<TKey, TValue>[] array, int index)
	{
		Array.Copy(this.array, 0, array, index, count);
	}

	public void CopyTo(KeyValuePair<TKey, TValue>[] array, int index, int length)
	{
		Array.Copy(this.array, 0, array, index, length);
	}

	public KeyValuePair<TKey, TValue>[] ToArray()
	{
		KeyValuePair<TKey, TValue>[] array = new KeyValuePair<TKey, TValue>[count];
		Array.Copy(this.array, 0, array, 0, count);
		return array;
	}

	public bool IsCopyOf(SortedFastList<TKey, TValue> list)
	{
		if (list == null)
		{
			return this == null;
		}
		if (this == list)
		{
			return true;
		}
		if (count != list.count)
		{
			return false;
		}
		EqualityComparer<KeyValuePair<TKey, TValue>> equalityComparer = EqualityComparer<KeyValuePair<TKey, TValue>>.Default;
		for (int i = 0; i < count; i++)
		{
			if (!equalityComparer.Equals(array[i], list.array[i]))
			{
				return false;
			}
		}
		return true;
	}

	public bool Contains(KeyValuePair<TKey, TValue> item)
	{
		return BinarySearch(item) >= 0;
	}

	public bool TrueForAll(Predicate<KeyValuePair<TKey, TValue>> predicate)
	{
		for (int i = 0; i < count; i++)
		{
			if (!predicate(array[i]))
			{
				return false;
			}
		}
		return true;
	}

	public bool TrueForAny(Predicate<KeyValuePair<TKey, TValue>> predicate)
	{
		for (int i = 0; i < count; i++)
		{
			if (predicate(array[i]))
			{
				return true;
			}
		}
		return false;
	}

	public void ForEach(Action<KeyValuePair<TKey, TValue>> action)
	{
		for (int i = 0; i < count; i++)
		{
			action(array[i]);
		}
	}

	public int IndexOf(KeyValuePair<TKey, TValue> item)
	{
		return BinarySearch(item);
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < count; i++)
		{
			stringBuilder.Append(this[i].ToString());
			stringBuilder.Append("\n");
		}
		return stringBuilder.ToString();
	}

	private int BinarySearch(KeyValuePair<TKey, TValue> item)
	{
		int num = 0;
		int num2 = count - 1;
		while (num <= num2)
		{
			int num3 = num + (num2 - num >> 1);
			int num4 = num3;
			int num5 = array[num4].Key.CompareTo(item.Key);
			if (num5 == 0)
			{
				return num4;
			}
			if (num5 < 0)
			{
				num = num3 + 1;
			}
			else
			{
				num2 = num3 - 1;
			}
		}
		return ~num;
	}
}
