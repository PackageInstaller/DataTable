using System;
using UnityEngine;

[Serializable]
public class CameraAbberationClip : IComparable<CameraAbberationClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public int Key;

	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public bool OnlyHit;

	public float AbberationIntensityValue = 1f;

	public AnimationCurve AbberationIntensityCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public int Priority;

	public bool BotherOthers;

	public int CompareTo(CameraAbberationClip other)
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
