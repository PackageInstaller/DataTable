using System;

namespace Microsoft.Win32.SafeHandles;

public sealed class SafeRegistryHandle : SafeHandleZeroOrMinusOneIsInvalid
{
	protected override bool ReleaseHandle()
	{
		return Interop.Advapi32.RegCloseKey(handle) == 0;
	}

	internal SafeRegistryHandle()
		: base(ownsHandle: true)
	{
	}

	public SafeRegistryHandle(IntPtr preexistingHandle, bool ownsHandle)
		: base(ownsHandle)
	{
		SetHandle(preexistingHandle);
	}
}
