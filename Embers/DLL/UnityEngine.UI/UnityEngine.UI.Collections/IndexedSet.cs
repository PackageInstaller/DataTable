using System;
using System.Collections;
using System.Collections.Generic;

namespace UnityEngine.UI.Collections;

internal class IndexedSet<T> : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable
{
	private readonly List<T> m_List = new List<T>();

	private Dictionary<T, int> m_Dictionary = new Dictionary<T, int>();

	private int m_EnabledObjectCount;

	public int Count => m_EnabledObjectCount;

	public int Capacity => m_List.Count;

	public bool IsReadOnly => false;

	public T this[int index]
	{
		get
		{
			if ((uint)index >= (uint)m_EnabledObjectCount)
			{
				throw new IndexOutOfRangeException();
			}
			return m_List[index];
		}
		set
		{
			T key = m_List[index];
			m_Dictionary.Remove(key);
			m_List[index] = value;
			m_Dictionary.Add(value, index);
		}
	}

	public void Add(T item)
	{
		Add(item, isActive: true);
	}

	public void Add(T item, bool isActive)
	{
		m_List.Add(item);
		m_Dictionary.Add(item, m_List.Count - 1);
		if (isActive)
		{
			EnableItem(item);
		}
	}

	public bool AddUnique(T item, bool isActive = true)
	{
		if (m_Dictionary.ContainsKey(item))
		{
			if (isActive)
			{
				EnableItem(item);
			}
			else
			{
				DisableItem(item);
			}
			return false;
		}
		Add(item, isActive);
		return true;
	}

	public bool EnableItem(T item)
	{
		if (!m_Dictionary.TryGetValue(item, out var value))
		{
			return false;
		}
		if (value < m_EnabledObjectCount)
		{
			return true;
		}
		if (value > m_EnabledObjectCount)
		{
			Swap(m_EnabledObjectCount, value);
		}
		m_EnabledObjectCount++;
		return true;
	}

	public bool DisableItem(T item)
	{
		if (!m_Dictionary.TryGetValue(item, out var value))
		{
			return false;
		}
		if (value >= m_EnabledObjectCount)
		{
			return true;
		}
		if (value < m_EnabledObjectCount - 1)
		{
			Swap(value, m_EnabledObjectCount - 1);
		}
		m_EnabledObjectCount--;
		return true;
	}

	public bool Remove(T item)
	{
		int value = -1;
		if (!m_Dictionary.TryGetValue(item, out value))
		{
			return false;
		}
		RemoveAt(value);
		return true;
	}

	public IEnumerator<T> GetEnumerator()
	{
		throw new NotImplementedException();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public void Clear()
	{
		m_List.Clear();
		m_Dictionary.Clear();
		m_EnabledObjectCount = 0;
	}

	public bool Contains(T item)
	{
		return m_Dictionary.ContainsKey(item);
	}

	public void CopyTo(T[] array, int arrayIndex)
	{
		m_List.CopyTo(array, arrayIndex);
	}

	public int IndexOf(T item)
	{
		int value = -1;
		if (m_Dictionary.TryGetValue(item, out value))
		{
			return value;
		}
		return -1;
	}

	public void Insert(int index, T item)
	{
		throw new NotSupportedException("Random Insertion is semantically invalid, since this structure does not guarantee ordering.");
	}

	public void RemoveAt(int index)
	{
		T key = m_List[index];
		if (index == m_List.Count - 1)
		{
			if (m_EnabledObjectCount == m_List.Count)
			{
				m_EnabledObjectCount--;
			}
			m_List.RemoveAt(index);
		}
		else
		{
			int num = m_List.Count - 1;
			if (index < m_EnabledObjectCount - 1)
			{
				Swap(--m_EnabledObjectCount, index);
				index = m_EnabledObjectCount;
			}
			else if (index == m_EnabledObjectCount - 1)
			{
				m_EnabledObjectCount--;
			}
			Swap(num, index);
			m_List.RemoveAt(num);
		}
		m_Dictionary.Remove(key);
	}

	private void Swap(int index1, int index2)
	{
		if (index1 != index2)
		{
			T val = m_List[index1];
			T val2 = m_List[index2];
			m_List[index1] = val2;
			m_List[index2] = val;
			m_Dictionary[val2] = index1;
			m_Dictionary[val] = index2;
		}
	}

	public void RemoveAll(Predicate<T> match)
	{
		int num = 0;
		while (num < m_List.Count)
		{
			T val = m_List[num];
			if (match(val))
			{
				Remove(val);
			}
			else
			{
				num++;
			}
		}
	}

	public void Sort(Comparison<T> sortLayoutFunction)
	{
		m_List.Sort(sortLayoutFunction);
		for (int i = 0; i < m_List.Count; i++)
		{
			T key = m_List[i];
			m_Dictionary[key] = i;
		}
	}
}
