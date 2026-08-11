using System.Collections.Generic;
using GameFramework;

public static class ConditionListPool<T> where T : class
{
	private static readonly Stack<ConditionList<T>> pool = new Stack<ConditionList<T>>();

	public static ConditionList<T> Get()
	{
		ConditionList<T> obj = ((pool.Count > 0) ? pool.Pop() : new ConditionList<T>());
		obj.InPool = false;
		return obj;
	}

	public static void Release(ConditionList<T> list)
	{
		if (!list.InPool)
		{
			list.Clear();
			list.InPool = true;
			pool.Push(list);
		}
	}

	public static void Clear()
	{
		pool.Clear();
	}
}
