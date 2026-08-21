using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class CriAtomEx3dListener : CriDisposable
{
	public struct Config
	{
		public int reserved;
	}

	private IntPtr handle = IntPtr.Zero;

	public IntPtr nativeHandle => handle;

	public CriAtomEx3dListener()
	{
		Config config = default(Config);
		handle = criAtomEx3dListener_Create(ref config, IntPtr.Zero, 0);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
	}

	private void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (handle != IntPtr.Zero)
		{
			criAtomEx3dListener_Destroy(handle);
			handle = IntPtr.Zero;
		}
		if (disposing)
		{
			GC.SuppressFinalize(this);
		}
	}

	public void Update()
	{
		if (handle != IntPtr.Zero)
		{
			criAtomEx3dListener_Update(handle);
		}
	}

	public void ResetParameters()
	{
		if (handle != IntPtr.Zero)
		{
			criAtomEx3dListener_ResetParameters(handle);
		}
	}

	public void SetPosition(float x, float y, float z)
	{
		if (!(handle == IntPtr.Zero))
		{
			CriAtomEx.NativeVector position = default(CriAtomEx.NativeVector);
			position.x = x;
			position.y = y;
			position.z = z;
			criAtomEx3dListener_SetPosition(handle, ref position);
		}
	}

	public void SetVelocity(float x, float y, float z)
	{
		if (!(handle == IntPtr.Zero))
		{
			CriAtomEx.NativeVector velocity = default(CriAtomEx.NativeVector);
			velocity.x = x;
			velocity.y = y;
			velocity.z = z;
			criAtomEx3dListener_SetVelocity(handle, ref velocity);
		}
	}

	public void SetOrientation(float fx, float fy, float fz, float ux, float uy, float uz)
	{
		if (!(handle == IntPtr.Zero))
		{
			CriAtomEx.NativeVector front = default(CriAtomEx.NativeVector);
			front.x = fx;
			front.y = fy;
			front.z = fz;
			CriAtomEx.NativeVector top = default(CriAtomEx.NativeVector);
			top.x = ux;
			top.y = uy;
			top.z = uz;
			criAtomEx3dListener_SetOrientation(handle, ref front, ref top);
		}
	}

	[Obsolete("Use SetDopplerMultiplier instead")]
	public void SetDistanceFactor(float distanceFactor)
	{
		if (!(handle == IntPtr.Zero))
		{
			if (distanceFactor < 0f)
			{
				Debug.LogError("[CRIWARE] Invalid value for distanceFactor. Value >= 0f required.");
			}
			else if (distanceFactor == 0f)
			{
				criAtomEx3dListener_SetDopplerMultiplier(handle, 0f);
			}
			else
			{
				criAtomEx3dListener_SetDopplerMultiplier(handle, 1f / distanceFactor);
			}
		}
	}

	public void SetDopplerMultiplier(float dopplerMultiplier)
	{
		if (!(handle == IntPtr.Zero))
		{
			if (dopplerMultiplier < 0f)
			{
				Debug.LogError("[CRIWARE] Invalid value for dopplerMultiplier. Value >= 0f required.");
			}
			else
			{
				criAtomEx3dListener_SetDopplerMultiplier(handle, dopplerMultiplier);
			}
		}
	}

	public void SetFocusPoint(float x, float y, float z)
	{
		if (!(handle == IntPtr.Zero))
		{
			CriAtomEx.NativeVector focus_point = default(CriAtomEx.NativeVector);
			focus_point.x = x;
			focus_point.y = y;
			focus_point.z = z;
			criAtomEx3dListener_SetFocusPoint(handle, ref focus_point);
		}
	}

	public void SetDistanceFocusLevel(float distanceFocusLevel)
	{
		if (handle != IntPtr.Zero)
		{
			criAtomEx3dListener_SetDistanceFocusLevel(handle, distanceFocusLevel);
		}
	}

	public void SetDirectionFocusLevel(float directionFocusLevel)
	{
		if (handle != IntPtr.Zero)
		{
			criAtomEx3dListener_SetDirectionFocusLevel(handle, directionFocusLevel);
		}
	}

	public void Set3dRegion(CriAtomEx3dRegion region3d)
	{
		if (!(handle == IntPtr.Zero))
		{
			IntPtr ex_3d_region = region3d?.nativeHandle ?? IntPtr.Zero;
			criAtomEx3dListener_Set3dRegionHn(handle, ex_3d_region);
		}
	}

	public bool IsDestroyable()
	{
		return criAtomEx3dListener_IsDestroyable(handle);
	}

	~CriAtomEx3dListener()
	{
		Dispose(disposing: false);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomEx3dListener_Create(ref Config config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_Destroy(IntPtr ex_3d_listener);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_Update(IntPtr ex_3d_listener);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_ResetParameters(IntPtr ex_3d_listener);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_SetPosition(IntPtr ex_3d_listener, ref CriAtomEx.NativeVector position);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_SetVelocity(IntPtr ex_3d_listener, ref CriAtomEx.NativeVector velocity);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_SetOrientation(IntPtr ex_3d_listener, ref CriAtomEx.NativeVector front, ref CriAtomEx.NativeVector top);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_SetDistanceFactor(IntPtr ex_3d_listener, float distance_factor);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_SetDopplerMultiplier(IntPtr ex_3d_listener, float doppler_multiplier);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_SetFocusPoint(IntPtr ex_3d_listener, ref CriAtomEx.NativeVector focus_point);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_SetDistanceFocusLevel(IntPtr ex_3d_listener, float distance_focus_level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_SetDirectionFocusLevel(IntPtr ex_3d_listener, float direction_focus_level);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomEx3dListener_IsDestroyable(IntPtr ex_3d_listener);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dListener_Set3dRegionHn(IntPtr ex_3d_listener, IntPtr ex_3d_region);
}
