using System.Collections.Generic;

namespace UnityEngine.Pool;

public class CollectionPool<TCollection, TItem> where TCollection : class, ICollection<TItem>, new()
{
	internal static readonly ObjectPool<TCollection> s_Pool = new ObjectPool<TCollection>(() => new TCollection(), null, delegate(TCollection l)
	{
		l.Clear();
	});

	public static TCollection Get()
	{
		return s_Pool.Get();
	}

	public static PooledObject<TCollection> Get(out TCollection value)
	{
		return s_Pool.Get(out value);
	}

	public static void Release(TCollection toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
