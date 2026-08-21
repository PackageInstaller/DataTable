using UnityEngine;

namespace Ase;

public struct CharacterTransientGroundingReport
{
	public bool FoundAnyGround;

	public bool IsStableOnGround;

	public bool SnappingPrevented;

	public Vector3 GroundNormal;

	public Vector3 InnerGroundNormal;

	public Vector3 OuterGroundNormal;

	public Collider GourndCollider;

	public Vector3 GroundPoint;

	public bool Teleport;

	public void CopyFrom(CharacterGroundingReport groundingReport)
	{
		FoundAnyGround = groundingReport.FoundAnyGround;
		IsStableOnGround = groundingReport.IsStableOnGround;
		SnappingPrevented = groundingReport.SnappingPrevented;
		GroundNormal = groundingReport.GroundNormal;
		InnerGroundNormal = groundingReport.InnerGroundNormal;
		OuterGroundNormal = groundingReport.OuterGroundNormal;
		GourndCollider = groundingReport.GroundCollider;
		GroundPoint = groundingReport.GroundPoint;
	}
}
