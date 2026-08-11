using UnityEngine;

namespace Ase.ECS;

public struct PrimitiveInfo
{
	public PrimitiveShowInfo showInfo;

	public PrimitiveEnum Type;

	public Vector3 Center;

	public Quaternion Quaternion;

	public Vector3 BoxSize;

	public float Angle;

	public float Radius;

	public float InternalRadius;

	public float Height;
}
