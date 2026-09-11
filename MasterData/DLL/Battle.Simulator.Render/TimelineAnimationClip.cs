using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public struct TimelineAnimationClip : IComparable<TimelineAnimationClip>
{
	public float begin;

	public float duration;

	public float easeInDuration;

	public float recover;

	public string clip;

	public List<Vector3> offset;

	public int layerIndex;

	public int CompareTo(TimelineAnimationClip other)
	{
		return begin.CompareTo(other.begin);
	}
}
