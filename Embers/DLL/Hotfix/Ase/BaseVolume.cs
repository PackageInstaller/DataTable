using Ase.ECS;
using GameFramework;
using PrimitiveDetection;
using UnityEngine;

namespace Ase;

public abstract class BaseVolume : IReference
{
	public virtual int OwnerId => -1;

	public abstract VolumeData VolumeData { get; }

	public abstract PrimitiveInfo PrimitiveInfo { get; }

	public abstract BasePrimitive Primitive { get; }

	public bool Enable { get; private set; } = true;

	public void SetEnable(bool enable)
	{
		Enable = enable;
	}

	public abstract void TransferHit(int fromId);

	public abstract void OnUpdate(float deltaTime);

	public abstract void OnUpdateTransform(Vector3 position, Quaternion quaternion);

	public abstract Vector3 GetHitVolumePoint(HitVolumePointEnum pointEnum);

	public virtual void Clear()
	{
	}
}
