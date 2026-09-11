using System;
using UnityEngine;

[Serializable]
public class FlashActionClip : IComparable<FlashActionClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public AnimationCurve Curve;

	public bool IsCustomFillColor;

	public Color FillOuter;

	public Color FillInner;

	public float FillSoft;

	public int CompareTo(FlashActionClip other)
	{
		return NormalizedBegin.CompareTo(other.NormalizedBegin);
	}

	public float GetBeginNormalized()
	{
		return NormalizedBegin;
	}

	public float GetLength()
	{
		return Length;
	}

	public float GetEndNormalized()
	{
		return NormalizedEnd;
	}
}
