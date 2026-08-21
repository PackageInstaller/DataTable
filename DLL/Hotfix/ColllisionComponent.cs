using System.Collections.Generic;
using Ase;
using Ase.ECS;
using UnityEngine;

public abstract class ColllisionComponent : BaseComponent
{
	protected EntityCollisionLayer collisionLayer;

	protected GameObject PhysicsGo;

	protected KinematicMoveComponent KinematicComponent;

	protected BaseLogicCollider LogicBodyCollider;

	protected List<BaseLogicCollider> LogicOtherCollider;

	public BaseLogicCollider BodyCollider => LogicBodyCollider;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		if (mBaseEntity.IsSyncPhysicsEntity)
		{
			LogicOtherCollider = new List<BaseLogicCollider>();
			PhysicsGo = mBaseEntity.GetComponent<TransformComponent>().VGameObject;
			collisionLayer = PhysicsGo.GetOrAddComponent<EntityCollisionLayer>();
			KinematicComponent = mBaseEntity.GetComponent<KinematicMoveComponent>();
			ClearCollisionData();
			InitCollisionData();
			CapsuleCollider val = InitBodyCollision();
			collisionLayer.body = val;
			KinematicComponent.RegisterBodyCollider(val);
			InitOtherCollision(collisionLayer);
			collisionLayer.Layer = GetData<CollisionSetting.CollisionLayer>("CollisionLayer");
			collisionLayer.Mass = GetData<int>("CollisionMass");
			KinematicComponent.RegisterCollisionLayer(collisionLayer);
			if ((mBaseEntity.GetEntityType() == EntityType.HERO || mBaseEntity.GetEntityType() == EntityType.MONSTER || mBaseEntity.GetEntityType() == EntityType.INTERACTIVE) && mBaseEntity.GetWorld().IsStoryWorld)
			{
				Rigidbody orAddComponent = PhysicsGo.GetOrAddComponent<Rigidbody>();
				orAddComponent.useGravity = false;
				orAddComponent.constraints = (RigidbodyConstraints)126;
			}
		}
	}

	private void ClearCollisionData()
	{
		EntityViewComponent component = mBaseEntity.GetComponent<EntityViewComponent>();
		if (component == null || component.Transform == null)
		{
			return;
		}
		if (component.Transform.TryGetComponent<EntityCollisionLayer>(out var component2) && (bool)(Object)(object)component2.body)
		{
			((Collider)component2.body).enabled = false;
		}
		if (!(component2 != null) || component2.others.Count <= 0)
		{
			return;
		}
		foreach (Collider other in component2.others)
		{
			other.enabled = false;
		}
	}

	public CapsuleCollider GetBodyCollider()
	{
		return collisionLayer.body;
	}

	protected abstract void InitCollisionData();

	protected abstract CapsuleCollider InitBodyCollision();

	protected abstract void InitOtherCollision(EntityCollisionLayer collisionLayer);

	public void SetColliderEnable(int[] indexs, bool enable)
	{
		if (collisionLayer == null || collisionLayer.others == null || indexs.IsNullOrEmpty())
		{
			return;
		}
		for (int i = 0; i < indexs.Length; i++)
		{
			if (collisionLayer.others.Count > indexs[i])
			{
				collisionLayer.others[indexs[i]].enabled = enable;
			}
		}
	}
}
