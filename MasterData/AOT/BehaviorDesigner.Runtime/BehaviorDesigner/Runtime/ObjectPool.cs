using System;
using System.Collections.Generic;

namespace BehaviorDesigner.Runtime;

public static class ObjectPool
{
	private static Dictionary<Type, object> poolDictionary = new Dictionary<Type, object>();

	private static object lockObject = new object();

	public static T Get<T>()
	{
		lock (lockObject)
		{
			if (poolDictionary.ContainsKey(typeof(T)))
			{
				Stack<T> stack = poolDictionary[typeof(T)] as Stack<T>;
				if (stack.Count > 0)
				{
					return stack.Pop();
				}
			}
			return (T)TaskUtility.CreateInstance(typeof(T));
		}
	}

	public static void Return<T>(T obj)
	{
		if (obj == null)
		{
			return;
		}
		lock (lockObject)
		{
			if (poolDictionary.TryGetValue(typeof(T), out var value))
			{
				(value as Stack<T>).Push(obj);
				return;
			}
			Stack<T> stack = new Stack<T>();
			stack.Push(obj);
			poolDictionary.Add(typeof(T), stack);
		}
	}

	public static void Clear()
	{
		lock (lockObject)
		{
			poolDictionary.Clear();
		}
	}
}
