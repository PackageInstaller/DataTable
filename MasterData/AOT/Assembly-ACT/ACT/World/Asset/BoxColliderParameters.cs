using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BoxColliderParameters : IDataToBake
{
	public Vector3 center;

	public Vector3 size;

	public string name;

	public void CopyTo(BoxCollider boxCollider)
	{
		boxCollider.center = center;
		boxCollider.size = size;
		boxCollider.name = name;
	}
}
