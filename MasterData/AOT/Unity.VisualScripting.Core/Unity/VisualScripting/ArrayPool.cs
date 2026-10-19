using System;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public static class ArrayPool<T>
{
	private static readonly object @lock = new object();

	private static readonly Dictionary<int, Stack<T[]>> free = new Dictionary<int, Stack<T[]>>();

	private static readonly HashSet<T[]> busy = new HashSet<T[]>();

	public static T[] New(int length)
	{
		lock (@lock)
		{
			if (!free.ContainsKey(length))
			{
				free.Add(length, new Stack<T[]>());
			}
			if (free[length].Count == 0)
			{
				free[length].Push(new T[length]);
			}
			T[] array = free[length].Pop();
			busy.Add(array);
			return array;
		}
	}

	public static void Free(T[] array)
	{
		lock (@lock)
		{
			if (!busy.Contains(array))
			{
				throw new ArgumentException("The array to free is not in use by the pool.", "array");
			}
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = default;
			}
			busy.Remove(array);
			free[array.Length].Push(array);
		}
	}
}
