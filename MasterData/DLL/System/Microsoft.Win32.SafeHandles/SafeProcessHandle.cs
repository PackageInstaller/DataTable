using System;

namespace Microsoft.Win32.SafeHandles;

public sealed class SafeProcessHandle : SafeHandleZeroOrMinusOneIsInvalid
{
	internal static SafeProcessHandle InvalidHandle = new SafeProcessHandle(IntPtr.Zero);

	internal SafeProcessHandle(IntPtr handle)
		: base(ownsHandle: true)
	{
		SetHandle(handle);
	}

	public SafeProcessHandle(IntPtr existingHandle, bool ownsHandle)
		: base(ownsHandle)
	{
		SetHandle(existingHandle);
	}

	protected override bool ReleaseHandle()
	{
		return NativeMethods.CloseProcess(handle);
	}
}
