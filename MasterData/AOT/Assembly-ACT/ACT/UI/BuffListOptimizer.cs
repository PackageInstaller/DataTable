using System;
using System.Collections.Generic;

namespace ACT.UI;

public static class BuffListOptimizer
{
	private static readonly Stack<HashSet<string>> _hashSetPool = new Stack<HashSet<string>>();

	private static readonly Stack<List<string>> _stringListPool = new Stack<List<string>>();

	public static HashSet<string> GetHashSet()
	{
		if (_hashSetPool.Count <= 0)
		{
			return new HashSet<string>();
		}
		return _hashSetPool.Pop();
	}

	public static void ReleaseHashSet(HashSet<string> hashSet)
	{
		if (hashSet != null)
		{
			hashSet.Clear();
			_hashSetPool.Push(hashSet);
		}
	}

	public static List<string> GetStringList()
	{
		if (_stringListPool.Count <= 0)
		{
			return new List<string>();
		}
		return _stringListPool.Pop();
	}

	public static void ReleaseStringList(List<string> list)
	{
		if (list != null)
		{
			list.Clear();
			_stringListPool.Push(list);
		}
	}

	public static List<string> CalculateRemovedKeys<T>(Dictionary<string, T> currentMap, HashSet<string> newKeys)
	{
		List<string> stringList = GetStringList();
		foreach (KeyValuePair<string, T> item in currentMap)
		{
			if (!newKeys.Contains(item.Key))
			{
				stringList.Add(item.Key);
			}
		}
		return stringList;
	}

	public static void BatchRemove(List<string> removedKeys, Dictionary<string, BuffUIV3> buffMap, Action<BuffUIV3> releaseAction)
	{
		foreach (string removedKey in removedKeys)
		{
			if (buffMap.Remove(removedKey, out var value))
			{
				releaseAction?.Invoke(value);
			}
		}
	}
}
