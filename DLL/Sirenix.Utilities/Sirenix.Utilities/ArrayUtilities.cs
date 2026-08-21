using System;

namespace Sirenix.Utilities;

public static class ArrayUtilities
{
	public static T[] CreateNewArrayWithAddedElement<T>(T[] array, T value)
	{
		if (array == null)
		{
			return new T[1] { value };
		}
		T[] array2 = new T[array.Length + 1];
		for (int i = 0; i < array.Length; i++)
		{
			array2[i] = array[i];
		}
		array2[array2.Length - 1] = value;
		return array2;
	}

	public static T[] CreateNewArrayWithInsertedElement<T>(T[] array, int index, T value)
	{
		if (array == null)
		{
			if (index == 0)
			{
				return new T[1] { value };
			}
			throw new ArgumentNullException();
		}
		if (index < 0 || index > array.Length)
		{
			throw new ArgumentOutOfRangeException();
		}
		T[] array2 = new T[array.Length + 1];
		for (int i = 0; i < array2.Length; i++)
		{
			if (i < index)
			{
				array2[i] = array[i];
			}
			else if (i > index)
			{
				array2[i] = array[i - 1];
			}
			else
			{
				array2[i] = value;
			}
		}
		return array2;
	}

	public static T[] CreateNewArrayWithRemovedElement<T>(T[] array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException();
		}
		if (index < 0 || index >= array.Length)
		{
			throw new ArgumentOutOfRangeException();
		}
		T[] array2 = new T[array.Length - 1];
		for (int i = 0; i < array.Length; i++)
		{
			if (i < index)
			{
				array2[i] = array[i];
			}
			else if (i > index)
			{
				array2[i - 1] = array[i];
			}
		}
		return array2;
	}
}
