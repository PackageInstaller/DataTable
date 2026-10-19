namespace UnityEngine;

public struct BoundingSphere(Vector3 pos, float rad)
{
	public Vector3 position = pos;

	public float radius = rad;
}
