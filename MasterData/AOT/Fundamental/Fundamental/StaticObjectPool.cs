using System.Collections.Generic;

namespace Fundamental;

public static class StaticObjectPool
{
	private static Dictionary<int, ObjectPool<object>> m_ObjectPool;

	static StaticObjectPool()
	{
		m_ObjectPool = new Dictionary<int, ObjectPool<object>>();
	}

	public static T Get<T>() where T : class, new()
	{
		int hashCode = typeof(T).GetHashCode();
		if (m_ObjectPool.TryGetValue(hashCode, out var value) && value.countInactive > 0)
		{
			return value.Get() as T;
		}
		return new T();
	}

	public static void Release<T>(T e) where T : class
	{
		if (e != null)
		{
			int hashCode = e.GetType().GetHashCode();
			if (m_ObjectPool.TryGetValue(hashCode, out var value))
			{
				value.Release(e);
			}
			else
			{
				AddNewElement(hashCode, e);
			}
		}
	}

	private static void AddNewElement(int hash, object e)
	{
		ObjectPool<object> objectPool = new ObjectPool<object>();
		objectPool.Release(e);
		m_ObjectPool.Add(hash, objectPool);
	}
}
