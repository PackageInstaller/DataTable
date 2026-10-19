using System;
using System.Runtime.InteropServices;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.Rendering;

public static class CoreUnsafeUtils
{
	public interface IKeyGetter<TValue, TKey>
	{
		TKey Get(ref TValue v);
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct DefaultKeyGetter<T> : IKeyGetter<T, T>
	{
		public T Get(ref T v)
		{
			return v;
		}
	}

	public unsafe static void QuickSort<T>(int count, void* data) where T : struct, IComparable<T>
	{
		QuickSort<T, T, DefaultKeyGetter<T>>(data, 0, count - 1);
	}

	public unsafe static void QuickSort<TValue, TKey, TGetter>(void* data, int left, int right) where TValue : struct where TKey : struct, IComparable<TKey> where TGetter : struct, IKeyGetter<TValue, TKey>
	{
		if (left < right)
		{
			int num = Partition<TValue, TKey, TGetter>(data, left, right);
			if (num >= 1)
			{
				QuickSort<TValue, TKey, TGetter>(data, left, num);
			}
			if (num + 1 < right)
			{
				QuickSort<TValue, TKey, TGetter>(data, num + 1, right);
			}
		}
	}

	private unsafe static int Partition<TValue, TKey, TGetter>(void* data, int left, int right) where TValue : struct where TKey : struct, IComparable<TKey> where TGetter : struct, IKeyGetter<TValue, TKey>
	{
		TGetter val = default;
		TValue v = UnsafeUtility.ReadArrayElement<TValue>(data, left);
		TKey other = val.Get(ref v);
		left--;
		right++;
		while (true)
		{
			int num = 0;
			TValue val2 = default;
			TKey val3 = default;
			do
			{
				left++;
				val2 = UnsafeUtility.ReadArrayElement<TValue>(data, left);
				num = val.Get(ref val2).CompareTo(other);
			}
			while (num < 0);
			TValue val4 = default;
			TKey val5 = default;
			do
			{
				right--;
				val4 = UnsafeUtility.ReadArrayElement<TValue>(data, right);
				num = val.Get(ref val4).CompareTo(other);
			}
			while (num > 0);
			if (left >= right)
			{
				break;
			}
			UnsafeUtility.WriteArrayElement(data, right, val2);
			UnsafeUtility.WriteArrayElement(data, left, val4);
		}
		return right;
	}
}
