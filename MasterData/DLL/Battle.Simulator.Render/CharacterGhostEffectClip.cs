using System;
using UnityEngine;

[Serializable]
public class CharacterGhostEffectClip : IComparable<CharacterGhostEffectClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public int GhostNumber;

	public bool AutoCreata;

	public float CreateInterval;

	public AnimationCurve IntensityCurve;

	public float CreateEndNormalized;

	public float[] CreatePointNormalizedArray;

	public int CompareTo(CharacterGhostEffectClip other)
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
