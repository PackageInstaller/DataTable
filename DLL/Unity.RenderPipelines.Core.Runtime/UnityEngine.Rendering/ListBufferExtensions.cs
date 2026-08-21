using System;

namespace UnityEngine.Rendering;

public static class ListBufferExtensions
{
	public unsafe static void QuickSort<T>(this ListBuffer<T> self) where T : unmanaged, IComparable<T>
	{
		CoreUnsafeUtils.QuickSort<int>(self.Count, self.BufferPtr);
	}
}
