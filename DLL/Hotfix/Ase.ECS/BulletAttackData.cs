using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class BulletAttackData : IReference
{
	public BulletData bulletData;

	public float lifeTime;

	public Vector3 attackDirect;

	public int bulletId;

	public int weaknessAttackPower;

	public Vector3 BulletPos;

	public HitVolume Volume;

	public HitColliderVariableData HitColliderVariableData;

	public BulletParentPropertyData BulletParentPropertyData;

	public List<Buff> addBuffList;

	public static BulletAttackData Create(int bulletId, BulletData bulletData, float lifeTime, Vector3 attackDirect, Vector3 bulletPos, HitVolume Volume = null, HitColliderVariableData hitcolliderVariableData = null, BulletParentPropertyData bulletParentPropertyData = null)
	{
		BulletAttackData bulletAttackData = ReferencePool.Acquire<BulletAttackData>();
		bulletAttackData.bulletId = bulletId;
		bulletAttackData.bulletData = bulletData;
		bulletAttackData.attackDirect = attackDirect;
		bulletAttackData.lifeTime = lifeTime;
		bulletAttackData.BulletPos = bulletPos;
		bulletAttackData.Volume = Volume;
		bulletAttackData.HitColliderVariableData = hitcolliderVariableData;
		bulletAttackData.BulletParentPropertyData = bulletParentPropertyData;
		bulletAttackData.weaknessAttackPower = bulletData.cfg.WeaknessAttackPower;
		return bulletAttackData;
	}

	public void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public void Clear()
	{
		bulletData = null;
		Volume = null;
		HitColliderVariableData = null;
		BulletParentPropertyData = null;
		if (addBuffList != null)
		{
			CollectionPool<List<Buff>, Buff>.Release(addBuffList);
			addBuffList = null;
		}
	}
}
