using System;
using System.Collections.Generic;

namespace Telepathy;

public class Pool<T>
{
	private readonly Stack<T> objects = new Stack<T>();

	private readonly Func<T> objectGenerator;

	public Pool(Func<T> objectGenerator)
	{
		this.objectGenerator = objectGenerator;
	}

	public T Take()
	{
		if (objects.Count <= 0)
		{
			return objectGenerator();
		}
		return objects.Pop();
	}

	public void Return(T item)
	{
		objects.Push(item);
	}

	public void Clear()
	{
		objects.Clear();
	}

	public int Count()
	{
		return objects.Count;
	}
}
