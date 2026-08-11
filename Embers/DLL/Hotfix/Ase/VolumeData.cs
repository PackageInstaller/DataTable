using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class VolumeData : IReference
{
	public Vector3 offset;

	public Vector3 eulerOffset;

	public PrimitiveEnum primitiveEnum = PrimitiveEnum.SpherePrimitive;

	[Tooltip("方形:x,y,z\n 球:半径\n 胶囊:半径,长度")]
	public List<float> primitiveParam = new List<float>();

	public bool isShow;

	public Color color = Color.white;

	public static VolumeData Create(Vector3 offset, Vector3 eulerOffset, PrimitiveEnum primitiveEnum, List<float> primitiveParams)
	{
		VolumeData volumeData = ReferencePool.Acquire<VolumeData>();
		volumeData.offset = offset;
		volumeData.eulerOffset = eulerOffset;
		volumeData.primitiveEnum = primitiveEnum;
		volumeData.primitiveParam = primitiveParams ?? new List<float>();
		return volumeData;
	}

	public static VolumeData Create(HitColliderEditorSetting setting)
	{
		VolumeData volumeData = ReferencePool.Acquire<VolumeData>();
		volumeData.offset = setting.offset;
		volumeData.eulerOffset = setting.eulerOffset;
		volumeData.primitiveEnum = setting.primitiveEnum;
		volumeData.isShow = setting.isShow;
		volumeData.color = setting.color;
		if (volumeData.primitiveEnum == PrimitiveEnum.BoxPrimitive)
		{
			volumeData.primitiveParam = new List<float> { setting.x, setting.y, setting.z };
		}
		else if (volumeData.primitiveEnum == PrimitiveEnum.SpherePrimitive)
		{
			volumeData.primitiveParam = new List<float> { setting.spRadius };
		}
		else if (volumeData.primitiveEnum == PrimitiveEnum.CapsulePrimitive)
		{
			volumeData.primitiveParam = new List<float> { setting.capRadius, setting.height };
		}
		else
		{
			volumeData.primitiveEnum = PrimitiveEnum.NONE;
			volumeData.primitiveParam = new List<float>();
		}
		return volumeData;
	}

	public void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public void Clear()
	{
		primitiveParam.Clear();
	}
}
