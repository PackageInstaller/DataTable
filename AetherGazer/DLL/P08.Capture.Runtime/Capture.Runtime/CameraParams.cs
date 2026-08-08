using System;
using UnityEngine;

namespace Capture.Runtime;

[Serializable]
public struct CameraParams
{
	[SerializeField]
	public Vector3 pos;

	[SerializeField]
	public Vector3 rot;

	[SerializeField]
	public float minCameraY;

	[SerializeField]
	public float maxCameraY;

	[SerializeField]
	public bool limitMaxY;

	[SerializeField]
	public float minCameraX;

	[SerializeField]
	public bool limitMinX;

	[SerializeField]
	public float maxCameraX;

	[SerializeField]
	public bool limitMaxX;

	[SerializeField]
	public Vector2 singleLimitYVlaue;

	[SerializeField]
	public Vector2 singleLimitXVlaue;

	[SerializeField]
	public bool singleLimitY;

	[SerializeField]
	public bool singleLimitX;
}
