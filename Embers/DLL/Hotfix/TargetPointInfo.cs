using System;
using UnityEngine;

[Serializable]
public struct TargetPointInfo(Transform targetPoint, float stayTime)
{
	public Transform targetPoint = targetPoint;

	public float stayTime = stayTime;
}
