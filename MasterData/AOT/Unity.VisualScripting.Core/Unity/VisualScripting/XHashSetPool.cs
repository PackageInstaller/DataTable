using System.Collections.Generic;

namespace Unity.VisualScripting;

public static class XHashSetPool
{
	public static HashSet<T> ToHashSetPooled<T>(this IEnumerable<T> source)
	{
		HashSet<T> hashSet = HashSetPool<T>.New();
		foreach (T item in source)
		{
			hashSet.Add(item);
		}
		return hashSet;
	}

	public static void Free<T>(this HashSet<T> hashSet)
	{
		HashSetPool<T>.Free(hashSet);
	}
}
