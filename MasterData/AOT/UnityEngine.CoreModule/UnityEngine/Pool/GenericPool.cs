namespace UnityEngine.Pool;

public class GenericPool<T> where T : class, new()
{
	internal static readonly ObjectPool<T> s_Pool = new ObjectPool<T>(() => new T());

	public static T Get()
	{
		return s_Pool.Get();
	}

	public static void Release(T toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
