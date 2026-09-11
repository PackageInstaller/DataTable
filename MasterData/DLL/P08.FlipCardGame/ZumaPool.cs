using System;
using System.Collections.Generic;

public class ZumaPool<T>
{
	private List<T> pool = new List<T>();

	private Func<T> func;

	public ZumaPool(Func<T> func, int count)
	{
		this.func = func;
		InstanceBall(count);
	}

	public T GetBallObj()
	{
		int count = pool.Count;
		if (count-- > 0)
		{
			T result = pool[count];
			pool.RemoveAt(count);
			return result;
		}
		InstanceBall(3);
		return GetBallObj();
	}

	public void AddObject(T t)
	{
		pool.Add(t);
	}

	private void InstanceBall(int count)
	{
		for (int i = 0; i < count; i++)
		{
			pool.Add(func());
		}
	}
}
