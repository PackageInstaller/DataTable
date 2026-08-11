using System;
using System.Runtime.CompilerServices;

namespace Cysharp.Threading.Tasks.Internal;

internal class MinimumQueue<T>
{
	private const int MinimumGrow = 4;

	private const int GrowFactor = 200;

	private T[] array;

	private int head;

	private int tail;

	private int size;

	public int Count
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return size;
		}
	}

	public MinimumQueue(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity");
		}
		array = new T[capacity];
		head = (tail = (size = 0));
	}

	public T Peek()
	{
		if (size == 0)
		{
			ThrowForEmptyQueue();
		}
		return array[head];
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Enqueue(T item)
	{
		if (size == array.Length)
		{
			Grow();
		}
		array[tail] = item;
		MoveNext(ref tail);
		size++;
	}

	[MethodImpl((MethodImplOptions)256)]
	public T Dequeue()
	{
		if (size == 0)
		{
			ThrowForEmptyQueue();
		}
		int num = head;
		T[] obj = array;
		T result = obj[num];
		obj[num] = default(T);
		MoveNext(ref head);
		size--;
		return result;
	}

	private void Grow()
	{
		int num = (int)((long)array.Length * 200L / 100);
		if (num < array.Length + 4)
		{
			num = array.Length + 4;
		}
		SetCapacity(num);
	}

	private void SetCapacity(int capacity)
	{
		T[] destinationArray = new T[capacity];
		if (size > 0)
		{
			if (head < tail)
			{
				Array.Copy(array, head, destinationArray, 0, size);
			}
			else
			{
				Array.Copy(array, head, destinationArray, 0, array.Length - head);
				Array.Copy(array, 0, destinationArray, array.Length - head, tail);
			}
		}
		array = destinationArray;
		head = 0;
		tail = ((size != capacity) ? size : 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	private void MoveNext(ref int index)
	{
		int num = index + 1;
		if (num == array.Length)
		{
			num = 0;
		}
		index = num;
	}

	private void ThrowForEmptyQueue()
	{
		throw new InvalidOperationException("EmptyQueue");
	}
}
