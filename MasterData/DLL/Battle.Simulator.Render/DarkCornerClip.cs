using System;
using UnityEngine;

[Serializable]
public class DarkCornerClip : IComparable<DarkCornerClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public Color color;

	public AnimationCurve strengthCurve;

	public AnimationCurve softCurve;

	public bool bounded;

	public bool isUseScreenPos;

	public string transPath;

	public Vector2 screenPos;

	public int priority;

	public int Key;

	public int CompareTo(DarkCornerClip other)
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
