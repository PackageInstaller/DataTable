using System;
using System.Collections.Generic;

namespace Fundamental;

public class ArrayPool<T>
{
	private Stack<T[]> m_Stack = new Stack<T[]>();

	private int m_Count;

	protected int m_Mul = 1;

	public int countAll { get; private set; }

	public int countActive => countAll - countInactive;

	public int countInactive => m_Stack.Count;

	public ArrayPool(int count)
	{
		m_Count = count;
	}

	public T[] Get()
	{
		T[] result;
		if (m_Stack.Count == 0)
		{
			result = new T[m_Count];
			countAll++;
			if (countAll > 3 * m_Mul)
			{
				m_Mul++;
			}
		}
		else
		{
			result = m_Stack.Pop();
		}
		return result;
	}

	public void Release(T[] element)
	{
		Array.Clear(element, 0, element.Length);
		m_Stack.Push(element);
	}
}
