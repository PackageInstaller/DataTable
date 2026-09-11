using UnityEngine;

public class QWCapsuleDevice : QWColliderZoneDevice
{
	public float height;

	public float radius;

	protected override void GetOverlapCollider(Collider[] overlapColliders)
	{
		Vector3 position = base.transform.position;
		Vector3 vector = base.transform.up * ((height - radius * 2f) / 2f);
		Vector3 point = position + vector;
		Vector3 point2 = position - vector;
		Physics.OverlapCapsuleNonAlloc(point, point2, radius, overlapColliders, QWorldHelper.CharacterMask);
	}
}
