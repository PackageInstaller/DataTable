using System.Collections.Generic;

namespace Pathfinding.Util;

public static class ObjectPoolSimple<T> where T : class, new()
{
	private static List<T> pool = new List<T>();

	private static readonly HashSet<T> inPool = new HashSet<T>();

	public static T Claim()
	{
		lock (pool)
		{
			if (pool.Count > 0)
			{
				T val = pool[pool.Count - 1];
				pool.RemoveAt(pool.Count - 1);
				inPool.Remove(val);
				return val;
			}
			return new T();
		}
	}

	public static void Release(ref T obj)
	{
		lock (pool)
		{
			pool.Add(obj);
		}
		obj = null;
	}

	public static void Clear()
	{
		lock (pool)
		{
			pool.Clear();
		}
	}

	public static int GetSize()
	{
		return pool.Count;
	}
}
