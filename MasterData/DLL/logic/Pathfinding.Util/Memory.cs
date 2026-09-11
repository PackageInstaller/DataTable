using System;

namespace Pathfinding.Util;

public static class Memory
{
	public static void MemSet<T>(T[] array, T value, int byteSize) where T : struct
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		int num = 32;
		int i = 0;
		int num2;
		for (num2 = Math.Min(num, array.Length); i < num2; i++)
		{
			array[i] = value;
		}
		num2 = array.Length;
		while (i < num2)
		{
			Buffer.BlockCopy(array, 0, array, i * byteSize, Math.Min(num, num2 - i) * byteSize);
			i += num;
			num *= 2;
		}
	}

	public static void MemSet<T>(T[] array, T value, int totalSize, int byteSize) where T : struct
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		int num = 32;
		int i = 0;
		int num2;
		for (num2 = Math.Min(num, totalSize); i < num2; i++)
		{
			array[i] = value;
		}
		num2 = totalSize;
		while (i < num2)
		{
			Buffer.BlockCopy(array, 0, array, i * byteSize, Math.Min(num, totalSize - i) * byteSize);
			i += num;
			num *= 2;
		}
	}

	public static T[] ShrinkArray<T>(T[] arr, int newLength)
	{
		newLength = Math.Min(newLength, arr.Length);
		T[] array = new T[newLength];
		Array.Copy(arr, array, newLength);
		return array;
	}
}
