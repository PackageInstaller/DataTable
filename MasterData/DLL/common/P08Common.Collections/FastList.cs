using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace P08Common.Collections;

[Serializable]
public class FastList<T> : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable
{
	public T[] array;

	public int count;

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
				array = new T[0];
			}
			else if (count > 0)
			{
				T[] destinationArray = new T[value];
				Array.Copy(array, 0, destinationArray, 0, Math.Min(count, value));
				if (value < count)
				{
					count = value;
				}
				array = destinationArray;
			}
			else
			{
				array = new T[value];
			}
		}
	}

	public bool IsReadOnly => false;

	public T Last
	{
		get
		{
			return array[count - 1];
		}
		set
		{
			array[count - 1] = value;
		}
	}

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
			if (index < count)
			{
				array[index] = value;
				return;
			}
			throw new ArgumentOutOfRangeException();
		}
	}

	public FastList()
	{
		array = new T[0];
	}

	public FastList(int capacity)
	{
		array = new T[capacity];
	}

	public FastList(FastList<T> list)
	{
		array = new T[list.Count];
		list.CopyTo(this);
	}

	public FastList(IList<T> list)
	{
		array = new T[list.Count];
		for (int i = 0; i < list.Count; i++)
		{
			array[i] = list[i];
		}
		count = list.Count;
	}

	public FastList(T[] array, int count)
	{
		this.array = array;
		this.count = count;
	}

	public FastList(T[] array)
	{
		this.array = array;
		count = array.Length;
	}

	public FastList(T item)
	{
		array = new T[1];
		array[0] = item;
		count = 1;
	}

	public void Add(T item)
	{
		if (count == array.Length)
		{
			Grow();
		}
		array[count] = item;
		count++;
	}

	public void Add(FastList<T> list)
	{
		list.CopyTo(this);
	}

	public void Add(T[] array)
	{
		if (Capacity < count + array.Length)
		{
			Capacity = Math.Max(count + array.Length, Capacity * 2);
		}
		Array.Copy(array, 0, this.array, count, array.Length);
		count += array.Length;
	}

	public void Insert(int index, T item)
	{
		if (index > count)
		{
			throw new ArgumentOutOfRangeException();
		}
		if (count == array.Length)
		{
			Grow();
		}
		if (index < count)
		{
			Array.Copy(array, index, array, index + 1, count - index);
		}
		array[index] = item;
		count++;
	}

	public void RemoveLast()
	{
		count--;
		array[count] = default(T);
	}

	public T Pop()
	{
		return array[--count];
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
		int num = Array.IndexOf(array, item, 0, count);
		if (num >= 0)
		{
			RemoveAt(num);
			return true;
		}
		return false;
	}

	public void RemoveAll(T item)
	{
		for (int num = Array.IndexOf(array, item, 0, count); num >= 0; num = Array.IndexOf(array, item, num, count - num))
		{
			RemoveAt(num);
		}
	}

	public void QuickRemoveAt(int index)
	{
		count--;
		if (index < count)
		{
			array[index] = array[count];
		}
		array[count] = default(T);
	}

	public bool QuickRemove(T item)
	{
		int num = Array.IndexOf(array, item, 0, count);
		if (num >= 0)
		{
			QuickRemoveAt(num);
			return true;
		}
		return false;
	}

	public void QuickRemoveAll(T item)
	{
		for (int num = Array.IndexOf(array, item, 0, count); num >= 0; num = Array.IndexOf(array, item, num, count - num))
		{
			QuickRemoveAt(num);
		}
	}

	public void Clear()
	{
		if (count > 0)
		{
			Array.Clear(array, 0, count);
			count = 0;
		}
	}

	public void FastClear()
	{
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

	public void CopyTo(FastList<T> list)
	{
		if (list.Capacity < list.count + count)
		{
			list.Capacity = Math.Max(list.array.Length * 2, count + list.count);
		}
		Array.Copy(array, 0, list.array, list.count, count);
		list.count += count;
	}

	public bool IsCopyOf(FastList<T> list)
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
		if (item == null)
		{
			for (int i = 0; i < count; i++)
			{
				if (array[i] == null)
				{
					return true;
				}
			}
		}
		else
		{
			EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
			for (int j = 0; j < count; j++)
			{
				if (equalityComparer.Equals(array[j], item))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool ContainsDifferent(T item)
	{
		if (item == null)
		{
			for (int i = 0; i < count; i++)
			{
				if (array[i] != null)
				{
					return true;
				}
			}
		}
		else
		{
			EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
			for (int j = 0; j < count; j++)
			{
				if (!equalityComparer.Equals(array[j], item))
				{
					return true;
				}
			}
		}
		return false;
	}

	public int IndexOf(T item)
	{
		return Array.IndexOf(array, item);
	}

	public void Reverse()
	{
		int num = count / 2;
		int num2 = count - 1;
		for (int i = 0; i < num; i++)
		{
			int num3 = num2 - i;
			T val = array[i];
			array[i] = array[num3];
			array[num3] = val;
		}
	}

	public void Reverse(int begin, int end)
	{
		int num = begin + (end - begin) / 2;
		int num2 = end - 1;
		for (int i = begin; i < num; i++)
		{
			int num3 = num2 - i;
			T val = array[i];
			array[i] = array[num3];
			array[num3] = val;
		}
	}

	public void Sort()
	{
		Array.Sort(array, 0, count);
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

	private void Grow()
	{
		if (count == 0)
		{
			array = new T[8];
		}
		else
		{
			Capacity = array.Length * 2;
		}
	}

	public void ForEach(Action<T> action)
	{
		for (int i = 0; i < count; i++)
		{
			action(array[i]);
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
			yield return array[i];
		}
	}
}
