using System;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public static class ManualPool<T> where T : class
{
	private static readonly object @lock = new object();

	private static readonly Stack<T> free = new Stack<T>();

	private static readonly HashSet<T> busy = new HashSet<T>();

	public static T New(Func<T> constructor)
	{
		lock (@lock)
		{
			if (free.Count == 0)
			{
				free.Push(constructor());
			}
			T val = free.Pop();
			busy.Add(val);
			return val;
		}
	}

	public static void Free(T item)
	{
		lock (@lock)
		{
			if (!busy.Contains(item))
			{
				throw new ArgumentException("The item to free is not in use by the pool.", "item");
			}
			busy.Remove(item);
			free.Push(item);
		}
	}
}
