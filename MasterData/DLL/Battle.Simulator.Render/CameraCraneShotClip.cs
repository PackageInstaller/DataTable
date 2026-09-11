using System;
using UnityEngine;

[Serializable]
public class CameraCraneShotClip : IComparable<CameraCraneShotClip>, IEquatable<CameraCraneShotClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public int Key;

	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public int priority;

	public float SlowActionTime;

	public float StartSlowActionTime;

	public bool botherOthers;

	public AnimationCurve CaraneShotCurve;

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

	public int CompareTo(CameraCraneShotClip pOther)
	{
		return NormalizedBegin.CompareTo(pOther.NormalizedBegin);
	}

	public bool Equals(CameraCraneShotClip pOther)
	{
		return pOther.Key == Key;
	}

	public override bool Equals(object pObj)
	{
		if (pObj == null || GetType() != pObj.GetType())
		{
			return false;
		}
		CameraCraneShotClip pOther = pObj as CameraCraneShotClip;
		return Equals(pOther);
	}

	public override int GetHashCode()
	{
		return Key;
	}

	public static bool operator ==(CameraCraneShotClip pClip1, CameraCraneShotClip pClip2)
	{
		if ((object)pClip1 == null && (object)pClip2 == null)
		{
			return true;
		}
		if ((object)pClip1 == null || (object)pClip2 == null)
		{
			return false;
		}
		return pClip1.Equals(pClip2);
	}

	public static bool operator !=(CameraCraneShotClip pClip1, CameraCraneShotClip pClip2)
	{
		return !(pClip1 == pClip2);
	}
}
