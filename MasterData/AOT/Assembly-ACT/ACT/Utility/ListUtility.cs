using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace ACT.Utility;

public static class ListUtility
{
	public static void TryAdd<T>(this List<T> ts, T other)
	{
		if (!ts.Contains(other))
		{
			ts.Add(other);
		}
	}

	public static void TryRemove<T>(this List<T> ts, T other)
	{
		if (ts.Contains(other))
		{
			ts.Remove(other);
		}
	}

	public static void RemoveRange<T>(this List<T> ts, List<T> other)
	{
		foreach (T item in other)
		{
			ts.Remove(item);
		}
	}

	public static List<T> FindAllNoAlloc<T>(this List<T> list, Predicate<T> match, List<T> results)
	{
		if (match == null)
		{
			throw new ArgumentException("match");
		}
		results.Clear();
		for (int i = 0; i < list.Count; i++)
		{
			if (match(list[i]))
			{
				results.Add(list[i]);
			}
		}
		return results;
	}

	public static int GetLastIndex<T>(this List<T> list)
	{
		if (list == null)
		{
			return 0;
		}
		return list.Count - 1;
	}

	public static void MergeElement<T>(this List<T> list, Func<T, T, bool> canMerge, Func<T, T, T> mergeFunc)
	{
		for (int i = 0; i < list.Count; i++)
		{
			for (int num = list.Count - 1; num > i; num--)
			{
				if (canMerge(list[i], list[num]))
				{
					T value = mergeFunc(list[i], list[num]);
					list[i] = value;
					list.RemoveAt(num);
				}
			}
		}
	}

	public static int IndexOf<T>(this T[] array, T target)
	{
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].Equals(target))
			{
				return i;
			}
		}
		return -1;
	}

	public static bool Exists<T>(this ObservableCollection<T> observable, Predicate<T> match)
	{
		for (int i = 0; i < observable.Count; i++)
		{
			if (match(observable[i]))
			{
				return true;
			}
		}
		return false;
	}
}
