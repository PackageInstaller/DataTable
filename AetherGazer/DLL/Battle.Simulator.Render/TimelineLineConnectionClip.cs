using System;
using UnityEngine;

[Serializable]
public struct TimelineLineConnectionClip : IComparable<TimelineLineConnectionClip>
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public string effectPath;

	public string handPoint;

	public Vector3 startOffset;

	public Vector3 rotation;

	public Vector3 endOffset;

	public bool isCurve;

	public int lerpPointNumber;

	public float shakeSpeed;

	public float period;

	public float noiseFactor;

	public int CompareTo(TimelineLineConnectionClip other)
	{
		return NormalizedBegin.CompareTo(other.NormalizedBegin);
	}
}
