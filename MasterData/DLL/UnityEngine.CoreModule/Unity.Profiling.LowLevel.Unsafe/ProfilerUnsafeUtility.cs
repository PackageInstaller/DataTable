using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.Profiling.LowLevel.Unsafe;

[UsedByNativeCode]
[NativeHeader("Runtime/Profiler/ScriptBindings/ProfilerUnsafeUtility.bindings.h")]
[IgnoredByDeepProfiler]
public static class ProfilerUnsafeUtility
{
	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	internal static extern ushort CreateCategory(string name, ProfilerCategoryColor colorIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	internal unsafe static extern ushort CreateCategory__Unmanaged(byte* name, int nameLen, ProfilerCategoryColor colorIndex);

	[ThreadSafe]
	public static ProfilerCategoryDescription GetCategoryDescription(ushort categoryId)
	{
		GetCategoryDescription_Injected(categoryId, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr CreateMarker(string name, ushort categoryId, MarkerFlags flags, int metadataCount);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	internal unsafe static extern IntPtr CreateMarker__Unmanaged(byte* name, int nameLen, ushort categoryId, MarkerFlags flags, int metadataCount);

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static IntPtr CreateMarker(char* name, int nameLen, ushort categoryId, MarkerFlags flags, int metadataCount)
	{
		return CreateMarker_Unsafe(name, nameLen, categoryId, flags, metadataCount);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	private unsafe static extern IntPtr CreateMarker_Unsafe(char* name, int nameLen, ushort categoryId, MarkerFlags flags, int metadataCount);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	internal unsafe static extern void SetMarkerMetadata__Unmanaged(IntPtr markerPtr, int index, byte* name, int nameLen, byte type, byte unit);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void BeginSample(IntPtr markerPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void EndSample(IntPtr markerPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	internal unsafe static extern void* CreateCounterValue__Unmanaged(out IntPtr counterPtr, byte* name, int nameLen, ushort categoryId, MarkerFlags flags, byte dataType, byte dataUnit, int dataSize, ProfilerCounterOptions counterOptions);

	internal unsafe static string Utf8ToString(byte* chars, int charsLen)
	{
		if (chars == null)
		{
			return null;
		}
		byte[] array = new byte[charsLen];
		Marshal.Copy((IntPtr)chars, array, 0, charsLen);
		return Encoding.UTF8.GetString(array, 0, charsLen);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	internal static extern void Internal_BeginWithObject(IntPtr markerPtr, UnityEngine.Object contextUnityObject);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeConditional("ENABLE_PROFILER")]
	internal static extern string Internal_GetName(IntPtr markerPtr);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetCategoryDescription_Injected(ushort categoryId, out ProfilerCategoryDescription ret);
}
