using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Cysharp.Threading.Tasks.Internal;

internal static class ArrayUtil
{
	[MethodImpl((MethodImplOptions)256)]
	public static void EnsureCapacity<T>(ref T[] array, int index)
	{
		if (array.Length <= index)
		{
			EnsureCore(ref array, index);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void EnsureCore<T>(ref T[] array, int index)
	{
		int num = array.Length * 2;
		T[] array2 = new T[(index < num) ? num : (index * 2)];
		Array.Copy(array, 0, array2, 0, array.Length);
		array = array2;
	}

	public static (T[] array, int length) Materialize<T>(IEnumerable<T> source)
	{
		if (source is T[] array)
		{
			return (array: array, length: array.Length);
		}
		int num = 4;
		if (source is ICollection<T> { Count: var count } collection)
		{
			T[] array2 = new T[count];
			collection.CopyTo(array2, 0);
			return (array: array2, length: count);
		}
		if (source is IReadOnlyCollection<T> readOnlyCollection)
		{
			num = readOnlyCollection.Count;
		}
		if (num == 0)
		{
			return (array: Array.Empty<T>(), length: 0);
		}
		int num2 = 0;
		T[] array3 = new T[num];
		foreach (T item in source)
		{
			EnsureCapacity(ref array3, num2);
			array3[num2++] = item;
		}
		return (array: array3, length: num2);
	}
}
