using System;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[NativeHeader("Runtime/Export/Camera/CullingGroup.bindings.h")]
public class CullingGroup
{
	public delegate void StateChanged(CullingGroupEvent sphere);

	internal IntPtr m_Ptr;

	private StateChanged m_OnStateChanged;

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
}
