using System.Collections.Generic;
using UnityEngine;

namespace Pathfinding.Util;

public static class StackPool<T>
{
	private static readonly List<Stack<T>> pool;

	static StackPool()
	{
		pool = new List<Stack<T>>();
	}

	public static Stack<T> Claim()
	{
		if (pool.Count > 0)
		{
			Stack<T> result = pool[pool.Count - 1];
			pool.RemoveAt(pool.Count - 1);
			return result;
		}
		return new Stack<T>();
	}

	public static void Warmup(int count)
	{
		Stack<T>[] array = new Stack<T>[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = Claim();
		}
		for (int j = 0; j < count; j++)
		{
			Release(array[j]);
		}
	}

	public static void Release(Stack<T> stack)
	{
		for (int i = 0; i < pool.Count; i++)
		{
			if (pool[i] == stack)
			{
				Debug.LogError((object)"The Stack is released even though it is inside the pool");
			}
		}
		stack.Clear();
		pool.Add(stack);
	}

	public static void Clear()
	{
		pool.Clear();
	}

	public static int GetSize()
	{
		return pool.Count;
	}
}
