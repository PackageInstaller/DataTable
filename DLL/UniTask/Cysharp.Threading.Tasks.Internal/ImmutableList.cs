using System;

namespace Cysharp.Threading.Tasks.Internal;

internal class ImmutableList<T>
{
	public static readonly ImmutableList<T> Empty = new ImmutableList<T>();

	private T[] data;

	public T[] Data => data;

	private ImmutableList()
	{
		data = new T[0];
	}

	public ImmutableList(T[] data)
	{
		this.data = data;
	}

	public ImmutableList<T> Add(T value)
	{
		T[] array = new T[data.Length + 1];
		Array.Copy(data, array, data.Length);
		array[data.Length] = value;
		return new ImmutableList<T>(array);
	}

	public ImmutableList<T> Remove(T value)
	{
		int num = IndexOf(value);
		if (num < 0)
		{
			return this;
		}
		int num2 = data.Length;
		if (num2 == 1)
		{
			return Empty;
		}
		T[] destinationArray = new T[num2 - 1];
		Array.Copy(data, 0, destinationArray, 0, num);
		Array.Copy(data, num + 1, destinationArray, num, num2 - num - 1);
		return new ImmutableList<T>(destinationArray);
	}

	public int IndexOf(T value)
	{
		for (int i = 0; i < data.Length; i++)
		{
			if (object.Equals(data[i], value))
			{
				return i;
			}
		}
		return -1;
	}
}
