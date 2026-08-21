using Ase.ECS;
using UnityEngine;

public class MonoEntityCollisionComponent : ColllisionComponent
{
	private EntityViewComponent _entityViewComponent;

	protected override void InitCollisionData()
	{
		_entityViewComponent = mBaseEntity.GetComponent<EntityViewComponent>();
	}

	protected override CapsuleCollider InitBodyCollision()
	{
		if (_entityViewComponent == null)
		{
			return null;
		}
		if (_entityViewComponent.Transform == null)
		{
			return null;
		}
		if (_entityViewComponent.Transform.TryGetComponent<EntityCollisionLayer>(out var component) && (bool)(Object)(object)component.body)
		{
			CapsuleCollider orAddComponent = PhysicsGo.GetOrAddComponent<CapsuleCollider>();
			orAddComponent.center = component.body.center;
			orAddComponent.radius = component.body.radius;
			orAddComponent.height = component.body.height;
			((Collider)orAddComponent).enabled = true;
			return orAddComponent;
		}
		return null;
	}

	protected override void InitOtherCollision(EntityCollisionLayer collisionLayer)
	{
		if (_entityViewComponent == null || _entityViewComponent.Transform == null || !_entityViewComponent.Transform.TryGetComponent<EntityCollisionLayer>(out var component) || component.others == null || component.others.Count <= 0)
		{
			return;
		}
		foreach (Collider other in component.others)
		{
			CapsuleCollider val = (CapsuleCollider)(object)((other is CapsuleCollider) ? other : null);
			if (val != null)
			{
				CapsuleCollider val2 = PhysicsGo.AddComponent<CapsuleCollider>();
				val2.center = val.center;
				val2.radius = val.radius;
				val2.height = val.height;
				((Collider)val2).enabled = true;
				collisionLayer.others.Add((Collider)(object)val2);
			}
			SphereCollider val3 = (SphereCollider)(object)((other is SphereCollider) ? other : null);
			if (val3 != null)
			{
				SphereCollider val4 = PhysicsGo.AddComponent<SphereCollider>();
				val4.center = val3.center;
				val4.radius = val3.radius;
				((Collider)val4).enabled = true;
				collisionLayer.others.Add((Collider)(object)val4);
			}
		}
	}
}
