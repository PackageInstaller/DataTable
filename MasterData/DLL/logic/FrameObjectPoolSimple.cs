using System.Collections.Generic;

public static class FrameObjectPoolSimple<T> where T : class, new()
{
	private static List<T> pool = new List<T>();

	public static T Claim()
	{
		lock (pool)
		{
			if (pool.Count > 0)
			{
				T result = pool[pool.Count - 1];
				pool.RemoveAt(pool.Count - 1);
				return result;
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
