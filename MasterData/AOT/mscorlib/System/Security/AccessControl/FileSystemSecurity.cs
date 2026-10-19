using System.Runtime.InteropServices;

namespace System.Security.AccessControl;

public abstract class FileSystemSecurity : NativeObjectSecurity
{
	internal FileSystemSecurity(bool isContainer, string name, AccessControlSections includeSections)
		: base(isContainer, ResourceType.FileObject, name, includeSections)
	{
	}

	internal FileSystemSecurity(bool isContainer, SafeHandle handle, AccessControlSections includeSections)
		: base(isContainer, ResourceType.FileObject, handle, includeSections)
	{
	}
}
