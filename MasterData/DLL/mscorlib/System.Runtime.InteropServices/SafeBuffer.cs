using Microsoft.Win32.SafeHandles;

namespace System.Runtime.InteropServices;

public abstract class SafeBuffer : SafeHandleZeroOrMinusOneIsInvalid
{
	private static readonly UIntPtr Uninitialized = ((UIntPtr.Size == 4) ? ((UIntPtr)uint.MaxValue) : ((UIntPtr)ulong.MaxValue));

	private UIntPtr _numBytes;

	[CLSCompliant(false)]
	public unsafe void AcquirePointer(ref byte* pointer)
	{
		if (_numBytes == Uninitialized)
		{
			throw NotInitialized();
		}
		pointer = null;
		bool success = false;
		DangerousAddRef(ref success);
		pointer = (byte*)(void*)handle;
	}

	public void ReleasePointer()
	{
		if (_numBytes == Uninitialized)
		{
			throw NotInitialized();
		}
		DangerousRelease();
	}

	private static InvalidOperationException NotInitialized()
	{
		return new InvalidOperationException("You must call Initialize on this object instance before using it.");
	}
}
