namespace UnityEngine.Rendering;

public static class UnsafeGenericPool<T> where T : new()
{
	private static readonly ObjectPool<T> s_Pool = new ObjectPool<T>(null, null, collectionCheck: false);

	public static T Get()
	{
		return s_Pool.Get();
	}

	public static ObjectPool<T>.PooledObject Get(out T value)
	{
		return s_Pool.Get(out value);
	}

	public static void Release(T toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
