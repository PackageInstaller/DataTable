using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.Battle.Configs;

[Serializable]
public struct TargetSectorBounds
{
	[FormerlySerializedAs("sectorSize")]
	public int sectorAngle;

	public bool AccuracyCheck;

	[HideInInspector]
	public Vector3 physicBoundSize;

	[HideInInspector]
	public Vector3 physicBoundCenter;

	[HideInInspector]
	public Quaternion physicBoundRotation;

	[FormerlySerializedAs("hittedGeometryPoints")]
	[HideInInspector]
	public List<Vector3> debugGeometryPoints;

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

	public int radius
	{
		get
		{
			return (int)(bounds.size.y * 0.5f);
		}
		set
		{
			bounds.size = new Vector3(bounds.size.x, value * 2, value * 2);
		}
	}

	public int height
	{
		get
		{
			return (int)bounds.size.x;
		}
		set
		{
			bounds.size = new Vector3(value, bounds.size.y, bounds.size.z);
		}
	}

	public void UpdatePhysicCollideInfo((Vector3, Vector3, Quaternion) result)
	{
		(physicBoundCenter, physicBoundSize, physicBoundRotation) = result;
	}

	public Bounds GetSectorBounds()
	{
		Vector3 size = bounds.size;
		float num = size.y * 0.5f;
		Vector3 size2 = size;
		float num2 = (float)sectorAngle * 0.5f;
		if (num2 <= 90f)
		{
			size2.z = Mathf.Sin(MathF.PI / 180f * num2) * num * 2f;
			size2.y = num;
		}
		else
		{
			num2 -= 90f;
			size2.z = num * 2f;
			size2.y = Mathf.Sin(MathF.PI / 180f * num2) * num + num;
		}
		return new Bounds
		{
			center = new Vector3(0f, (size.y - size2.y) * 0.5f, 0f),
			size = size2
		};
	}
}
