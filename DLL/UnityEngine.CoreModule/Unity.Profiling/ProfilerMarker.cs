using System;
using System.Runtime.CompilerServices;
using JetBrains.Annotations;
using Unity.Collections.LowLevel.Unsafe;
using Unity.Profiling.LowLevel;
using Unity.Profiling.LowLevel.Unsafe;
using UnityEngine.Scripting;

namespace Unity.Profiling;

[UsedByNativeCode]
public struct ProfilerMarker
{
	[UsedByNativeCode]
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

	[MethodImpl((MethodImplOptions)256)]
	public ProfilerMarker(string name)
	{
		m_Ptr = ProfilerUnsafeUtility.CreateMarker(name, 1, MarkerFlags.Default, 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ProfilerMarker(ProfilerCategory category, string name)
	{
		m_Ptr = ProfilerUnsafeUtility.CreateMarker(name, category, MarkerFlags.Default, 0);
	}

	[MethodImpl((MethodImplOptions)256)]
	[Pure]
	public AutoScope Auto()
	{
		return new AutoScope(m_Ptr);
	}
}
