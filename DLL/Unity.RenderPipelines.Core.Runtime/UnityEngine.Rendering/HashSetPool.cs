using System.Collections.Generic;

namespace UnityEngine.Rendering;

public static class HashSetPool<T>
{
	private static readonly ObjectPool<HashSet<T>> s_Pool = new ObjectPool<HashSet<T>>(null, delegate(HashSet<T> l)
	{
		l.Clear();
	});

	public static HashSet<T> Get()
	{
		return s_Pool.Get();
	}

	public static ObjectPool<HashSet<T>>.PooledObject Get(out HashSet<T> value)
	{
		return s_Pool.Get(out value);
	}

	public static void Release(HashSet<T> toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
