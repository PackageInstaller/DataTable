using System.Collections.Generic;

namespace Spine;

public static class HashSetExtensions
{
	public static bool AddAll<T>(this HashSet<T> set, T[] addSet)
	{
		bool flag = false;
		int i = 0;
		for (int num = addSet.Length; i < num; i++)
		{
			T item = addSet[i];
			flag |= set.Add(item);
		}
		return flag;
	}
}
