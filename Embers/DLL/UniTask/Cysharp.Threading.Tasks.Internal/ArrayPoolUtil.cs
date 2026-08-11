using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Cysharp.Threading.Tasks.Internal;

internal static class ArrayPoolUtil
{
	public struct RentArray<T>(T[] array, int length, ArrayPool<T> pool) : IDisposable
	{
		public readonly T[] Array = array;

		public readonly int Length = length;

		private ArrayPool<T> pool = pool;

		public void Dispose()
		{
			DisposeManually(!RuntimeHelpersAbstraction.IsWellKnownNoReferenceContainsType<T>());
		}

		public void DisposeManually(bool clearArray)
		{
			if (pool != null)
			{
				if (clearArray)
				{
					System.Array.Clear(Array, 0, Length);
				}
				pool.Return(Array);
				pool = null;
			}
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static void EnsureCapacity<T>(ref T[] array, int index, ArrayPool<T> pool)
	{
		if (array.Length <= index)
		{
			EnsureCapacityCore(ref array, index, pool);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void EnsureCapacityCore<T>(ref T[] array, int index, ArrayPool<T> pool)
	{
		if (array.Length <= index)
		{
			int num = array.Length * 2;
			T[] array2 = pool.Rent((index < num) ? num : (index * 2));
			Array.Copy(array, 0, array2, 0, array.Length);
			pool.Return(array, !RuntimeHelpersAbstraction.IsWellKnownNoReferenceContainsType<T>());
			array = array2;
		}
	}

	public static RentArray<T> Materialize<T>(IEnumerable<T> source)
	{
		if (source is T[] array)
		{
			return new RentArray<T>(array, array.Length, null);
		}
		int num = 32;
		if (source is ICollection<T> collection)
		{
			if (collection.Count == 0)
			{
				return new RentArray<T>(Array.Empty<T>(), 0, null);
			}
			num = collection.Count;
			ArrayPool<T> shared = ArrayPool<T>.Shared;
			T[] array2 = shared.Rent(num);
			collection.CopyTo(array2, 0);
			return new RentArray<T>(array2, collection.Count, shared);
		}
		if (source is IReadOnlyCollection<T> readOnlyCollection)
		{
			num = readOnlyCollection.Count;
		}
		if (num == 0)
		{
			return new RentArray<T>(Array.Empty<T>(), 0, null);
		}
		ArrayPool<T> shared2 = ArrayPool<T>.Shared;
		int num2 = 0;
		T[] array3 = shared2.Rent(num);
		foreach (T item in source)
		{
			EnsureCapacity(ref array3, num2, shared2);
			array3[num2++] = item;
		}
		return new RentArray<T>(array3, num2, shared2);
	}
}
