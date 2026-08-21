using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class LinkEffectData : IReference
{
	public EffectPlayPositionType LinkEffectType;

	public BaseEntity OwnerEntity;

	public BaseEntity LinkEntity;

	public string StartKey;

	public string LinkKey;

	public DREffect DrEffect;

	public Vector3 StartPosition;

	public Vector3 LinkPosition;

	public void Clear()
	{
		LinkEffectType = EffectPlayPositionType.BonePointAndBonePoint;
		StartPosition = Vector3.zero;
		LinkPosition = Vector3.zero;
		OwnerEntity = null;
		LinkEntity = null;
		DrEffect = null;
		LinkKey = null;
		StartKey = null;
	}
}
