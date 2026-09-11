using System;
using UnityEngine;

[Serializable]
public class CharacterDissolveBossEffectActionClip : IComparable<CharacterDissolveBossEffectActionClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public AnimationCurve Curve;

	public string PartPath;

	public bool DisableOnExit = true;

	public int CompareTo(CharacterDissolveBossEffectActionClip other)
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
