using System.Runtime.InteropServices;

namespace System.Security.AccessControl;

public sealed class FileSecurity : FileSystemSecurity
{
	public FileSecurity(string fileName, AccessControlSections includeSections)
		: base(isContainer: false, fileName, includeSections)
	{
	}

	internal FileSecurity(SafeHandle handle, AccessControlSections includeSections)
		: base(isContainer: false, handle, includeSections)
	{
	}
}
