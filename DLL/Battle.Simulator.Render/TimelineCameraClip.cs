using System;
using Cinemachine;
using UnityEngine;

[Serializable]
public struct TimelineCameraClip : IComparable<TimelineCameraClip>
{
	public float begin;

	public float end;

	public float duration;

	public bool shakeOnHit;

	public string cameraPath;

	public AnimationCurve curve;

	public E_TimelineCinemachineType type;

	public bool foreceShake;

	public float amplitude;

	public float frequency;

	public E_AdditionForwardType ForwardType;

	public float SwitchCameraNormalized;

	public int priority;

	public int key;

	public string noiseProfilePath;

	public int CompareTo(TimelineCameraClip other)
	{
		return begin.CompareTo(other.begin);
	}
}
