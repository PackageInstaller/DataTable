using System.Collections.Generic;

namespace UnityEngine.Rendering;

public static class ListPool<T>
{
	private static readonly ObjectPool<List<T>> s_Pool = new ObjectPool<List<T>>(null, delegate(List<T> l)
	{
		l.Clear();
	});

	public static List<T> Get()
	{
		return s_Pool.Get();
	}

	public static ObjectPool<List<T>>.PooledObject Get(out List<T> value)
	{
		return s_Pool.Get(out value);
	}

	public static void Release(List<T> toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
