using System.Collections.Generic;

namespace Pathfinding.Util;

public static class ArrayPoolExtensions
{
	public static T[] ToArrayFromPool<T>(this List<T> list)
	{
		T[] array = ArrayPool<T>.ClaimWithExactLength(list.Count);
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = list[i];
		}
		return array;
	}
}
