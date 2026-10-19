using System.Collections.Generic;

namespace Fundamental;

public static class DictionaryPool<T1, T2>
{
	private static readonly ObjectPool<Dictionary<T1, T2>> s_DictionaryPool = new ObjectPool<Dictionary<T1, T2>>(null, Clear);

	private static void Clear(Dictionary<T1, T2> l)
	{
		l.Clear();
	}

	public static Dictionary<T1, T2> Get()
	{
		return s_DictionaryPool.Get();
	}

	public static void Release(Dictionary<T1, T2> toRelease)
	{
		s_DictionaryPool.Release(toRelease);
	}
}
