using System;
using UnityEngine;

[Serializable]
public class CharacterEmissionLightEffectClip : IComparable<CharacterEmissionLightEffectClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public Color Color;

	public AnimationCurve AnimationCurve;

	public string PartPath;

	public bool DisableOnExit = true;

	public int CompareTo(CharacterEmissionLightEffectClip other)
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
