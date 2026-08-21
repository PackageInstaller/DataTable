namespace Microsoft.Win32.SafeHandles;

internal sealed class SafeLibraryHandle : SafeHandleZeroOrMinusOneIsInvalid
{
	internal SafeLibraryHandle()
		: base(ownsHandle: true)
	{
	}

	protected override bool ReleaseHandle()
	{
		return Interop.Kernel32.FreeLibrary(handle);
	}
}
