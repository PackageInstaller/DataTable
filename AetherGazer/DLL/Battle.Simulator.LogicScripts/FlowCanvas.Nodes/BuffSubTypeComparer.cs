using System;
using System.Collections.Generic;

namespace FlowCanvas.Nodes;

public class BuffSubTypeComparer
{
	public static bool ContainsAny(string subType, string configSubType)
	{
		if (string.IsNullOrEmpty(subType) || string.IsNullOrEmpty(configSubType))
		{
			return false;
		}
		if (!configSubType.Contains('$'))
		{
			return subType.Equals(configSubType, StringComparison.Ordinal);
		}
		string[] array = configSubType.Split('$', StringSplitOptions.RemoveEmptyEntries);
		if (array.Length == 0)
		{
			return false;
		}
		string[] array2 = array;
		foreach (string value in array2)
		{
			if (subType.Equals(value, StringComparison.Ordinal))
			{
				return true;
			}
		}
		return false;
	}

	public static bool ContainsAny(List<string> subType, string configSubType)
	{
		if (subType == null || string.IsNullOrEmpty(configSubType))
		{
			return false;
		}
		if (subType.Count == 0)
		{
			return false;
		}
		if (!configSubType.Contains('$'))
		{
			foreach (string item in subType)
			{
				if (item != null && item.Equals(configSubType, StringComparison.Ordinal))
				{
					return true;
				}
			}
			return false;
		}
		string[] array = configSubType.Split('$', StringSplitOptions.RemoveEmptyEntries);
		if (array.Length == 0)
		{
			return false;
		}
		HashSet<string> hashSet = new HashSet<string>(array, StringComparer.Ordinal);
		for (int i = 0; i < subType.Count; i++)
		{
			if (subType[i] != null && hashSet.Contains(subType[i]))
			{
				return true;
			}
		}
		return false;
	}

	public static bool ContainsAny(HashSet<string> subType, string configSubType)
	{
		if (subType == null || subType.Count == 0 || string.IsNullOrEmpty(configSubType))
		{
			return false;
		}
		if (!configSubType.Contains('$'))
		{
			return subType.Contains(configSubType);
		}
		string[] array = configSubType.Split('$', StringSplitOptions.RemoveEmptyEntries);
		if (array.Length == 0)
		{
			return false;
		}
		HashSet<string> other = new HashSet<string>(array, StringComparer.Ordinal);
		return subType.Overlaps(other);
	}

	public static bool ContainsAll(List<string> subType, string configSubType)
	{
		if (subType == null || subType.Count == 0 || string.IsNullOrEmpty(configSubType))
		{
			return false;
		}
		if (!configSubType.Contains('$'))
		{
			for (int i = 0; i < subType.Count; i++)
			{
				if (subType[i] == null || !subType[i].Equals(configSubType, StringComparison.Ordinal))
				{
					return false;
				}
			}
			return true;
		}
		string[] array = configSubType.Split('$', StringSplitOptions.RemoveEmptyEntries);
		if (array.Length == 0)
		{
			return false;
		}
		if (subType.Count > array.Length)
		{
			return false;
		}
		HashSet<string> hashSet = new HashSet<string>(array, StringComparer.Ordinal);
		foreach (string item in subType)
		{
			if (item != null && !hashSet.Contains(item))
			{
				return false;
			}
		}
		return true;
	}

	public static bool ContainsAll(HashSet<string> subType, string configSubType)
	{
		if (subType == null || subType.Count == 0 || string.IsNullOrEmpty(configSubType))
		{
			return false;
		}
		if (!configSubType.Contains('$'))
		{
			foreach (string item in subType)
			{
				if (item == null || !item.Equals(configSubType, StringComparison.Ordinal))
				{
					return false;
				}
			}
			return true;
		}
		string[] array = configSubType.Split('$', StringSplitOptions.RemoveEmptyEntries);
		if (array.Length == 0)
		{
			return false;
		}
		if (subType.Count > array.Length)
		{
			return false;
		}
		HashSet<string> other = new HashSet<string>(array, StringComparer.Ordinal);
		return subType.IsSubsetOf(other);
	}
}
