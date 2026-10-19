using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

namespace Fundamental;

public class ObjectPool
{
}
public class ObjectPool<T> : ObjectPool where T : new()
{
	private readonly Stack<T> m_Stack = new Stack<T>();

	private readonly UnityAction<T> m_ActionOnGet;

	private readonly UnityAction<T> m_ActionOnRelease;

	protected int m_Mul = 1;

	protected int m_Interval;

	public int countAll { get; private set; }

	public int countActive => countAll - countInactive;

	public int countInactive => m_Stack.Count;

	public ObjectPool()
	{
		m_ActionOnGet = (m_ActionOnRelease = null);
		m_Interval = 20;
	}

	public ObjectPool(UnityAction<T> actionOnGet, UnityAction<T> actionOnRelease, int interval = 10)
	{
		m_ActionOnGet = actionOnGet;
		m_ActionOnRelease = actionOnRelease;
		m_Interval = interval;
	}

	public T Get()
	{
		T val;
		if (m_Stack.Count == 0)
		{
			val = new T();
			countAll++;
			if (countActive > m_Interval * m_Mul)
			{
				m_Mul *= 2;
			}
		}
		else
		{
			val = m_Stack.Pop();
		}
		if (m_ActionOnGet != null)
		{
			m_ActionOnGet(val);
		}
		return val;
	}

	public void Release(T element)
	{
		if (m_Stack.Count > 0 && m_Stack.Contains(element))
		{
			Debug.LogWarning("Internal error. Trying to destroy object that is already released to pool.");
			return;
		}
		if (m_ActionOnRelease != null)
		{
			m_ActionOnRelease(element);
		}
		m_Stack.Push(element);
	}
}
