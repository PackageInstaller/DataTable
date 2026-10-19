using System.Collections.Generic;

namespace Fundamental;

public static class SortedDictionaryPool<T1, T2>
{
	private static readonly ObjectPool<SortedDictionary<T1, T2>> s_DictionaryPool = new ObjectPool<SortedDictionary<T1, T2>>(null, Clear);

	private static void Clear(SortedDictionary<T1, T2> l)
	{
		l.Clear();
	}

	public static SortedDictionary<T1, T2> Get()
	{
		return s_DictionaryPool.Get();
	}

	public static void Release(SortedDictionary<T1, T2> toRelease)
	{
		s_DictionaryPool.Release(toRelease);
	}
}
