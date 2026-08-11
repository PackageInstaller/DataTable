using System.Runtime.InteropServices;
using System.Threading;
using Microsoft.Win32;
using Microsoft.Win32.SafeHandles;

namespace System.Diagnostics;

internal class ProcessWaitHandle : WaitHandle
{
	internal ProcessWaitHandle(SafeProcessHandle processHandle)
	{
		SafeWaitHandle targetHandle = null;
		if (!NativeMethods.DuplicateHandle(new HandleRef(this, NativeMethods.GetCurrentProcess()), processHandle, new HandleRef(this, NativeMethods.GetCurrentProcess()), out targetHandle, 0, bInheritHandle: false, 2))
		{
			throw new SystemException("Unknown error in DuplicateHandle");
		}
		base.SafeWaitHandle = targetHandle;
	}
}
