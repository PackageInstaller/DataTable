using System;
using System.Collections.Generic;

namespace Fundamental;

public class ObjectPoolStack<T>
{
	private Stack<T> m_ObjectPool = new Stack<T>();

	public Func<T> onAdd;

	public Action<T> onRemove;

	public Action<T> onPop;

	public Action<T> onPush;

	public int Count => m_ObjectPool.Count;

	public ObjectPoolStack(Func<T> onAdd, Action<T> onRemove = null)
	{
		this.onAdd = onAdd;
		this.onRemove = onRemove;
	}

	public T Pop()
	{
		if (Count == 0)
		{
			T val = onAdd();
			onPop?.Invoke(val);
			return val;
		}
		onPop?.Invoke(m_ObjectPool.Peek());
		return m_ObjectPool.Pop();
	}

	public void Push(T t)
	{
		onPush?.Invoke(t);
		m_ObjectPool.Push(t);
	}

	public void Clear()
	{
		foreach (T item in m_ObjectPool)
		{
			onRemove(item);
		}
		m_ObjectPool.Clear();
	}
}
