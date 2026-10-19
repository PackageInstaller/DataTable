using System;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;

namespace Microsoft.Win32.SafeHandles;

public abstract class SafeHandleZeroOrMinusOneIsInvalid : SafeHandle
{
	public override bool IsInvalid
	{
		get
		{
			if (!handle.IsNull())
			{
				return handle == new IntPtr(-1);
			}
			return true;
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	protected SafeHandleZeroOrMinusOneIsInvalid(bool ownsHandle)
		: base(IntPtr.Zero, ownsHandle)
	{
	}
}
