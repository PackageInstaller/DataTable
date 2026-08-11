using GameFramework;
using UnityEngine;

namespace Ase;

public class HitColliderSettingData : IReference
{
	public VolumeData _volumeData = new VolumeData();

	[SerializeField]
	private HitColliderVariableData _hitColliderVariableData = new HitColliderVariableData();

	public VolumeData VolumeData => _volumeData;

	public HitColliderVariableData HitColliderVariableData => _hitColliderVariableData;

	public static HitColliderSettingData Create(VolumeData volumeData, HitColliderVariableData hitColliderVariableData = null)
	{
		HitColliderSettingData hitColliderSettingData = ReferencePool.Acquire<HitColliderSettingData>();
		hitColliderSettingData._volumeData = volumeData;
		hitColliderSettingData._hitColliderVariableData = hitColliderVariableData;
		return hitColliderSettingData;
	}

	public void ColliderSettingDataLog()
	{
	}

	public void Dispose()
	{
		ReferencePool.Release(_volumeData);
		ReferencePool.Release(_hitColliderVariableData);
	}

	public void Clear()
	{
		_volumeData.Clear();
		_hitColliderVariableData.Clear();
	}
}
