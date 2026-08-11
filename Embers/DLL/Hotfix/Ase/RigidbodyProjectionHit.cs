using UnityEngine;

namespace Ase;

public struct RigidbodyProjectionHit
{
	public Rigidbody Rigidbody;

	public Vector3 HitPoint;

	public Vector3 EffectiveHitNormal;

	public Vector3 HitVelocity;

	public bool StableOnHit;
}
