using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Scripting/NoAllocHelpers.bindings.h")]
internal sealed class NoAllocHelpers
{
	public static void ResizeList<T>(List<T> list, int size)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		if (size < 0 || size > list.Capacity)
		{
			throw new ArgumentException("invalid size to resize.", "list");
		}
		if (size != list.Count)
		{
			Internal_ResizeList(list, size);
		}
	}

	public static void EnsureListElemCount<T>(List<T> list, int count)
	{
		list.Clear();
		if (list.Capacity < count)
		{
			list.Capacity = count;
		}
		ResizeList(list, count);
	}

	public static int SafeLength(Array values)
	{
		return values?.Length ?? 0;
	}

	public static int SafeLength<T>(List<T> values)
	{
		return values?.Count ?? 0;
	}

	public static T[] ExtractArrayFromListT<T>(List<T> list)
	{
		return (T[])ExtractArrayFromList(list);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("NoAllocHelpers_Bindings::Internal_ResizeList")]
	internal static extern void Internal_ResizeList(object list, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("NoAllocHelpers_Bindings::ExtractArrayFromList")]
	public static extern Array ExtractArrayFromList(object list);
}
