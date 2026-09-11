using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class CriAtomEx3dTransceiver : CriDisposable
{
	public struct Config
	{
		public int reserved;
	}

	private static class UnsafeNativeMethods
	{
		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern IntPtr criAtomEx3dTransceiver_Create(ref Config config, IntPtr work, int work_size);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_Destroy(IntPtr ex_3d_transceiver);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_Update(IntPtr ex_3d_transceiver);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetInputPosition(IntPtr ex_3d_transceiver, ref CriAtomEx.NativeVector position);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetOutputPosition(IntPtr ex_3d_transceiver, ref CriAtomEx.NativeVector position);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetInputOrientation(IntPtr ex_3d_transceiver, ref CriAtomEx.NativeVector front, ref CriAtomEx.NativeVector top);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetOutputOrientation(IntPtr ex_3d_transceiver, ref CriAtomEx.NativeVector front, ref CriAtomEx.NativeVector top);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetOutputConeParameter(IntPtr ex_3d_transceiver, float inside_angle, float outside_angle, float outside_volume);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetOutputMinMaxAttenuationDistance(IntPtr ex_3d_transceiver, float min_attenuation_distance, float max_attenuation_distance);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetOutputInteriorPanField(IntPtr ex_3d_transceiver, float transceiver_radius, float interior_distance);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetInputCrossFadeField(IntPtr ex_3d_transceiver, float direct_audio_radius, float crossfade_distance);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetOutputVolume(IntPtr ex_3d_transceiver, float volume);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_AttachAisac(IntPtr ex_3d_transceiver, string global_aisac_name);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_DetachAisac(IntPtr ex_3d_transceiver, string global_aisac_name);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetMaxAngleAisacDelta(IntPtr ex_3d_transceiver, float max_delta);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetDistanceAisacControlId(IntPtr ex_3d_transceiver, ushort aisac_control_id);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetListenerBasedAzimuthAngleAisacControlId(IntPtr ex_3d_transceiver, ushort aisac_control_id);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetListenerBasedElevationAngleAisacControlId(IntPtr ex_3d_transceiver, ushort aisac_control_id);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetTransceiverOutputBasedAzimuthAngleAisacControlId(IntPtr ex_3d_transceiver, ushort aisac_control_id);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_SetTransceiverOutputBasedElevationAngleAisacControlId(IntPtr ex_3d_transceiver, ushort aisac_control_id);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomEx3dTransceiver_Set3dRegionHn(IntPtr ex_3d_transceiver, IntPtr ex_3d_region);
	}

	private IntPtr handle = IntPtr.Zero;

	public IntPtr nativeHandle => handle;

	public CriAtomEx3dTransceiver()
	{
		Config config = default(Config);
		handle = UnsafeNativeMethods.criAtomEx3dTransceiver_Create(ref config, IntPtr.Zero, 0);
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
			UnsafeNativeMethods.criAtomEx3dTransceiver_Destroy(handle);
			handle = IntPtr.Zero;
		}
		if (disposing)
		{
			GC.SuppressFinalize(this);
		}
	}

	public void Update()
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_Update(handle);
	}

	public void SetInputPosition(Vector3 position)
	{
		CriAtomEx.NativeVector position2 = new CriAtomEx.NativeVector(position);
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetInputPosition(handle, ref position2);
	}

	public void SetOutputPosition(Vector3 position)
	{
		CriAtomEx.NativeVector position2 = new CriAtomEx.NativeVector(position);
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetOutputPosition(handle, ref position2);
	}

	public void SetInputOrientation(Vector3 front, Vector3 top)
	{
		CriAtomEx.NativeVector front2 = new CriAtomEx.NativeVector(front);
		CriAtomEx.NativeVector top2 = new CriAtomEx.NativeVector(top);
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetInputOrientation(handle, ref front2, ref top2);
	}

	public void SetOutputOrientation(Vector3 front, Vector3 top)
	{
		CriAtomEx.NativeVector front2 = new CriAtomEx.NativeVector(front);
		CriAtomEx.NativeVector top2 = new CriAtomEx.NativeVector(top);
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetOutputOrientation(handle, ref front2, ref top2);
	}

	public void SetOutputConeParameter(float insideAngle, float outsideAngle, float outsideVolume)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetOutputConeParameter(handle, insideAngle, outsideAngle, outsideVolume);
	}

	public void SetOutputMinMaxDistance(float minDistance, float maxDistance)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetOutputMinMaxAttenuationDistance(handle, minDistance, maxDistance);
	}

	public void SetOutputInteriorPanField(float radius, float interiorDistance)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetOutputInteriorPanField(handle, radius, interiorDistance);
	}

	public void SetInputCrossFadeField(float directAudioRadius, float crossfadeDistance)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetInputCrossFadeField(handle, directAudioRadius, crossfadeDistance);
	}

	public void SetOutputVolume(float volume)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetOutputVolume(handle, volume);
	}

	public void AttachAisac(string globalAisacName)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_AttachAisac(handle, globalAisacName);
	}

	public void DetachAisac(string globalAisacName)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_DetachAisac(handle, globalAisacName);
	}

	public void SetMaxAngleAisacDelta(float maxDelta)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetMaxAngleAisacDelta(handle, maxDelta);
	}

	public void SetDistanceAisacControlId(ushort aisacControlId)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetDistanceAisacControlId(handle, aisacControlId);
	}

	public void SetListenerBasedAzimuthAngleAisacControlId(ushort aisacControlId)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetListenerBasedAzimuthAngleAisacControlId(handle, aisacControlId);
	}

	public void SetListenerBasedElevationAngleAisacControlId(ushort aisacControlId)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetListenerBasedElevationAngleAisacControlId(handle, aisacControlId);
	}

	public void SetTransceiverOutputBasedAzimuthAngleAisacControlId(ushort aisacControlId)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetTransceiverOutputBasedAzimuthAngleAisacControlId(handle, aisacControlId);
	}

	public void SetTransceiverOutputBasedElevationAngleAisacControlId(ushort aisacControlId)
	{
		UnsafeNativeMethods.criAtomEx3dTransceiver_SetTransceiverOutputBasedElevationAngleAisacControlId(handle, aisacControlId);
	}

	public void Set3dRegion(CriAtomEx3dRegion region3d)
	{
		IntPtr ex_3d_region = region3d?.nativeHandle ?? IntPtr.Zero;
		UnsafeNativeMethods.criAtomEx3dTransceiver_Set3dRegionHn(handle, ex_3d_region);
	}

	~CriAtomEx3dTransceiver()
	{
		Dispose(disposing: false);
	}
}
