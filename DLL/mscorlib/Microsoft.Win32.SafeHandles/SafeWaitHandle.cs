using System;
using System.Runtime.ConstrainedExecution;
using System.Threading;

namespace Microsoft.Win32.SafeHandles;

public sealed class SafeWaitHandle : SafeHandleZeroOrMinusOneIsInvalid
{
	private SafeWaitHandle()
		: base(ownsHandle: true)
	{
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public SafeWaitHandle(IntPtr existingHandle, bool ownsHandle)
		: base(ownsHandle)
	{
		SetHandle(existingHandle);
	}

	protected override bool ReleaseHandle()
	{
		NativeEventCalls.CloseEvent_internal(handle);
		return true;
	}
}
