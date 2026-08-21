using System;

namespace Mono;

internal struct SafeGPtrArrayHandle : IDisposable
{
	private RuntimeGPtrArrayHandle handle;

	internal int Length => handle.Length;

	internal IntPtr this[int i] => handle[i];

	internal SafeGPtrArrayHandle(IntPtr ptr)
	{
		handle = new RuntimeGPtrArrayHandle(ptr);
	}

	public void Dispose()
	{
		RuntimeGPtrArrayHandle.DestroyAndFree(ref handle);
	}
}
