using UnityEngine;

namespace Ase;

public struct HitStabilityReport
{
	public bool IsStable;

	public bool FoundInnerNormal;

	public Vector3 InnerNormal;

	public bool FoundOuterNormal;

	public Vector3 OuterNormal;

	public bool ValidStepDetected;

	public Collider SteppedCollider;

	public bool LedgeDetected;

	public bool IsOnEmptySideOfLedge;

	public float DistanceFromLedge;

	public bool IsMovingTowardsEmptySideOfLedge;

	public Vector3 LedgeGroundNormal;

	public Vector3 LedgeRightDirection;

	public Vector3 LedgeFacingDirection;
}
