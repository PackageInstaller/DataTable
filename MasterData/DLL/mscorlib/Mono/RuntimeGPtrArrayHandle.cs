using System;
using System.Runtime.CompilerServices;

namespace Mono;

internal struct RuntimeGPtrArrayHandle
{
	private unsafe RuntimeStructs.GPtrArray* value = (RuntimeStructs.GPtrArray*)(void*)ptr;

	internal unsafe int Length => value->len;

	internal IntPtr this[int i] => Lookup(i);

	internal unsafe RuntimeGPtrArrayHandle(IntPtr ptr)
	{
	}

	internal unsafe IntPtr Lookup(int i)
	{
		if (i >= 0 && i < Length)
		{
			return value->data[i];
		}
		throw new IndexOutOfRangeException();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void GPtrArrayFree(RuntimeStructs.GPtrArray* value);

	internal unsafe static void DestroyAndFree(ref RuntimeGPtrArrayHandle h)
	{
		GPtrArrayFree(h.value);
		h.value = null;
	}
}
