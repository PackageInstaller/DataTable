using System.Runtime.InteropServices;

namespace System.Security.AccessControl;

public sealed class EventWaitHandleSecurity : NativeObjectSecurity
{
	internal EventWaitHandleSecurity(SafeHandle handle, AccessControlSections includeSections)
		: base(isContainer: false, ResourceType.KernelObject, handle, includeSections)
	{
	}
}
