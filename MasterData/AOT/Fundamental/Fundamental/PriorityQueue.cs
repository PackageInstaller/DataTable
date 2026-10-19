using System;
using System.Collections.Generic;

namespace Fundamental;

public class PriorityQueue<T>
{
	private readonly List<T> m_Actions;

	private readonly IComparer<T> m_cmp;

	public int Count => m_Actions.Count;

	public int Capacity => m_Actions.Capacity;

	public bool IsEmpty => m_Actions.Count <= 0;

	public PriorityQueue()
		: this(8, (IComparer<T>)Comparer<T>.Default)
	{
	}

	public PriorityQueue(int size)
		: this(size, (IComparer<T>)Comparer<T>.Default)
	{
	}

	public PriorityQueue(int size, IComparer<T> cmp)
	{
		m_Actions = new List<T>(size);
		m_cmp = cmp;
	}

	public void Invoke(T arg)
	{
		for (int num = m_Actions.Count - 1; num >= 0; num--)
		{
			if (m_Actions[num] == null)
			{
				m_Actions.RemoveAt(num);
			}
		}
		int count = m_Actions.Count;
		for (int i = 0; i < count; i++)
		{
			if (m_Actions[i] != null)
			{
				m_Actions[i] = arg;
			}
		}
	}

	public void Enqueue(T item)
	{
		m_Actions.Add(item);
		PushHeap(m_Actions, m_cmp);
	}

	public void Dequeue()
	{
		PopHeap(m_Actions, m_cmp);
		m_Actions.RemoveAt(m_Actions.Count - 1);
	}

	public T Peek()
	{
		if (m_Actions.Count <= 0)
		{
			throw new IndexOutOfRangeException();
		}
		return m_Actions[0];
	}

	public void Clear()
	{
		m_Actions.Clear();
	}

	public void TrimExcess()
	{
		m_Actions.TrimExcess();
	}

	public static void PushHeap(IList<T> list, IComparer<T> pred)
	{
		int count = list.Count;
		if (count < 0 || count >= int.MaxValue)
		{
			throw new IndexOutOfRangeException();
		}
		if (count >= 2)
		{
			int num = count - 1;
			T value = list[num];
			PushHeapByIndex(list, num, 0, value, pred);
		}
	}

	private static void PushHeapByIndex(IList<T> list, int hole, int top, T value, IComparer<T> pred)
	{
		int num = hole - 1 >> 1;
		while (top < hole && pred.Compare(value, list[num]) < 0)
		{
			list[hole] = list[num];
			hole = num;
			num = hole - 1 >> 1;
		}
		list[hole] = value;
	}

	public static void PopHeap(IList<T> list, IComparer<T> pred)
	{
		int count = list.Count;
		if (count < 0 || count >= int.MaxValue)
		{
			throw new IndexOutOfRangeException();
		}
		if (count < 2)
		{
			return;
		}
		int num = count - 1;
		T value = list[num];
		list[num] = list[0];
		int num2 = 0;
		int num3 = num;
		int top = num2;
		int num4 = num2;
		int num5 = num3 - 1 >> 1;
		while (num4 < num5)
		{
			num4 = 2 * num4 + 2;
			if (pred.Compare(list[num4 - 1], list[num4]) < 0)
			{
				num4--;
			}
			list[num2] = list[num4];
			num2 = num4;
		}
		if (num4 == num5 && num3 % 2 == 0)
		{
			list[num2] = list[num3 - 1];
			num2 = num3 - 1;
		}
		PushHeapByIndex(list, num2, top, value, pred);
	}
}
