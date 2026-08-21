using UnityEngine;

public class QWVolumeDevice : QWColliderZoneDevice
{
	public Vector3 volumeSize;

	protected override void GetOverlapCollider(Collider[] overlapColliders)
	{
		Physics.OverlapBoxNonAlloc(base.transform.position, volumeSize / 2f, overlapColliders, base.transform.rotation, QWorldHelper.CharacterMask);
	}
}
