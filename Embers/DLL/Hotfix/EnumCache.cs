using System;
using System.Collections.Generic;

public static class EnumCache<T> where T : struct, Enum
{
	private static readonly Dictionary<string, T> enumMap;

	public static IReadOnlyDictionary<string, T> EnumMap => enumMap;

	static EnumCache()
	{
		enumMap = new Dictionary<string, T>(StringComparer.OrdinalIgnoreCase);
		foreach (T value in Enum.GetValues(typeof(T)))
		{
			enumMap[value.ToString()] = value;
		}
	}

	public static bool TryGet(string key, out T result)
	{
		return enumMap.TryGetValue(key, out result);
	}

	public static T GetOrDefault(string key, T defaultValue = default(T))
	{
		if (!enumMap.TryGetValue(key, out var value))
		{
			return defaultValue;
		}
		return value;
	}
}
