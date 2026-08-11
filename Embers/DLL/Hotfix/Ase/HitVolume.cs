#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;
using PrimitiveDetection;
using UnityEngine;

namespace Ase;

public class HitVolume : BaseVolume
{
	private int _ownerId;

	private VolumeData _volumeData;

	private BaseEntity _ownerEntity;

	private PrimitiveInfo _primitiveInfo;

	private BasePrimitive _primitive;

	private string key;

	public override int OwnerId => _ownerId;

	public string Key => key;

	public override VolumeData VolumeData => _volumeData;

	public override PrimitiveInfo PrimitiveInfo => _primitiveInfo;

	public override BasePrimitive Primitive => _primitive;

	public static HitVolume Create(BaseEntity ownerEntity, string key, VolumeData volumeData)
	{
		HitVolume hitVolume = ReferencePool.Acquire<HitVolume>();
		hitVolume._ownerId = ownerEntity.Id;
		hitVolume.key = key;
		hitVolume._volumeData = volumeData;
		hitVolume._ownerEntity = ownerEntity;
		hitVolume._primitiveInfo.Type = volumeData.primitiveEnum;
		hitVolume._primitiveInfo.Center = ownerEntity.transform.position + ownerEntity.transform.rotation * volumeData.offset;
		hitVolume._primitiveInfo.Quaternion = Quaternion.Normalize(ownerEntity.transform.rotation * Quaternion.Euler(volumeData.eulerOffset));
		hitVolume._primitiveInfo = PrimitiveSystem.InitPrimitiveInfo(ref hitVolume._primitiveInfo, hitVolume._volumeData.primitiveParam);
		hitVolume._primitive = PrimitiveSystem.CreatePrimitive(hitVolume._primitiveInfo);
		hitVolume.SetEnable(enable: true);
		return hitVolume;
	}

	public static HitVolume CreateNormal(string key, Vector3 position, Quaternion rotation, VolumeData volumeData)
	{
		HitVolume hitVolume = ReferencePool.Acquire<HitVolume>();
		hitVolume._ownerId = 0;
		hitVolume.key = key;
		hitVolume._volumeData = volumeData;
		hitVolume._primitiveInfo.Type = volumeData.primitiveEnum;
		hitVolume._primitiveInfo.Center = position + rotation * volumeData.offset;
		hitVolume._primitiveInfo.Quaternion = Quaternion.Normalize(rotation * Quaternion.Euler(volumeData.eulerOffset));
		hitVolume._primitiveInfo = PrimitiveSystem.InitPrimitiveInfo(ref hitVolume._primitiveInfo, hitVolume._volumeData.primitiveParam);
		hitVolume._primitive = PrimitiveSystem.CreatePrimitive(hitVolume._primitiveInfo);
		hitVolume.SetEnable(enable: true);
		return hitVolume;
	}

	public override void OnUpdate(float deltaTime)
	{
		_primitiveInfo.Center = _ownerEntity.transform.position + _ownerEntity.transform.rotation * _volumeData.offset;
		_primitiveInfo.Quaternion = Quaternion.Normalize(_ownerEntity.transform.rotation * Quaternion.Euler(_volumeData.eulerOffset));
		_primitive.UpdateSelf(_primitiveInfo);
	}

	public override void OnUpdateTransform(Vector3 position, Quaternion quaternion)
	{
		_primitiveInfo.Center = position;
		_primitiveInfo.Quaternion = quaternion;
		_primitive.UpdateSelf(_primitiveInfo);
	}

	public Vector3 GetColliderParam()
	{
		return _primitiveInfo.Type switch
		{
			PrimitiveEnum.BoxPrimitive => _primitiveInfo.BoxSize, 
			PrimitiveEnum.SpherePrimitive => _primitiveInfo.Radius * Vector3.one, 
			PrimitiveEnum.SectorPrimitive => _primitiveInfo.Radius * Vector3.one, 
			_ => Vector3.zero, 
		};
	}

	public override Vector3 GetHitVolumePoint(HitVolumePointEnum pointEnum)
	{
		if (pointEnum == HitVolumePointEnum.Center)
		{
			return PrimitiveInfo.Center;
		}
		switch (_primitiveInfo.Type)
		{
		case PrimitiveEnum.CapsulePrimitive:
			switch (pointEnum)
			{
			case HitVolumePointEnum.Highest:
				if (_primitive is CapsulePrimitive capsulePrimitive2)
				{
					return new Vector3(capsulePrimitive2.CapsuleCenter.x, capsulePrimitive2.CapsuleCenter.y + capsulePrimitive2.HalfHeight.y, capsulePrimitive2.CapsuleCenter.z);
				}
				break;
			case HitVolumePointEnum.Lowest:
				if (_primitive is CapsulePrimitive capsulePrimitive)
				{
					return new Vector3(capsulePrimitive.CapsuleCenter.x, capsulePrimitive.CapsuleCenter.y - capsulePrimitive.HalfHeight.y, capsulePrimitive.CapsuleCenter.z);
				}
				break;
			}
			break;
		case PrimitiveEnum.SpherePrimitive:
			switch (pointEnum)
			{
			case HitVolumePointEnum.Highest:
				return new Vector3(PrimitiveInfo.Center.x, PrimitiveInfo.Center.y + PrimitiveInfo.Radius / 2f, PrimitiveInfo.Center.z);
			case HitVolumePointEnum.Lowest:
				return new Vector3(PrimitiveInfo.Center.x, PrimitiveInfo.Center.y - PrimitiveInfo.Radius / 2f, PrimitiveInfo.Center.z);
			}
			break;
		case PrimitiveEnum.BoxPrimitive:
			switch (pointEnum)
			{
			case HitVolumePointEnum.Highest:
				return new Vector3(PrimitiveInfo.Center.x, PrimitiveInfo.Center.y + PrimitiveInfo.BoxSize.y / 2f, PrimitiveInfo.Center.z);
			case HitVolumePointEnum.Lowest:
				return new Vector3(PrimitiveInfo.Center.x, PrimitiveInfo.Center.y - PrimitiveInfo.BoxSize.y / 2f, PrimitiveInfo.Center.z);
			}
			break;
		default:
			Log.Error($"{_primitiveInfo.Type} 不支持获取特殊点位");
			return PrimitiveInfo.Center;
		case PrimitiveEnum.NONE:
			break;
		}
		return Vector3.zero;
	}

	public bool AdjustCapsuleRadius(float radius)
	{
		if (_primitiveInfo.Type == PrimitiveEnum.CapsulePrimitive)
		{
			_primitiveInfo.Radius = radius;
			return true;
		}
		return false;
	}

	public override void TransferHit(int fromId)
	{
		_ownerEntity.GetComponent<HitColliderComponent>().OnReceiveHit(fromId, this);
	}

	public void TransferAlertHit(int fromId)
	{
		_ownerEntity.GetComponent<HitColliderComponent>().OnReceiveAlertHit(fromId, this);
	}

	public override void Clear()
	{
		_ownerId = 0;
		_ownerEntity = null;
		_volumeData = null;
		_primitive.OnDispose();
	}
}
