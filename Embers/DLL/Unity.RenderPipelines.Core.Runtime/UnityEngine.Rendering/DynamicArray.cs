using System;

namespace UnityEngine.Rendering;

public class DynamicArray<T> where T : new()
{
	private T[] m_Array;

	public int size { get; private set; }

	public int capacity => m_Array.Length;

	public ref T this[int index] => ref m_Array[index];

	public DynamicArray()
	{
		m_Array = new T[32];
		size = 0;
	}

	public DynamicArray(int size)
	{
		m_Array = new T[size];
		this.size = size;
	}

	public void Clear()
	{
		size = 0;
	}

	public bool Contains(T item)
	{
		return IndexOf(item) != -1;
	}

	public int Add(in T value)
	{
		int num = size;
		if (num >= m_Array.Length)
		{
			T[] array = new T[m_Array.Length * 2];
			Array.Copy(m_Array, array, m_Array.Length);
			m_Array = array;
		}
		m_Array[num] = value;
		size++;
		return num;
	}

	public void AddRange(DynamicArray<T> array)
	{
		Reserve(size + array.size, keepContent: true);
		for (int i = 0; i < array.size; i++)
		{
			m_Array[size++] = array[i];
		}
	}

	public bool Remove(T item)
	{
		int num = IndexOf(item);
		if (num != -1)
		{
			RemoveAt(num);
			return true;
		}
		return false;
	}

	public void RemoveAt(int index)
	{
		if (index < 0 || index >= size)
		{
			throw new IndexOutOfRangeException();
		}
		if (index != size - 1)
		{
			Array.Copy(m_Array, index + 1, m_Array, index, size - index - 1);
		}
		size--;
	}

	public void RemoveRange(int index, int count)
	{
		if (index < 0 || index >= size || count < 0 || index + count > size)
		{
			throw new ArgumentOutOfRangeException();
		}
		Array.Copy(m_Array, index + count, m_Array, index, size - index - count);
		size -= count;
	}

	public int FindIndex(int startIndex, int count, Predicate<T> match)
	{
		for (int i = startIndex; i < size; i++)
		{
			if (match(m_Array[i]))
			{
				return i;
			}
		}
		return -1;
	}

	public int IndexOf(T item, int index, int count)
	{
		int num = index;
		while (num < size && count > 0)
		{
			if (m_Array[num].Equals(item))
			{
				return num;
			}
			num++;
			count--;
		}
		return -1;
	}

	public int IndexOf(T item, int index)
	{
		for (int i = index; i < size; i++)
		{
			if (m_Array[i].Equals(item))
			{
				return i;
			}
		}
		return -1;
	}

	public int IndexOf(T item)
	{
		return IndexOf(item, 0);
	}

	public void Resize(int newSize, bool keepContent = false)
	{
		Reserve(newSize, keepContent);
		size = newSize;
	}

	public void Reserve(int newCapacity, bool keepContent = false)
	{
		if (newCapacity > m_Array.Length)
		{
			if (keepContent)
			{
				T[] array = new T[newCapacity];
				Array.Copy(m_Array, array, m_Array.Length);
				m_Array = array;
			}
			else
			{
				m_Array = new T[newCapacity];
			}
		}
	}

	public static implicit operator T[](DynamicArray<T> array)
	{
		return array.m_Array;
	}
}
