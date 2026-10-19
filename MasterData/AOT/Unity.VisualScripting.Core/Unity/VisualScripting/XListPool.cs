using System.Collections.Generic;

namespace Unity.VisualScripting;

public static class XListPool
{
	public static List<T> ToListPooled<T>(this IEnumerable<T> source)
	{
		List<T> list = ListPool<T>.New();
		foreach (T item in source)
		{
			list.Add(item);
		}
		return list;
	}

	public static void Free<T>(this List<T> list)
	{
		ListPool<T>.Free(list);
	}
}
