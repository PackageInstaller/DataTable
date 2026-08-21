using System;
using UnityEngine;

[Serializable]
public class HeroRaiseCameraNode
{
	public float fov;

	[Range(-180f, 180f)]
	public int dutch;

	public Vector3 pathOffset;

	public Vector3 TrackedObjectOffset;
}
