using MagicaCloth2;
using UnityEngine;

namespace T0World;

public struct T0CaptureDitherData
{
	public Transform obbTrs;

	public float colRadius;

	public float colHeight;

	public Vector3 colCenter;

	public T0CaptureDitherData(MagicaCapsuleCollider col)
	{
		obbTrs = col.transform;
		Vector3 size = col.GetSize();
		colRadius = size.x;
		colHeight = size.z;
		colCenter = col.center;
	}
}
