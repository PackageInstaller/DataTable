using System;
using UnityEngine;

[Serializable]
public class CameraRotateClip : IComparable<CameraRotateClip>, IEquatable<CameraRotateClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public int Key;

	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public int priority;

	public float SlowActionTime;

	public float StartSlowActionTime;

	public bool botherOthers;

	public AnimationCurve curveX;

	public AnimationCurve curveY;

	public AnimationCurve curveZ;

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

	public int CompareTo(CameraRotateClip pOther)
	{
		return NormalizedBegin.CompareTo(pOther.NormalizedBegin);
	}

	public bool Equals(CameraRotateClip pOther)
	{
		return pOther.Key == Key;
	}
}
