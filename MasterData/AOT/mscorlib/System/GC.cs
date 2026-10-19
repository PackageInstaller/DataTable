using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;

namespace System;

public static class GC
{
	internal static readonly object EPHEMERON_TOMBSTONE = get_ephemeron_tombstone();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetCollectionCount(int generation);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void register_ephemeron_array(Ephemeron[] array);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern object get_ephemeron_tombstone();

	internal static void GetMemoryInfo(out uint highMemLoadThreshold, out ulong totalPhysicalMem, out uint lastRecordedMemLoad, out UIntPtr lastRecordedHeapSize, out UIntPtr lastRecordedFragmentation)
	{
		highMemLoadThreshold = 0u;
		totalPhysicalMem = ulong.MaxValue;
		lastRecordedMemLoad = 0u;
		lastRecordedHeapSize = UIntPtr.Zero;
		lastRecordedFragmentation = UIntPtr.Zero;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static int CollectionCount(int generation)
	{
		if (generation < 0)
		{
			throw new ArgumentOutOfRangeException("generation", Environment.GetResourceString("Value must be positive."));
		}
		return GetCollectionCount(generation);
	}

	[MethodImpl((MethodImplOptions)8)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static void KeepAlive(object obj)
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	private static extern void _SuppressFinalize(object o);

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static void SuppressFinalize(object obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		_SuppressFinalize(obj);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void _ReRegisterForFinalize(object o);

	public static void ReRegisterForFinalize(object obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		_ReRegisterForFinalize(obj);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern long GetTotalMemory(bool forceFullCollection);
}
