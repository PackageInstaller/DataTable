using System;
using System.Collections.Generic;

namespace UnityEngine.Pool;

public class ObjectPool<T> : IDisposable, IPool, IObjectPool<T> where T : class
{
	internal readonly List<T> m_List;

	private readonly Func<T> m_CreateFunc;

	private readonly Action<T> m_ActionOnGet;

	private readonly Action<T> m_ActionOnRelease;

	private readonly Action<T> m_ActionOnDestroy;

	private readonly int m_MaxSize;

	internal bool m_CollectionCheck;

	public int CountAll { get; private set; }

	public int CountActive => CountAll - CountInactive;

	public int CountInactive => m_List.Count;

	public ObjectPool(Func<T> createFunc, Action<T> actionOnGet = null, Action<T> actionOnRelease = null, Action<T> actionOnDestroy = null, bool collectionCheck = true, int defaultCapacity = 10, int maxSize = 10000)
	{
		if (createFunc == null)
		{
			throw new ArgumentNullException("createFunc");
		}
		if (maxSize <= 0)
		{
			throw new ArgumentException("Max Size must be greater than 0", "maxSize");
		}
		m_List = new List<T>(defaultCapacity);
		m_CreateFunc = createFunc;
		m_MaxSize = maxSize;
		m_ActionOnGet = actionOnGet;
		m_ActionOnRelease = actionOnRelease;
		m_ActionOnDestroy = actionOnDestroy;
		m_CollectionCheck = collectionCheck;
		PoolManager.Register(this);
	}

	public T Get()
	{
		T val;
		if (m_List.Count == 0)
		{
			val = m_CreateFunc();
			CountAll++;
		}
		else
		{
			int index = m_List.Count - 1;
			val = m_List[index];
			m_List.RemoveAt(index);
		}
		m_ActionOnGet?.Invoke(val);
		return val;
	}

	public PooledObject<T> Get(out T v)
	{
		return new PooledObject<T>(v = Get(), this);
	}

	public void Release(T element)
	{
		m_ActionOnRelease?.Invoke(element);
		if (CountInactive < m_MaxSize)
		{
			m_List.Add(element);
			return;
		}
		CountAll--;
		m_ActionOnDestroy?.Invoke(element);
	}

	public void Clear()
	{
		if (m_ActionOnDestroy != null)
		{
			foreach (T item in m_List)
			{
				m_ActionOnDestroy(item);
			}
		}
		m_List.Clear();
		CountAll = 0;
	}

	public void Dispose()
	{
		Clear();
	}
}
