using TrueSync;

public struct DeterministicRaycastHit
{
	public bool isValid;

	public TSVector2 point;

	public TSVector2 normal;

	public DeterministicCollider collider;

	public FP distance;
}
