using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ClawColliderPoint : IDataToBake
{
	public Type colliderType;

	public Vector3 center;

	public Vector3 size;

	public float radius;

	public void Bake(object baker)
	{
	}
}
