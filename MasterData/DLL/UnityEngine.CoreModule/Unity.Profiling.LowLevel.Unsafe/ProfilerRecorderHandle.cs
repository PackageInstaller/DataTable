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

	internal static ProfilerRecorderHandle Get(ProfilerMarker marker)
	{
		return new ProfilerRecorderHandle((ulong)marker.Handle.ToInt64());
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
	internal static ProfilerRecorderHandle GetByName(ProfilerCategory category, string name)
	{
		GetByName_Injected(ref category, name, out var ret);
		return ret;
	}

	[NativeMethod(IsThreadSafe = true)]
	internal unsafe static ProfilerRecorderHandle GetByName__Unmanaged(ProfilerCategory category, byte* name, int nameLen)
	{
		GetByName__Unmanaged_Injected(ref category, name, nameLen, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal unsafe static ProfilerRecorderHandle GetByName(ProfilerCategory category, char* name, int nameLen)
	{
		return GetByName_Unsafe(category, name, nameLen);
	}

	[NativeMethod(IsThreadSafe = true)]
	private unsafe static ProfilerRecorderHandle GetByName_Unsafe(ProfilerCategory category, char* name, int nameLen)
	{
		GetByName_Unsafe_Injected(ref category, name, nameLen, out var ret);
		return ret;
	}

	[NativeMethod(IsThreadSafe = true)]
	private static ProfilerRecorderDescription GetDescriptionInternal(ProfilerRecorderHandle handle)
	{
		GetDescriptionInternal_Injected(ref handle, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetByName_Injected(ref ProfilerCategory category, string name, out ProfilerRecorderHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void GetByName__Unmanaged_Injected(ref ProfilerCategory category, byte* name, int nameLen, out ProfilerRecorderHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void GetByName_Unsafe_Injected(ref ProfilerCategory category, char* name, int nameLen, out ProfilerRecorderHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetDescriptionInternal_Injected(ref ProfilerRecorderHandle handle, out ProfilerRecorderDescription ret);
}
