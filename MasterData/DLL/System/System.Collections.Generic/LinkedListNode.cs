namespace System.Collections.Generic;

public sealed class LinkedListNode<T>
{
	internal LinkedList<T> list;

	internal LinkedListNode<T> next;

	internal LinkedListNode<T> prev;

	internal T item;

	public LinkedList<T> List => list;

	public LinkedListNode<T> Next
	{
		get
		{
			if (next != null && next != list.head)
			{
				return next;
			}
			return null;
		}
	}

	public LinkedListNode<T> Previous
	{
		get
		{
			if (prev != null && this != list.head)
			{
				return prev;
			}
			return null;
		}
	}

	public T Value
	{
		get
		{
			return item;
		}
		set
		{
			item = value;
		}
	}

	public LinkedListNode(T value)
	{
		item = value;
	}

	internal LinkedListNode(LinkedList<T> list, T value)
	{
		this.list = list;
		item = value;
	}

	internal void Invalidate()
	{
		list = null;
		next = null;
		prev = null;
	}
}
