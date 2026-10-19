using System;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public static class ListPool<T>
{
	private static readonly object @lock = new object();

	private static readonly Stack<List<T>> free = new Stack<List<T>>();

	private static readonly HashSet<List<T>> busy = new HashSet<List<T>>();

	public static List<T> New()
	{
		lock (@lock)
		{
			if (free.Count == 0)
			{
				free.Push(new List<T>());
			}
			List<T> list = free.Pop();
			busy.Add(list);
			return list;
		}
	}

	public static void Free(List<T> list)
	{
		lock (@lock)
		{
			if (!busy.Contains(list))
			{
				throw new ArgumentException("The list to free is not in use by the pool.", "list");
			}
			list.Clear();
			busy.Remove(list);
			free.Push(list);
		}
	}
}
