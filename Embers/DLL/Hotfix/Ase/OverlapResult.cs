using UnityEngine;

namespace Ase;

public struct OverlapResult(Vector3 normal, Collider collider)
{
	public Vector3 Normal = normal;

	public Collider Collider = collider;
}
