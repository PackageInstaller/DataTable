using System;
using System.Collections.Generic;

namespace Pathfinding.Util;

public static class ArrayPool<T>
{
	private static readonly Stack<T[]>[] pool = new Stack<T[]>[31];

	private static readonly Dictionary<int, Stack<T[]>> exactPool = new Dictionary<int, Stack<T[]>>();

	private static readonly HashSet<T[]> inPool = new HashSet<T[]>();

	public static T[] Claim(int minimumLength)
	{
		if (minimumLength <= 0)
		{
			return ClaimWithExactLength(0);
		}
		int i;
		for (i = 0; 1 << i < minimumLength && i < 30; i++)
		{
		}
		if (i == 30)
		{
			throw new ArgumentException("Too high minimum length");
		}
		lock (pool)
		{
			if (pool[i] == null)
			{
				pool[i] = new Stack<T[]>();
			}
			if (pool[i].Count > 0)
			{
				T[] array = pool[i].Pop();
				inPool.Remove(array);
				return array;
			}
		}
		return new T[1 << i];
	}

	public static T[] ClaimWithExactLength(int length)
	{
		if (length != 0 && (length & (length - 1)) == 0)
		{
			return Claim(length);
		}
		lock (pool)
		{
			if (!exactPool.TryGetValue(length, out var value))
			{
				value = new Stack<T[]>();
				exactPool[length] = value;
			}
			if (value.Count > 0)
			{
				T[] array = value.Pop();
				inPool.Remove(array);
				return array;
			}
		}
		return new T[length];
	}

	public static void Release(ref T[] array, bool allowNonPowerOfTwo = false)
	{
		if (array.GetType() != typeof(T[]))
		{
			throw new ArgumentException("Expected array type " + typeof(T[]).Name + " but found " + array.GetType().Name + "\nAre you using the correct generic class?\n");
		}
		bool flag = array.Length != 0 && (array.Length & (array.Length - 1)) == 0;
		if (!flag && !allowNonPowerOfTwo && array.Length != 0)
		{
			throw new ArgumentException("Length is not a power of 2");
		}
		lock (pool)
		{
			if (flag)
			{
				int i;
				for (i = 0; 1 << i < array.Length && i < 30; i++)
				{
				}
				if (pool[i] == null)
				{
					pool[i] = new Stack<T[]>();
				}
				pool[i].Push(array);
			}
			else
			{
				if (!exactPool.TryGetValue(array.Length, out var value))
				{
					value = new Stack<T[]>();
					exactPool[array.Length] = value;
				}
				value.Push(array);
			}
		}
		array = null;
	}
}
