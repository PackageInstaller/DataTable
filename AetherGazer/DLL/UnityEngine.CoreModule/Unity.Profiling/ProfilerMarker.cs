using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using JetBrains.Annotations;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Profiling.LowLevel;
using Unity.Profiling.LowLevel.Unsafe;
using UnityEngine;
using UnityEngine.Scripting;

namespace Unity.Profiling;

[IgnoredByDeepProfiler]
[UsedByNativeCode]
public struct ProfilerMarker
{
	[UsedByNativeCode]
	[IgnoredByDeepProfiler]
	public struct AutoScope : IDisposable
	{
		[NativeDisableUnsafePtrRestriction]
		internal readonly IntPtr m_Ptr;

		[MethodImpl((MethodImplOptions)256)]
		internal AutoScope(IntPtr markerPtr)
		{
			m_Ptr = markerPtr;
			if (m_Ptr != IntPtr.Zero)
			{
				ProfilerUnsafeUtility.BeginSample(markerPtr);
			}
		}

		[MethodImpl((MethodImplOptions)256)]
		public void Dispose()
		{
			if (m_Ptr != IntPtr.Zero)
			{
				ProfilerUnsafeUtility.EndSample(m_Ptr);
			}
		}
	}

	[NonSerialized]
	[NativeDisableUnsafePtrRestriction]
	internal readonly IntPtr m_Ptr;

	public IntPtr Handle => m_Ptr;

	[MethodImpl((MethodImplOptions)256)]
	public ProfilerMarker(string name)
	{
		m_Ptr = ProfilerUnsafeUtility.CreateMarker(name, 1, MarkerFlags.Default, 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe ProfilerMarker(char* name, int nameLen)
	{
		m_Ptr = ProfilerUnsafeUtility.CreateMarker(name, nameLen, 1, MarkerFlags.Default, 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ProfilerMarker(ProfilerCategory category, string name)
	{
		m_Ptr = ProfilerUnsafeUtility.CreateMarker(name, category, MarkerFlags.Default, 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe ProfilerMarker(ProfilerCategory category, char* name, int nameLen)
	{
		m_Ptr = ProfilerUnsafeUtility.CreateMarker(name, nameLen, category, MarkerFlags.Default, 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ProfilerMarker(ProfilerCategory category, string name, MarkerFlags flags)
	{
		m_Ptr = ProfilerUnsafeUtility.CreateMarker(name, category, flags, 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe ProfilerMarker(ProfilerCategory category, char* name, int nameLen, MarkerFlags flags)
	{
		m_Ptr = ProfilerUnsafeUtility.CreateMarker(name, nameLen, category, flags, 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	[Pure]
	[Conditional("ENABLE_PROFILER")]
	public void Begin()
	{
		ProfilerUnsafeUtility.BeginSample(m_Ptr);
	}

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_PROFILER")]
	public void Begin(UnityEngine.Object contextUnityObject)
	{
		ProfilerUnsafeUtility.Internal_BeginWithObject(m_Ptr, contextUnityObject);
	}

	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_PROFILER")]
	[Pure]
	public void End()
	{
		ProfilerUnsafeUtility.EndSample(m_Ptr);
	}

	[Conditional("ENABLE_PROFILER")]
	internal void GetName(ref string name)
	{
		name = ProfilerUnsafeUtility.Internal_GetName(m_Ptr);
	}

	[MethodImpl((MethodImplOptions)256)]
	[Pure]
	public AutoScope Auto()
	{
		return new AutoScope(m_Ptr);
	}
}
