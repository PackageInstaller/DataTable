using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System;

[StructLayout(LayoutKind.Auto)]
public struct ArgIterator
{
	private IntPtr sig;

	private IntPtr args;

	private int next_arg;

	private int num_args;

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Setup(IntPtr argsp, IntPtr start);

	public ArgIterator(RuntimeArgumentHandle arglist)
	{
		sig = IntPtr.Zero;
		args = IntPtr.Zero;
		next_arg = (num_args = 0);
		if (arglist.args == IntPtr.Zero)
		{
			throw new PlatformNotSupportedException();
		}
		Setup(arglist.args, IntPtr.Zero);
	}

	public override bool Equals(object o)
	{
		throw new NotSupportedException("ArgIterator does not support Equals.");
	}

	public override int GetHashCode()
	{
		return sig.GetHashCode();
	}

	[CLSCompliant(false)]
	public unsafe TypedReference GetNextArg()
	{
		if (num_args == next_arg)
		{
			throw new InvalidOperationException("Invalid iterator position.");
		}
		TypedReference result = default(TypedReference);
		IntGetNextArg(&result);
		return result;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe extern void IntGetNextArg(void* res);

	public int GetRemainingCount()
	{
		return num_args - next_arg;
	}
}
