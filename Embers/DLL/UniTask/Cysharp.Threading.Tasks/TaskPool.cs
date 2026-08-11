using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public static class TaskPool
{
	internal static int MaxPoolSize;

	private static Dictionary<Type, Func<int>> sizes;

	static TaskPool()
	{
		sizes = new Dictionary<Type, Func<int>>();
		try
		{
			string environmentVariable = Environment.GetEnvironmentVariable("UNITASK_MAX_POOLSIZE");
			if (environmentVariable != null && int.TryParse(environmentVariable, out var result))
			{
				MaxPoolSize = result;
				return;
			}
		}
		catch
		{
		}
		MaxPoolSize = int.MaxValue;
	}

	public static void SetMaxPoolSize(int maxPoolSize)
	{
		MaxPoolSize = maxPoolSize;
	}

	public static IEnumerable<(Type, int)> GetCacheSizeInfo()
	{
		lock (sizes)
		{
			foreach (KeyValuePair<Type, Func<int>> size in sizes)
			{
				yield return (size.Key, size.Value());
			}
		}
	}

	public static void RegisterSizeGetter(Type type, Func<int> getSize)
	{
		lock (sizes)
		{
			sizes[type] = getSize;
		}
	}
}
[StructLayout(LayoutKind.Auto)]
public struct TaskPool<T> where T : class, ITaskPoolNode<T>
{
	private int gate;

	private int size;

	private T root;

	public int Size => size;

	[MethodImpl((MethodImplOptions)256)]
	public bool TryPop(out T result)
	{
		if (Interlocked.CompareExchange(ref gate, 1, 0) == 0)
		{
			T val = root;
			if (val != null)
			{
				ref T nextNode = ref val.NextNode;
				root = nextNode;
				nextNode = null;
				size--;
				result = val;
				Volatile.Write(ref gate, 0);
				return true;
			}
			Volatile.Write(ref gate, 0);
		}
		result = null;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool TryPush(T item)
	{
		if (Interlocked.CompareExchange(ref gate, 1, 0) == 0)
		{
			if (size < TaskPool.MaxPoolSize)
			{
				item.NextNode = root;
				root = item;
				size++;
				Volatile.Write(ref gate, 0);
				return true;
			}
			Volatile.Write(ref gate, 0);
		}
		return false;
	}
}
