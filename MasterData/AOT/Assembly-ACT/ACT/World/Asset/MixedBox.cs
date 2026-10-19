using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MixedBox : IDataToBake
{
	public Vector3 center;

	public Vector3 size;

	public string name;

	public Vector3 localPos;

	public Quaternion localRot;

	public Vector3 localScale;

	public void CopyTo(BoxCollider boxCollider, Transform transform)
	{
		boxCollider.center = center;
		boxCollider.size = size;
		boxCollider.name = name;
		transform.localPosition = localPos;
		transform.localRotation = localRot;
		transform.localScale = localScale;
	}
}
