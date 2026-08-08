using System;
using Config;
using UnityEngine;

[Serializable]
public struct TimelineHitRenderClip : IComparable<TimelineHitRenderClip>
{
	public float begin;

	public string hitEffectPath;

	public bool isAttach;

	public bool isLockRotaion;

	public Vector3 rotation;

	public Vector3 scale;

	public CriwareCueInfo CustomHitAudioCriwareInfo;

	public float hitUpHeight;

	public AnimationCurve hitUpCurve;

	public bool UseHitCurve;

	public float HitDownDuration;

	public bool UseHitDownDuration;

	public bool NeedUseCollision;

	public int Direction;

	public RangeType RangeType;

	public float Radius;

	public int Angle;

	public Vector3 Size;

	public int TurnDelta;

	public float RectDelta;

	public float CollisionCheckOffsetY;

	public Vector3 CenterOffset;

	public float OffsetOfFoward;

	public WeaponCategory WeaponCategory;

	public AttackActionCategory AttackActionCategory;

	public bool IsCannonBallDust;

	public int CompareTo(TimelineHitRenderClip other)
	{
		return begin.CompareTo(other.begin);
	}
}
