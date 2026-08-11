using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[NativeHeader("Runtime/Export/Camera/CullingGroup.bindings.h")]
public class CullingGroup : IDisposable
{
	public delegate void StateChanged(CullingGroupEvent sphere);

	internal IntPtr m_Ptr;

	private StateChanged m_OnStateChanged = null;

	public extern Camera targetCamera
	{
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public CullingGroup()
	{
		m_Ptr = Init(this);
	}

	~CullingGroup()
	{
		if (m_Ptr != IntPtr.Zero)
		{
			FinalizerFailure();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("CullingGroup_Bindings::Dispose", HasExplicitThis = true)]
	private extern void DisposeInternal();

	public void Dispose()
	{
		DisposeInternal();
		m_Ptr = IntPtr.Zero;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SetBoundingSpheres([Unmarshalled] BoundingSphere[] array);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SetBoundingSphereCount(int count);

	public int QueryIndices(bool visible, int[] result, int firstIndex)
	{
		return QueryIndices(visible, -1, CullingQueryOptions.IgnoreDistance, result, firstIndex);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("CullingGroup_Bindings::QueryIndices", HasExplicitThis = true)]
	[NativeThrows]
	private extern int QueryIndices(bool visible, int distanceIndex, CullingQueryOptions options, [Unmarshalled] int[] result, int firstIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("CullingGroup_Bindings::SetBoundingDistances", HasExplicitThis = true)]
	public extern void SetBoundingDistances([Unmarshalled] float[] distances);

	[FreeFunction("CullingGroup_Bindings::SetDistanceReferencePoint", HasExplicitThis = true)]
	private void SetDistanceReferencePoint_InternalVector3(Vector3 point)
	{
		SetDistanceReferencePoint_InternalVector3_Injected(ref point);
	}

	public void SetDistanceReferencePoint(Vector3 point)
	{
		SetDistanceReferencePoint_InternalVector3(point);
	}

	[RequiredByNativeCode]
	private unsafe static void SendEvents(CullingGroup cullingGroup, IntPtr eventsPtr, int count)
	{
		CullingGroupEvent* ptr = (CullingGroupEvent*)eventsPtr.ToPointer();
		if (cullingGroup.m_OnStateChanged != null)
		{
			for (int i = 0; i < count; i++)
			{
				cullingGroup.m_OnStateChanged(ptr[i]);
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("CullingGroup_Bindings::Init")]
	private static extern IntPtr Init(object scripting);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("CullingGroup_Bindings::FinalizerFailure", HasExplicitThis = true, IsThreadSafe = true)]
	private extern void FinalizerFailure();

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetDistanceReferencePoint_InternalVector3_Injected(ref Vector3 point);
}
