using System;

namespace UnityEngine.Rendering;

public sealed class ListChangedEventArgs<T> : EventArgs
{
	public readonly int index;

	public readonly T item;

	public ListChangedEventArgs(int index, T item)
	{
		this.index = index;
		this.item = item;
	}
}
