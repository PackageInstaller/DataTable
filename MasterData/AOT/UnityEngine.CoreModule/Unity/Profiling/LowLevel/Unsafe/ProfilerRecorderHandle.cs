using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.Profiling.LowLevel.Unsafe;

[StructLayout(LayoutKind.Explicit, Size = 8)]
[UsedByNativeCode]
public readonly struct ProfilerRecorderHandle
{
	[FieldOffset(0)]
	internal readonly ulong handle;

	public bool Valid => handle != 0L && handle != ulong.MaxValue;

	internal ProfilerRecorderHandle(ulong handle)
	{
		this.handle = handle;
	}

	public static ProfilerRecorderDescription GetDescription(ProfilerRecorderHandle handle)
	{
		if (!handle.Valid)
		{
			throw new ArgumentException("ProfilerRecorderHandle is not initialized or is not available", "handle");
		}
		return GetDescriptionInternal(handle);
	}

	[NativeMethod(IsThreadSafe = true)]
	internal unsafe static ProfilerRecorderHandle GetByName__Unmanaged(ProfilerCategory category, byte* name, int nameLen)
	{
		GetByName__Unmanaged_Injected(ref category, name, nameLen, out var ret);
		return ret;
	}

	[NativeMethod(IsThreadSafe = true)]
	private static ProfilerRecorderDescription GetDescriptionInternal(ProfilerRecorderHandle handle)
	{
		GetDescriptionInternal_Injected(ref handle, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void GetByName__Unmanaged_Injected(ref ProfilerCategory category, byte* name, int nameLen, out ProfilerRecorderHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetDescriptionInternal_Injected(ref ProfilerRecorderHandle handle, out ProfilerRecorderDescription ret);
}
