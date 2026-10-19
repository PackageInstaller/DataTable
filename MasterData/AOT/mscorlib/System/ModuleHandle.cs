using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;

namespace System;

[ComVisible(true)]
public struct ModuleHandle
{
	private IntPtr value;

	public static readonly ModuleHandle EmptyHandle = new ModuleHandle(IntPtr.Zero);

	internal IntPtr Value => value;

	internal ModuleHandle(IntPtr v)
	{
		value = v;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public override bool Equals(object obj)
	{
		if (obj == null || GetType() != obj.GetType())
		{
			return false;
		}
		return value == ((ModuleHandle)obj).Value;
	}

	public override int GetHashCode()
	{
		return value.GetHashCode();
	}

	public static bool operator ==(ModuleHandle left, ModuleHandle right)
	{
		return object.Equals(left, right);
	}
}
