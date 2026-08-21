using System.Collections.Generic;

namespace UnityEngine.Rendering;

public static class DictionaryPool<TKey, TValue>
{
	private static readonly ObjectPool<Dictionary<TKey, TValue>> s_Pool = new ObjectPool<Dictionary<TKey, TValue>>(null, delegate(Dictionary<TKey, TValue> l)
	{
		l.Clear();
	});

	public static Dictionary<TKey, TValue> Get()
	{
		return s_Pool.Get();
	}

	public static ObjectPool<Dictionary<TKey, TValue>>.PooledObject Get(out Dictionary<TKey, TValue> value)
	{
		return s_Pool.Get(out value);
	}

	public static void Release(Dictionary<TKey, TValue> toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
