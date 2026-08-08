using System.IO;

namespace Microsoft.Win32.SafeHandles;

internal class SafeFindHandle : SafeHandleZeroOrMinusOneIsInvalid
{
	internal SafeFindHandle()
		: base(ownsHandle: true)
	{
	}

	protected override bool ReleaseHandle()
	{
		return MonoIO.FindCloseFile(handle);
	}
}
