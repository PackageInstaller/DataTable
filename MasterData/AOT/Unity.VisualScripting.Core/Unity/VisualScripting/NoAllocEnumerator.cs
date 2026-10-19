using System;
using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public struct NoAllocEnumerator<T> : IEnumerator<T>, IEnumerator, IDisposable
{
	private readonly IList<T> list;

	private int index;

	private T current;

	private bool exceeded;

	public T Current => current;

	object IEnumerator.Current
	{
		get
		{
			if (exceeded)
			{
				throw new InvalidOperationException();
			}
			return Current;
		}
	}

	public NoAllocEnumerator(IList<T> list)
	{
		this = default;
		this.list = list;
	}

	public void Dispose()
	{
	}

	public bool MoveNext()
	{
		if (index < list.Count)
		{
			current = list[index];
			index++;
			return true;
		}
		index = list.Count + 1;
		current = default;
		exceeded = true;
		return false;
	}

	void IEnumerator.Reset()
	{
		throw new InvalidOperationException();
	}
}
