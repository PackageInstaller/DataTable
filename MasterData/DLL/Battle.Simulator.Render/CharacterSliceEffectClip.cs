using System;
using UnityEngine;

[Serializable]
public class CharacterSliceEffectClip : IComparable<CharacterSliceEffectClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public float Offset;

	public AnimationCurve OffsetCurve;

	public float Range = 1f;

	public AnimationCurve RangeCurve;

	public float Density = 10f;

	public AnimationCurve DensityCurve;

	public float Speed = 1f;

	public AnimationCurve SpeedCurve;

	public int CompareTo(CharacterSliceEffectClip other)
	{
		return NormalizedBegin.CompareTo(other.NormalizedBegin);
	}

	public float GetBeginNormalized()
	{
		return NormalizedBegin;
	}

	public float GetEndNormalized()
	{
		return NormalizedEnd;
	}

	public float GetLength()
	{
		return Length;
	}
}
