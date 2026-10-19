using System;
using System.Collections.Generic;

namespace UnityEngine.ResourceManagement.Util;

public class LRUCacheAllocationStrategy : IAllocationStrategy
{
	private int m_poolMaxSize;

	private int m_poolInitialCapacity;

	private int m_poolCacheMaxSize;

	private List<List<object>> m_poolCache = new List<List<object>>();

	private Dictionary<int, List<object>> m_cache = new Dictionary<int, List<object>>();

	public LRUCacheAllocationStrategy(int poolMaxSize, int poolCapacity, int poolCacheMaxSize, int initialPoolCacheCapacity)
	{
		m_poolMaxSize = poolMaxSize;
		m_poolInitialCapacity = poolCapacity;
		m_poolCacheMaxSize = poolCacheMaxSize;
		for (int i = 0; i < initialPoolCacheCapacity; i++)
		{
			m_poolCache.Add(new List<object>(m_poolInitialCapacity));
		}
	}

	private List<object> GetPool()
	{
		int count = m_poolCache.Count;
		if (count == 0)
		{
			return new List<object>(m_poolInitialCapacity);
		}
		List<object> result = m_poolCache[count - 1];
		m_poolCache.RemoveAt(count - 1);
		return result;
	}

	private void ReleasePool(List<object> pool)
	{
		if (m_poolCache.Count < m_poolCacheMaxSize)
		{
			m_poolCache.Add(pool);
		}
	}

	public object New(Type type, int typeHash)
	{
		if (m_cache.TryGetValue(typeHash, out var value))
		{
			int count = value.Count;
			object result = value[count - 1];
			value.RemoveAt(count - 1);
			if (count == 1)
			{
				m_cache.Remove(typeHash);
				ReleasePool(value);
			}
			return result;
		}
		return Activator.CreateInstance(type);
	}

	public void Release(int typeHash, object obj)
	{
		if (!m_cache.TryGetValue(typeHash, out var value))
		{
			m_cache.Add(typeHash, value = GetPool());
		}
		if (value.Count < m_poolMaxSize)
		{
			value.Add(obj);
		}
	}
}
