using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class BulletData : IReference
{
	public int configId;

	public float leadTime;

	public bool isOnlyExecuteHit;

	public bool ViewIsNeedLerp;

	public float StableMovementSharpness = 0.2f;

	public float StableRotationSharpness = 1f / 30f;

	public DRBullet cfg;

	public float alert_hitColliderScale;

	public float alert_lifeTime;

	public List<HitData> hitDataList;

	public Vector3 parentPosition;

	public BulletExtraData extraData;

	public int BelongToSkillId => cfg.SkillId;

	public HitData LastHitData
	{
		get
		{
			if (hitDataList == null || hitDataList.Count <= 0)
			{
				return null;
			}
			return hitDataList[hitDataList.Count - 1];
		}
	}

	public void Clear()
	{
		configId = 0;
		leadTime = 0f;
		isOnlyExecuteHit = false;
		cfg = null;
		extraData = null;
	}
}
