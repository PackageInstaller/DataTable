using System;

namespace UnityEngine.Rendering;

public static class DynamicArrayExtensions
{
	private static int Partition<T>(T[] data, int left, int right) where T : IComparable<T>, new()
	{
		T other = data[left];
		left--;
		right++;
		while (true)
		{
			int num = 0;
			T val = default(T);
			do
			{
				left++;
				val = data[left];
				num = val.CompareTo(other);
			}
			while (num < 0);
			T val2 = default(T);
			do
			{
				right--;
				val2 = data[right];
				num = val2.CompareTo(other);
			}
			while (num > 0);
			if (left >= right)
			{
				break;
			}
			data[right] = val;
			data[left] = val2;
		}
		return right;
	}

	private static void QuickSort<T>(T[] data, int left, int right) where T : IComparable<T>, new()
	{
		if (left < right)
		{
			int num = Partition(data, left, right);
			if (num >= 1)
			{
				QuickSort(data, left, num);
			}
			if (num + 1 < right)
			{
				QuickSort(data, num + 1, right);
			}
		}
	}

	public static void QuickSort<T>(this DynamicArray<T> array) where T : IComparable<T>, new()
	{
		QuickSort<T>(array, 0, array.size - 1);
	}
}
