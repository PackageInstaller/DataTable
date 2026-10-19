using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class SphereColliderParameters : IDataToBake
{
	public Vector3 center;

	public float radius;

	public string name;

	public void CopyTo(SphereCollider sphereCollider)
	{
		sphereCollider.center = center;
		sphereCollider.radius = radius;
		sphereCollider.name = name;
	}
}
