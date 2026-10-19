using System;
using System.Collections;
using System.Collections.Generic;

internal class ListWithEvents<T> : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable
{
	private List<T> m_List = new List<T>();

	public T this[int index]
	{
		get
		{
			return m_List[index];
		}
		set
		{
			T element = m_List[index];
			m_List[index] = value;
			InvokeRemoved(element);
			InvokeAdded(value);
		}
	}

	public int Count => m_List.Count;

	public bool IsReadOnly => ((ICollection<T>)m_List).IsReadOnly;

	public event Action<T> OnElementAdded;

	public event Action<T> OnElementRemoved;

	private void InvokeAdded(T element)
	{
		OnElementAdded?.Invoke(element);
	}

	private void InvokeRemoved(T element)
	{
		OnElementRemoved?.Invoke(element);
	}

	public void Add(T item)
	{
		m_List.Add(item);
		InvokeAdded(item);
	}

	public void Clear()
	{
		foreach (T item in m_List)
		{
			InvokeRemoved(item);
		}
		m_List.Clear();
	}

	public bool Contains(T item)
	{
		return m_List.Contains(item);
	}

	public void CopyTo(T[] array, int arrayIndex)
	{
		m_List.CopyTo(array, arrayIndex);
	}

	public IEnumerator<T> GetEnumerator()
	{
		return m_List.GetEnumerator();
	}

	public int IndexOf(T item)
	{
		return m_List.IndexOf(item);
	}

	public void Insert(int index, T item)
	{
		m_List.Insert(index, item);
		InvokeAdded(item);
	}

	public bool Remove(T item)
	{
		bool flag = m_List.Remove(item);
		if (flag)
		{
			InvokeRemoved(item);
		}
		return flag;
	}

	public void RemoveAt(int index)
	{
		T element = m_List[index];
		m_List.RemoveAt(index);
		InvokeRemoved(element);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return ((IEnumerable)m_List).GetEnumerator();
	}
}
