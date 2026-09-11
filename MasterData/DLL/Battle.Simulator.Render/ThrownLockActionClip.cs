using System;
using UnityEngine;

[Serializable]
public class ThrownLockActionClip : IComparable<ThrownLockActionClip>
{
	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public string EffectPath;

	public Vector3 EffectScale = Vector3.one;

	public float EffectLiveTime = 1f;

	public int StartChangeHeightTime;

	public int CompareTo(ThrownLockActionClip other)
	{
		return NormalizedBegin.CompareTo(other.NormalizedBegin);
	}
}
