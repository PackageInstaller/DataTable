using System;
using System.Collections.Generic;

namespace UnityEngine.InputSystem.Utilities;

public static class ReadOnlyArrayExtensions
{
	public static bool Contains<TValue>(this ReadOnlyArray<TValue> array, TValue value) where TValue : IComparable<TValue>
	{
		for (int i = 0; i < array.m_Length; i++)
		{
			if (array.m_Array[array.m_StartIndex + i].CompareTo(value) == 0)
			{
				return true;
			}
		}
		return false;
	}

	public static bool ContainsReference<TValue>(this ReadOnlyArray<TValue> array, TValue value) where TValue : class
	{
		return array.IndexOfReference(value) != -1;
	}

	public static int IndexOfReference<TValue>(this ReadOnlyArray<TValue> array, TValue value) where TValue : class
	{
		for (int i = 0; i < array.m_Length; i++)
		{
			if (array.m_Array[array.m_StartIndex + i] == value)
			{
				return i;
			}
		}
		return -1;
	}

	internal static bool HaveEqualReferences<TValue>(this ReadOnlyArray<TValue> array1, IReadOnlyList<TValue> array2, int count = int.MaxValue)
	{
		int num = Math.Min(array1.Count, count);
		int num2 = Math.Min(array2.Count, count);
		if (num != num2)
		{
			return false;
		}
		for (int i = 0; i < num; i++)
		{
			if ((object)array1[i] != (object)array2[i])
			{
				return false;
			}
		}
		return true;
	}
}
