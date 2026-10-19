using System;
using System.Collections.Generic;

namespace ACT.DialogueSystem;

public abstract class BaseObjectPool<T> : IObjectPool, IDisposable, IObjectPool<T> where T : class
{
	protected Stack<T> unusedObjects = new Stack<T>();

	public int UnusedCount => unusedObjects.Count;

	object IObjectPool.Spawn()
	{
		return Spawn();
	}

	public T Spawn()
	{
		T val = null;
		val = ((unusedObjects.Count <= 0) ? Create() : unusedObjects.Pop());
		OnSpawn(val);
		return val;
	}

	void IObjectPool.Recycle(object unit)
	{
		Recycle(unit as T);
	}

	public void Recycle(T unit)
	{
		unusedObjects.Push(unit);
		OnRecycle(unit);
	}

	public void Dispose()
	{
		while (unusedObjects.Count > 0)
		{
			OnDestroy(unusedObjects.Pop());
		}
	}

	protected abstract T Create();

	protected virtual void OnDestroy(T unit)
	{
	}

	protected virtual void OnSpawn(T unit)
	{
	}

	protected virtual void OnRecycle(T unit)
	{
	}
}
