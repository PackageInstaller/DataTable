using System.Threading;
using Microsoft.Win32.SafeHandles;

namespace System.Diagnostics;

internal class ProcessWaitHandle : WaitHandle
{
	internal ProcessWaitHandle(SafeProcessHandle processHandle)
	{
		throw new PlatformNotSupportedException();
	}
}
