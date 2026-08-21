using System.Collections.Generic;

public static class FrameListPool<T>
{
	private static readonly List<List<T>> pool = new List<List<T>>();

	private static readonly List<List<T>> largePool = new List<List<T>>();

	private static readonly HashSet<List<T>> inPool = new HashSet<List<T>>();

	private const int MaxCapacitySearchLength = 8;

	private const int LargeThreshold = 5000;

	private const int MaxLargePoolSize = 8;

	public static List<T> Claim()
	{
		lock (pool)
		{
			if (pool.Count > 0)
			{
				List<T> list = pool[pool.Count - 1];
				pool.RemoveAt(pool.Count - 1);
				inPool.Remove(list);
				return list;
			}
			return new List<T>();
		}
	}

	private static int FindCandidate(List<List<T>> pool, int capacity)
	{
		List<T> list = null;
		int result = -1;
		for (int i = 0; i < pool.Count && i < 8; i++)
		{
			List<T> list2 = pool[pool.Count - 1 - i];
			if ((list == null || list2.Capacity > list.Capacity) && list2.Capacity < capacity * 16)
			{
				list = list2;
				result = pool.Count - 1 - i;
				if (list.Capacity >= capacity)
				{
					return result;
				}
			}
		}
		return result;
	}

	public static List<T> Claim(int capacity)
	{
		lock (pool)
		{
			List<List<T>> list = pool;
			int num = FindCandidate(pool, capacity);
			if (capacity > 5000)
			{
				int num2 = FindCandidate(largePool, capacity);
				if (num2 != -1)
				{
					list = largePool;
					num = num2;
				}
			}
			if (num == -1)
			{
				return new List<T>(capacity);
			}
			List<T> list2 = list[num];
			inPool.Remove(list2);
			list[num] = list[list.Count - 1];
			list.RemoveAt(list.Count - 1);
			return list2;
		}
	}

	public static void Warmup(int count, int size)
	{
		lock (pool)
		{
			List<T>[] array = new List<T>[count];
			for (int i = 0; i < count; i++)
			{
				array[i] = Claim(size);
			}
			for (int j = 0; j < count; j++)
			{
				Release(array[j]);
			}
		}
	}

	public static void Release(List<T> list)
	{
		if (list.Count * 2 < list.Capacity)
		{
			list.RemoveRange(0, list.Count);
		}
		else
		{
			list.Clear();
		}
		lock (pool)
		{
			if (list.Capacity > 5000)
			{
				largePool.Add(list);
				if (largePool.Count > 8)
				{
					largePool.RemoveAt(0);
				}
			}
			else
			{
				pool.Add(list);
			}
		}
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
