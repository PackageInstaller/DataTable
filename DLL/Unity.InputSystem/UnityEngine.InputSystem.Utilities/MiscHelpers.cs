using System.Collections.Generic;

namespace UnityEngine.InputSystem.Utilities;

internal static class MiscHelpers
{
	public static TValue GetValueOrDefault<TKey, TValue>(this Dictionary<TKey, TValue> dictionary, TKey key)
	{
		if (!dictionary.TryGetValue(key, out var value))
		{
			return default(TValue);
		}
		return value;
	}

	public static IEnumerable<TValue> EveryNth<TValue>(this IEnumerable<TValue> enumerable, int n, int start = 0)
	{
		int index = 0;
		foreach (TValue item in enumerable)
		{
			int num;
			if (index < start)
			{
				num = index + 1;
				index = num;
				continue;
			}
			if ((index - start) % n == 0)
			{
				yield return item;
			}
			num = index + 1;
			index = num;
		}
	}

	public static int IndexOf<TValue>(this IEnumerable<TValue> enumerable, TValue value)
	{
		int num = 0;
		foreach (TValue item in enumerable)
		{
			if (EqualityComparer<TValue>.Default.Equals(item, value))
			{
				return num;
			}
			num++;
		}
		return -1;
	}
}
