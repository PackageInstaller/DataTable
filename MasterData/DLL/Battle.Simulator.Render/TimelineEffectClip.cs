using System;
using UnityEngine;

[Serializable]
public struct TimelineEffectClip : IComparable<TimelineEffectClip>
{
	public Vector3 offset;

	public Vector3 rotation;

	public Vector3 scale;

	public bool isAttach;

	public bool isLockRotaion;

	public float begin;

	public float normalizedEnd;

	public float duration;

	public string handPoint;

	public string effectPath;

	public EffectCondition condition;

	public string conditionEffectPath;

	public bool IsCameraEffect;

	public Vector2 AspectRate;

	public float FieldOfView;

	public bool IsMainCameraEffect;

	public bool IsFollowCameraEffect;

	public bool botherOthers;

	public bool destoryOnTimelineClean;

	public float playTimeScale;

	public int CompareTo(TimelineEffectClip other)
	{
		return begin.CompareTo(other.begin);
	}
}
