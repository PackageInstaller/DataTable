using System;
using Config;
using UnityEngine;

[Serializable]
public class EarlyWarningClip : IComparable<EarlyWarningClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public int Key;

	public float NormalizedBegin;

	public float NormalizedEnd;

	public float Length;

	public int Level;

	public RangeType RangeType;

	public string WarningPrefabPath = string.Empty;

	public Vector3 Offset = Vector3.zero;

	public Vector3 Rotation = Vector3.zero;

	public Vector3 Scale = Vector3.one;

	public int Angle;

	public float StartValue;

	public float ValidValue;

	public float InnerRadius;

	public bool IsAttach;

	public bool IsInward;

	public int CompareTo(EarlyWarningClip other)
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
