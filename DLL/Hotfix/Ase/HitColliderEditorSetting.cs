using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class HitColliderEditorSetting : IReference
{
	public PrimitiveEnum primitiveEnum;

	public Vector3 offset;

	public Vector3 eulerOffset;

	public float spRadius;

	public float capRadius;

	public float height;

	public float x;

	public float y;

	public float z;

	[Tooltip("从1开始且默认值为1。0认为无效")]
	[SerializeField]
	public int weight = 1;

	[SerializeField]
	public float damageMagnification = 1f;

	[SerializeField]
	public float tenacityMagnification = 1f;

	[SerializeField]
	public int siteLevel;

	[SerializeField]
	public bool isShow = true;

	[SerializeField]
	public Color color = Color.white;

	public static HitColliderEditorSetting Create(HitColliderSettingData colliderSettingData)
	{
		HitColliderEditorSetting hitColliderEditorSetting = ReferencePool.Acquire<HitColliderEditorSetting>();
		VolumeData volumeData = colliderSettingData.VolumeData;
		hitColliderEditorSetting.primitiveEnum = volumeData.primitiveEnum;
		hitColliderEditorSetting.offset = volumeData.offset;
		hitColliderEditorSetting.eulerOffset = volumeData.eulerOffset;
		hitColliderEditorSetting.spRadius = 0f;
		hitColliderEditorSetting.capRadius = 0f;
		hitColliderEditorSetting.height = 0f;
		hitColliderEditorSetting.x = 0f;
		hitColliderEditorSetting.y = 0f;
		hitColliderEditorSetting.z = 0f;
		HitColliderVariableData hitColliderVariableData = colliderSettingData.HitColliderVariableData;
		hitColliderEditorSetting.weight = hitColliderVariableData?.Weight ?? 1;
		hitColliderEditorSetting.damageMagnification = hitColliderVariableData?.DamageMagnification ?? 1f;
		hitColliderEditorSetting.tenacityMagnification = hitColliderVariableData?.TenacityMagnification ?? 1f;
		hitColliderEditorSetting.siteLevel = hitColliderVariableData?.SiteLevel ?? 0;
		if (volumeData.primitiveParam == null)
		{
			return hitColliderEditorSetting;
		}
		List<float> list = new List<float>();
		foreach (float item in volumeData.primitiveParam)
		{
			list.Add(item);
		}
		if (hitColliderEditorSetting.primitiveEnum == PrimitiveEnum.SpherePrimitive)
		{
			hitColliderEditorSetting.spRadius = ((list.Count >= 1) ? list[0] : 0f);
			list.Clear();
			return hitColliderEditorSetting;
		}
		if (hitColliderEditorSetting.primitiveEnum == PrimitiveEnum.CapsulePrimitive)
		{
			hitColliderEditorSetting.capRadius = ((list.Count >= 1) ? list[0] : 0f);
			hitColliderEditorSetting.height = ((list.Count >= 2) ? list[1] : 0f);
			list.Clear();
			return hitColliderEditorSetting;
		}
		if (hitColliderEditorSetting.primitiveEnum == PrimitiveEnum.BoxPrimitive)
		{
			hitColliderEditorSetting.x = ((list.Count >= 1) ? list[0] : 0f);
			hitColliderEditorSetting.y = ((list.Count >= 2) ? list[1] : 0f);
			hitColliderEditorSetting.z = ((list.Count >= 3) ? list[2] : 0f);
			list.Clear();
			return hitColliderEditorSetting;
		}
		list.Clear();
		return hitColliderEditorSetting;
	}

	public void Clear()
	{
		primitiveEnum = PrimitiveEnum.NONE;
		offset = Vector3.zero;
		eulerOffset = Vector3.zero;
		spRadius = 0f;
		capRadius = 0f;
		height = 0f;
		x = 0f;
		y = 0f;
		z = 0f;
		weight = 1;
		damageMagnification = 1f;
		tenacityMagnification = 1f;
		siteLevel = 0;
		isShow = true;
		color = Color.white;
	}
}
