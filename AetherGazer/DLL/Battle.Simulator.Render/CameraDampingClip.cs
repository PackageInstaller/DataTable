using System;
using UnityEngine;

[Serializable]
public class CameraDampingClip : IComparable<CameraDampingClip>, IEquatable<CameraDampingClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public int Key;

	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public int priority;

	public bool botherOthers;

	public AnimationCurve Damping;

	public AnimationCurve LookatDamping;

	public AnimationCurve LookatDisWithFollow;

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

	public int CompareTo(CameraDampingClip pOther)
	{
		return NormalizedBegin.CompareTo(pOther.NormalizedBegin);
	}

	public bool Equals(CameraDampingClip pOther)
	{
		return pOther.Key == Key;
	}
}
