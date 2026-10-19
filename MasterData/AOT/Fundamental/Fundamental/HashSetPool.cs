using System.Collections.Generic;

namespace Fundamental;

public static class HashSetPool<T>
{
	private static readonly ObjectPool<HashSet<T>> s_HashSetPool = new ObjectPool<HashSet<T>>(null, Clear);

	private static void Clear(HashSet<T> l)
	{
		l.Clear();
	}

	public static HashSet<T> Get()
	{
		return s_HashSetPool.Get();
	}

	public static void Release(HashSet<T> toRelease)
	{
		s_HashSetPool.Release(toRelease);
	}
}
