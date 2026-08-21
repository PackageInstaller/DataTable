using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.Profiling.LowLevel.Unsafe;

[UsedByNativeCode]
[NativeHeader("Runtime/Profiler/ScriptBindings/ProfilerUnsafeUtility.bindings.h")]
public static class ProfilerUnsafeUtility
{
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
	public static extern void BeginSample(IntPtr markerPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void EndSample(IntPtr markerPtr);

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
	private static extern void GetCategoryDescription_Injected(ushort categoryId, out ProfilerCategoryDescription ret);
}
