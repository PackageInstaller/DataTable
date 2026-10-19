using System.Collections.Generic;

namespace Google.Protobuf.Collections;

public static class Lists
{
	public static bool Equals<T>(List<T> left, List<T> right)
	{
		if (left == right)
		{
			return true;
		}
		if (left == null || right == null)
		{
			return false;
		}
		if (left.Count != right.Count)
		{
			return false;
		}
		IEqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		for (int i = 0; i < left.Count; i++)
		{
			if (!equalityComparer.Equals(left[i], right[i]))
			{
				return false;
			}
		}
		return true;
	}

	public static int GetHashCode<T>(List<T> list)
	{
		if (list == null)
		{
			return 0;
		}
		int num = 31;
		foreach (T item in list)
		{
			num = num * 29 + item.GetHashCode();
		}
		return num;
	}
}
