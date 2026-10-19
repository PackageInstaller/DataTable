using System.Collections.Generic;

namespace Fundamental;

public static class ListPool<T>
{
	private static readonly ObjectPool<List<T>> s_ListPool = new ObjectPool<List<T>>(null, Clear);

	private static void Clear(List<T> l)
	{
		l.Clear();
	}

	public static List<T> Get()
	{
		return s_ListPool.Get();
	}

	public static void Release(List<T> toRelease)
	{
		if (toRelease != null)
		{
			s_ListPool.Release(toRelease);
		}
	}
}
