using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using Unity;

namespace System.Threading;

public static class Interlocked
{
	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern int CompareExchange(ref int location1, int value, int comparand);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	internal static extern int CompareExchange(ref int location1, int value, int comparand, ref bool succeeded);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	private static extern void CompareExchange(ref object location1, ref object value, ref object comparand, ref object result);

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static object CompareExchange(ref object location1, object value, object comparand)
	{
		object result = null;
		CompareExchange(ref location1, ref value, ref comparand, ref result);
		return result;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float CompareExchange(ref float location1, float value, float comparand);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern int Decrement(ref int location);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern long Decrement(ref long location);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern int Increment(ref int location);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern long Increment(ref long location);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern int Exchange(ref int location1, int value);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	private static extern void Exchange(ref object location1, ref object value, ref object result);

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static object Exchange(ref object location1, object value)
	{
		object result = null;
		Exchange(ref location1, ref value, ref result);
		return result;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float Exchange(ref float location1, float value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern long CompareExchange(ref long location1, long value, long comparand);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern IntPtr CompareExchange(ref IntPtr location1, IntPtr value, IntPtr comparand);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double CompareExchange(ref double location1, double value, double comparand);

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	[Intrinsic]
	[ComVisible(false)]
	public unsafe static T CompareExchange<T>(ref T location1, T value, T comparand) where T : class
	{
		if (Unsafe.AsPointer(ref location1) == null)
		{
			throw new NullReferenceException();
		}
		T source = null;
		CompareExchange(ref Unsafe.As<T, object>(ref location1), ref Unsafe.As<T, object>(ref value), ref Unsafe.As<T, object>(ref comparand), ref Unsafe.As<T, object>(ref source));
		return source;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern long Exchange(ref long location1, long value);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern IntPtr Exchange(ref IntPtr location1, IntPtr value);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern double Exchange(ref double location1, double value);

	[ComVisible(false)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	[Intrinsic]
	public unsafe static T Exchange<T>(ref T location1, T value) where T : class
	{
		if (Unsafe.AsPointer(ref location1) == null)
		{
			throw new NullReferenceException();
		}
		T source = null;
		Exchange(ref Unsafe.As<T, object>(ref location1), ref Unsafe.As<T, object>(ref value), ref Unsafe.As<T, object>(ref source));
		return source;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern long Read(ref long location);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern int Add(ref int location1, int value);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern long Add(ref long location1, long value);

	public static void MemoryBarrier()
	{
		Thread.MemoryBarrier();
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void MemoryBarrierProcessWide();

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static void SpeculationBarrier()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
