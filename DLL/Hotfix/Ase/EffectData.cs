using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class EffectData : IReference
{
	public EffectType effectType;

	public Vector3 offset;

	public Transform boneTsm;

	public bool isFollowBone;

	public bool followDispose;

	public bool FollowTreeStop;

	public int disposeType;

	public BaseEntity owner;

	public DREffect effectData;

	public bool IsAttackEffect;

	public bool ViewIsNeedLerp = true;

	public float StableMovementSharpness = 0.2f;

	public float StableRotationSharpness = 1f / 30f;

	public void Clear()
	{
		effectData = null;
		owner = null;
		followDispose = false;
		IsAttackEffect = false;
	}
}
