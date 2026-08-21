using System;
using UnityEngine;

[Serializable]
public class SceneSettingFogClip : IComparable<SceneSettingFogClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public bool OnlyHit;

	public bool IsGlobalEffect;

	public int Key;

	public Color DynamicFogColor;

	public AnimationCurve DynamicFogIntensityCurve;

	public Color TintColor;

	public int CompareTo(SceneSettingFogClip other)
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
