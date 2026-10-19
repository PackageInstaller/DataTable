using System;
using Cinemachine;
using UnityEngine;

namespace ACT.World.Behave;

[Serializable]
public struct CamMovementBehaveData
{
	[HideInInspector]
	public CinemachinePath.Waypoint[] Waypoints;

	public float waitTime;

	public float startTime;

	public float[] pathSpeed;

	public float[] pathPointTime;

	[HideInInspector]
	public int priority;

	[HideInInspector]
	public Quaternion[] pathPointRotation;

	public float endTime;
}
