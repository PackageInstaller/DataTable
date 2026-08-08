using System;
using UnityEngine;

[Serializable]
public class RadialBlurClip : IComparable<RadialBlurClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public AnimationCurve ScaleCurve;

	public AnimationCurve RangeCurve;

	public AnimationCurve SoftCurve;

	public bool IsOutward;

	public AnimationCurve WarpLerp;

	public AnimationCurve WarpScale;

	public AnimationCurve WarpDensity;

	public AnimationCurve AbberationIntensity;

	public Vector2 CenterTransform;

	public bool IsUseCenterTransform;

	public bool RadialDither;

	public string CenterPath;

	public int Priority;

	public bool BotherOthers;

	public int Key;

	public int CompareTo(RadialBlurClip other)
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
