using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public struct TargetBounds
{
	[HideInInspector]
	public Bounds bounds;

	public Vector3 localEulerAngle;

	[Tooltip("受击点（相对于角色原点的偏移）")]
	public Vector3 anchor;

	[Tooltip("挂点（bodyPart上的）")]
	public string attachPoint;

	public Vector3 center
	{
		get
		{
			return bounds.center;
		}
		set
		{
			bounds.center = value;
		}
	}

	public Vector3 size
	{
		get
		{
			return bounds.size;
		}
		set
		{
			bounds.size = value;
		}
	}
}
