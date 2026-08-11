using System;
using System.Collections.Generic;
using UnityEngine.Events;

namespace UnityEngine.Rendering;

public class ObjectPool<T> where T : new()
{
	public struct PooledObject : IDisposable
	{
		private readonly T m_ToReturn;

		private readonly ObjectPool<T> m_Pool;

		internal PooledObject(T value, ObjectPool<T> pool)
		{
			m_ToReturn = value;
			m_Pool = pool;
		}

		void IDisposable.Dispose()
		{
			m_Pool.Release(m_ToReturn);
		}
	}

	private readonly Stack<T> m_Stack = new Stack<T>();

	private readonly UnityAction<T> m_ActionOnGet;

	private readonly UnityAction<T> m_ActionOnRelease;

	private readonly bool m_CollectionCheck = true;

	public int countAll { get; private set; }

	public int countActive => countAll - countInactive;

	public int countInactive => m_Stack.Count;

	public ObjectPool(UnityAction<T> actionOnGet, UnityAction<T> actionOnRelease, bool collectionCheck = true)
	{
		m_ActionOnGet = actionOnGet;
		m_ActionOnRelease = actionOnRelease;
		m_CollectionCheck = collectionCheck;
	}

	public T Get()
	{
		T val;
		if (m_Stack.Count == 0)
		{
			val = new T();
			countAll++;
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

	public PooledObject Get(out T v)
	{
		return new PooledObject(v = Get(), this);
	}

	public void Release(T element)
	{
		if (m_ActionOnRelease != null)
		{
			m_ActionOnRelease(element);
		}
		m_Stack.Push(element);
	}
}
