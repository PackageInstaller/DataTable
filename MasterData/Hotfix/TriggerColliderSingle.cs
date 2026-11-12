using UnityEngine;

[RequireComponent(typeof(DeterministicCollider))]
[RequireComponent(typeof(TrueSyncTransform))]
public class TriggerColliderSingle : LogicEntity
{
	public void Register(IDeterministicCollisionListener listener)
	{
		Collider collider = GetComponent<Collider>();
		DeterministicCollider dtCollider = null;
		this.SetDeterministicCollider(ref collider, ref dtCollider);
		dtCollider.collisionListener = listener;
		dtCollider.layer = 10;
		dtCollider.priority = 4;
		dtCollider.IgnoreCollision = false;
		dtCollider.ActiveSelf = true;
	}

	public void UnRegister()
	{
		Collider collider = GetComponent<Collider>();
		DeterministicCollider dtCollider = null;
		this.SetDeterministicCollider(ref collider, ref dtCollider);
		dtCollider.collisionListener = null;
		dtCollider.layer = 10;
		dtCollider.priority = 4;
		dtCollider.IgnoreCollision = false;
		dtCollider.ActiveSelf = false;
	}
}
