using System;
using Unity.Collections;

namespace UnityEngine.Rendering;

public static class ArrayExtensions
{
	public static void ResizeArray<T>(this ref NativeArray<T> array, int capacity) where T : struct
	{
		NativeArray<T> nativeArray = new NativeArray<T>(capacity, Allocator.Persistent, NativeArrayOptions.UninitializedMemory);
		if (array.IsCreated)
		{
			NativeArray<T>.Copy(array, nativeArray, array.Length);
			array.Dispose();
		}
		array = nativeArray;
	}

	public static void ResizeArray<T>(ref T[] array, int capacity)
	{
		if (array == null)
		{
			array = new T[capacity];
		}
		else
		{
			Array.Resize(ref array, capacity);
		}
	}
}
