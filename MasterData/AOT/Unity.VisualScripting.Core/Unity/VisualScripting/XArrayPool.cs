using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

public static class XArrayPool
{
	public static T[] ToArrayPooled<T>(this IEnumerable<T> source)
	{
		T[] array = ArrayPool<T>.New(source.Count());
		int num = 0;
		foreach (T item in source)
		{
			array[num++] = item;
		}
		return array;
	}

	public static void Free<T>(this T[] array)
	{
		ArrayPool<T>.Free(array);
	}
}
