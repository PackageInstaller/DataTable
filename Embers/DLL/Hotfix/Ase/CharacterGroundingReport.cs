using UnityEngine;

namespace Ase;

public struct CharacterGroundingReport
{
	public bool FoundAnyGround;

	public bool IsStableOnGround;

	public bool SnappingPrevented;

	public Vector3 GroundNormal;

	public Vector3 InnerGroundNormal;

	public Vector3 OuterGroundNormal;

	public Collider GroundCollider;

	public Vector3 GroundPoint;

	public void CopyFrom(CharacterTransientGroundingReport transientGroundingReport)
	{
		FoundAnyGround = transientGroundingReport.FoundAnyGround;
		IsStableOnGround = transientGroundingReport.IsStableOnGround;
		SnappingPrevented = transientGroundingReport.SnappingPrevented;
		GroundNormal = transientGroundingReport.GroundNormal;
		InnerGroundNormal = transientGroundingReport.InnerGroundNormal;
		OuterGroundNormal = transientGroundingReport.OuterGroundNormal;
		GroundCollider = null;
		GroundPoint = Vector3.zero;
	}
}
