using System;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;

namespace Microsoft.Win32.SafeHandles;

public abstract class SafeHandleMinusOneIsInvalid : SafeHandle
{
	public override bool IsInvalid => handle == new IntPtr(-1);

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	protected SafeHandleMinusOneIsInvalid(bool ownsHandle)
		: base(new IntPtr(-1), ownsHandle)
	{
	}
}
