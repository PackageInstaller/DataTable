using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class CriAtomEx3dSource : CriDisposable
{
	public struct Config(bool enableVoicePriorityDecay, uint randomPositionListMaxLength)
	{
		public bool enableVoicePriorityDecay = enableVoicePriorityDecay;

		public uint randomPositionListMaxLength = randomPositionListMaxLength;
	}

	private uint currentRandomPositionListMaxLength;

	private IntPtr handle = IntPtr.Zero;

	public IntPtr nativeHandle => handle;

	public CriAtomEx3dSource(bool enableVoicePriorityDecay = false, uint randomPositionListMaxLength = 0u)
	{
		Config config = new Config(enableVoicePriorityDecay, randomPositionListMaxLength);
		handle = criAtomEx3dSource_Create(ref config, IntPtr.Zero, 0);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Atom);
		currentRandomPositionListMaxLength = randomPositionListMaxLength;
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
			criAtomEx3dSource_Destroy(handle);
			handle = IntPtr.Zero;
		}
		if (disposing)
		{
			GC.SuppressFinalize(this);
		}
	}

	public void Update()
	{
		criAtomEx3dSource_Update(handle);
	}

	public void ResetParameters()
	{
		criAtomEx3dSource_ResetParameters(handle);
	}

	public void SetPosition(float x, float y, float z)
	{
		CriAtomEx.NativeVector position = default(CriAtomEx.NativeVector);
		position.x = x;
		position.y = y;
		position.z = z;
		criAtomEx3dSource_SetPosition(handle, ref position);
	}

	public void SetVelocity(float x, float y, float z)
	{
		CriAtomEx.NativeVector velocity = default(CriAtomEx.NativeVector);
		velocity.x = x;
		velocity.y = y;
		velocity.z = z;
		criAtomEx3dSource_SetVelocity(handle, ref velocity);
	}

	public void SetOrientation(Vector3 front, Vector3 top)
	{
		CriAtomEx.NativeVector front2 = default(CriAtomEx.NativeVector);
		front2.x = front.x;
		front2.y = front.y;
		front2.z = front.z;
		CriAtomEx.NativeVector top2 = default(CriAtomEx.NativeVector);
		top2.x = top.x;
		top2.y = top.y;
		top2.z = top.z;
		criAtomEx3dSource_SetOrientation(handle, ref front2, ref top2);
	}

	[Obsolete("Use CriAtomEx3dSource.SetOrientation(Vector3, Vector3) instead")]
	public void SetConeOrientation(float x, float y, float z)
	{
		CriAtomEx.NativeVector cone_orient = default(CriAtomEx.NativeVector);
		cone_orient.x = x;
		cone_orient.y = y;
		cone_orient.z = z;
		criAtomEx3dSource_SetConeOrientation(handle, ref cone_orient);
	}

	public void SetConeParameter(float insideAngle, float outsideAngle, float outsideVolume)
	{
		criAtomEx3dSource_SetConeParameter(handle, insideAngle, outsideAngle, outsideVolume);
	}

	public void SetMinMaxDistance(float minDistance, float maxDistance)
	{
		criAtomEx3dSource_SetMinMaxAttenuationDistance(handle, minDistance, maxDistance);
	}

	public void SetInteriorPanField(float sourceRadius, float interiorDistance)
	{
		criAtomEx3dSource_SetInteriorPanField(handle, sourceRadius, interiorDistance);
	}

	public void SetDopplerFactor(float dopplerFactor)
	{
		criAtomEx3dSource_SetDopplerFactor(handle, dopplerFactor);
	}

	public void SetVolume(float volume)
	{
		criAtomEx3dSource_SetVolume(handle, volume);
	}

	public void SetMaxAngleAisacDelta(float maxDelta)
	{
		criAtomEx3dSource_SetMaxAngleAisacDelta(handle, maxDelta);
	}

	public void SetAttenuationDistanceSetting(bool flag)
	{
		criAtomEx3dSource_SetAttenuationDistanceSetting(handle, flag);
	}

	public bool GetAttenuationDistanceSetting()
	{
		return criAtomEx3dSource_GetAttenuationDistanceSetting(handle);
	}

	public void SetRandomPositionConfig(CriAtomEx.Randomize3dConfig? config)
	{
		if (config.HasValue)
		{
			if (config.Value.CalculationType == CriAtomEx.Randomize3dCalcType.None)
			{
				criAtomEx3dSource_SetRandomPositionConfig(handle, IntPtr.Zero);
				return;
			}
			CriAtomEx.Randomize3dConfig config2 = config.Value;
			criAtomEx3dSource_SetRandomPositionConfig(handle, ref config2);
		}
		else
		{
			criAtomEx3dSource_SetRandomPositionConfig(handle, IntPtr.Zero);
		}
	}

	public void SetRandomPositionList(Vector3[] positionList)
	{
		if (currentRandomPositionListMaxLength == 0)
		{
			Debug.LogError("[CRIWARE] The maxmium amount of random positions is set to 0. List will not be set.");
			return;
		}
		if (positionList.Length > currentRandomPositionListMaxLength)
		{
			Debug.LogError("[CRIWARE] Input list of positions is longer than maxmium length setting. List will not be set.");
			return;
		}
		CriAtomEx.NativeVector[] array = new CriAtomEx.NativeVector[positionList.Length];
		for (int i = 0; i < positionList.Length; i++)
		{
			array[i] = new CriAtomEx.NativeVector(positionList[i]);
		}
		criAtomEx3dSource_SetRandomPositionList(handle, array, (uint)positionList.Length);
	}

	public void Set3dRegion(CriAtomEx3dRegion region3d)
	{
		IntPtr ex_3d_region = region3d?.nativeHandle ?? IntPtr.Zero;
		criAtomEx3dSource_Set3dRegionHn(handle, ex_3d_region);
	}

	public void SetListenerBasedElevationAngleAisacControlId(ushort aisacControlId)
	{
		criAtomEx3dSource_SetListenerBasedElevationAngleAisacControlId(handle, aisacControlId);
	}

	public void SetSourceBasedElevationAngleAisacControlId(ushort aisacControlId)
	{
		criAtomEx3dSource_SetSourceBasedElevationAngleAisacControlId(handle, aisacControlId);
	}

	public void SetDistanceAisacControlId(ushort aisacControlId)
	{
		criAtomEx3dSource_SetDistanceAisacControlId(handle, aisacControlId);
	}

	public bool IsDestroyable()
	{
		return criAtomEx3dSource_IsDestroyable(handle);
	}

	public CriAtomEx.NativeVector GetPosition()
	{
		return criAtomEx3dSource_GetPosition(handle);
	}

	~CriAtomEx3dSource()
	{
		Dispose(disposing: false);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomEx3dSource_Create(ref Config config, IntPtr work, int work_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_Destroy(IntPtr ex_3d_source);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_Update(IntPtr ex_3d_source);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_ResetParameters(IntPtr ex_3d_source);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetPosition(IntPtr ex_3d_source, ref CriAtomEx.NativeVector position);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetVelocity(IntPtr ex_3d_source, ref CriAtomEx.NativeVector velocity);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetOrientation(IntPtr ex_3d_source, ref CriAtomEx.NativeVector front, ref CriAtomEx.NativeVector top);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetConeOrientation(IntPtr ex_3d_source, ref CriAtomEx.NativeVector cone_orient);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetConeParameter(IntPtr ex_3d_source, float inside_angle, float outside_angle, float outside_volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetMinMaxAttenuationDistance(IntPtr ex_3d_source, float min_distance, float max_distance);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetInteriorPanField(IntPtr ex_3d_source, float source_radius, float interior_distance);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetDopplerFactor(IntPtr ex_3d_source, float doppler_factor);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetVolume(IntPtr ex_3d_source, float volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetMaxAngleAisacDelta(IntPtr ex_3d_source, float max_delta);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetAttenuationDistanceSetting(IntPtr ex_3d_source, bool flag);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomEx3dSource_GetAttenuationDistanceSetting(IntPtr ex_3d_source);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetRandomPositionConfig(IntPtr ex_3d_source, ref CriAtomEx.Randomize3dConfig config);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetRandomPositionConfig(IntPtr ex_3d_source, IntPtr config);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetRandomPositionList(IntPtr ex_3d_source, CriAtomEx.NativeVector[] position_list, uint length);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetDistanceAisacControlId(IntPtr ex_3d_source, ushort aisac_control_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomEx3dSource_IsDestroyable(IntPtr ex_3d_source);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern CriAtomEx.NativeVector criAtomEx3dSource_GetPosition(IntPtr ex_3d_source);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_Set3dRegionHn(IntPtr ex_3d_source, IntPtr ex_3d_region);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetListenerBasedElevationAngleAisacControlId(IntPtr ex_3d_source, ushort aisac_control_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx3dSource_SetSourceBasedElevationAngleAisacControlId(IntPtr ex_3d_source, ushort aisac_control_id);
}
