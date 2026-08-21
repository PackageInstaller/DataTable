using System;

namespace Ase.ECS;

public class WorldEntity : BaseEntity
{
	public override void OnInit(object data = null)
	{
		EntityCreateData entityCreateData = (EntityCreateData)data;
		mId = entityCreateData.id;
		mEntityId = entityCreateData.entityId;
		parent = entityCreateData.parent;
		world = entityCreateData.world;
		entityObject = entityCreateData.entityData.entityObject;
		callbacks = entityCreateData.entityData.callbacks;
		entityData = entityCreateData.entityData;
		collisionLayer = entityCreateData.entityData.collisionLayer;
		collisionMass = entityCreateData.entityData.collisionMass;
		logicType = entityCreateData.entityData.logicType;
		userData = entityCreateData.entityData.userData;
		updateType = entityCreateData.entityData.updateType;
		CampType = entityCreateData.entityData.campType;
		lTransform = LTransform.Create(entityCreateData.entityData.pointData);
		tick = world.Tick;
	}

	protected override Type[] GetEntityComps()
	{
		return null;
	}

	public override Type GetEntityView()
	{
		return typeof(WorldEntityView);
	}

	public override EntityType GetEntityType()
	{
		return EntityType.INTERACTIVE;
	}

	public override CampType GetEntityCampType()
	{
		return CampType.HostilePlayer;
	}

	public float GetDamage()
	{
		return 400f;
	}
}
