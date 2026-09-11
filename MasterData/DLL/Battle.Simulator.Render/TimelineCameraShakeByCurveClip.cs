using System;
using UnityEngine;

[Serializable]
public struct TimelineCameraShakeByCurveClip : IComparable<TimelineCameraShakeByCurveClip>
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public AnimationCurve CurveX;

	public AnimationCurve CurveY;

	public AnimationCurve CurveZ;

	public int CompareTo(TimelineCameraShakeByCurveClip other)
	{
		return NormalizedBegin.CompareTo(other.NormalizedBegin);
	}
}
