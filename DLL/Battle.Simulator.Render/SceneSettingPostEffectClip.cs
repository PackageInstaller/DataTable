using System;
using UnityEngine;

[Serializable]
public class SceneSettingPostEffectClip : IComparable<SceneSettingPostEffectClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public int Key;

	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public AnimationCurve ExposureCurve;

	public AnimationCurve ContrastCurve;

	public bool Invert = true;

	public AnimationCurve GraynessCurve;

	public AnimationCurve DarknessCurve;

	public bool EffectWhileNotLocalPlayer;

	public int CompareTo(SceneSettingPostEffectClip other)
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
