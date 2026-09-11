using System;
using UnityEngine;

[Serializable]
public struct TimelineCameraShakeClip : IComparable<TimelineCameraShakeClip>
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public float range;

	public bool IsUseCurve;

	public bool IsRelatedWithHit;

	public AnimationCurve CurveX;

	public AnimationCurve CurveY;

	public AnimationCurve CurveZ;

	public bool IsUseRangeCurve;

	public AnimationCurve CurveRange;

	public float MaxDistance;

	public AnimationCurve CurveDistance;

	public float MaxHeight;

	public AnimationCurve CurveHeight;

	public float MaxLookAtHeight;

	public AnimationCurve CurveLookAtHeight;

	public E_CameraType CameraType;

	public float AmendmentSpeed;

	public float MaxAmendmentDistance;

	public Vector3 MinCurveRangePercent;

	public Vector3 MaxCurveRangePercent;

	public int CompareTo(TimelineCameraShakeClip other)
	{
		return NormalizedBegin.CompareTo(other.NormalizedBegin);
	}
}
