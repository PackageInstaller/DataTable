using System;
using System.IO;

namespace Microsoft.Win32.SafeHandles;

public sealed class SafeFileHandle : SafeHandleZeroOrMinusOneIsInvalid
{
	public SafeFileHandle(IntPtr preexistingHandle, bool ownsHandle)
		: base(ownsHandle)
	{
		SetHandle(preexistingHandle);
	}

	protected override bool ReleaseHandle()
	{
		MonoIO.Close(handle, out var error);
		return error == MonoIOError.ERROR_SUCCESS;
	}
}
