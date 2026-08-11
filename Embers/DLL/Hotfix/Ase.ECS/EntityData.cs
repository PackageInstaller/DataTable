using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class EntityData : IReference
{
	public EntityPositionData pointData;

	public EntityCallbacks callbacks;

	public GameObject entityObject;

	public BaseEntity parent;

	public EntityUpdateType updateType;

	public EntityLogicType logicType;

	public CollisionSetting.CollisionLayer collisionLayer;

	public CampType campType;

	public int collisionMass;

	public object userData;

	public object userDataPam;

	public bool isDeadReleaseEffect;

	public bool currentTickCreate;

	public static EntityData Create()
	{
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.updateType = EntityUpdateType.Local;
		entityData.logicType = EntityLogicType.None;
		entityData.pointData = EntityPositionData.Create();
		entityData.collisionMass = 2;
		return entityData;
	}

	public static EntityData Create(Vector3 position, GameObject obj, CollisionSetting.CollisionLayer layer, object userData = null)
	{
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.updateType = EntityUpdateType.Local;
		entityData.logicType = EntityLogicType.None;
		entityData.pointData = EntityPositionData.Create(position);
		entityData.entityObject = obj;
		entityData.collisionLayer = layer;
		entityData.collisionMass = 2;
		entityData.userData = userData;
		return entityData;
	}

	public static EntityData Create(Vector3 position, Vector3 rotation, GameObject obj, CollisionSetting.CollisionLayer layer, object userData = null)
	{
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.updateType = EntityUpdateType.Local;
		entityData.logicType = EntityLogicType.None;
		entityData.pointData = EntityPositionData.Create(position, rotation);
		entityData.entityObject = obj;
		entityData.collisionLayer = layer;
		entityData.collisionMass = 2;
		entityData.userData = userData;
		return entityData;
	}

	public static EntityData Create(Vector3 position, Vector3 rotation, GameObject obj, EntityUpdateType entityUpdateType, EntityLogicType entityLogicType, CollisionSetting.CollisionLayer layer, object userData = null)
	{
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.updateType = entityUpdateType;
		entityData.logicType = entityLogicType;
		entityData.pointData = EntityPositionData.Create(position, rotation);
		entityData.entityObject = obj;
		entityData.collisionLayer = layer;
		entityData.collisionMass = 2;
		entityData.userData = userData;
		return entityData;
	}

	public static EntityData Create(Vector3 position, Vector3 rotation, Vector3 scale, GameObject obj, CollisionSetting.CollisionLayer layer, object userData = null)
	{
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.updateType = EntityUpdateType.Local;
		entityData.logicType = EntityLogicType.None;
		entityData.pointData = EntityPositionData.Create(position, rotation, scale);
		entityData.entityObject = obj;
		entityData.collisionLayer = layer;
		entityData.collisionMass = 2;
		entityData.userData = userData;
		return entityData;
	}

	public EntityData Clone()
	{
		EntityData entityData = ReferencePool.Acquire<EntityData>();
		entityData.pointData = pointData.Clone();
		entityData.callbacks = callbacks;
		entityData.entityObject = entityObject;
		entityData.parent = parent;
		entityData.updateType = updateType;
		entityData.collisionMass = collisionMass;
		entityData.userData = userData;
		entityData.isDeadReleaseEffect = isDeadReleaseEffect;
		entityData.currentTickCreate = currentTickCreate;
		return entityData;
	}

	public void Clear()
	{
		entityObject = null;
		callbacks = null;
		if (pointData != null)
		{
			ReferencePool.Release(pointData);
			pointData = null;
		}
		parent = null;
		userData = null;
		userDataPam = null;
		updateType = EntityUpdateType.Local;
		logicType = EntityLogicType.None;
		collisionLayer = CollisionSetting.CollisionLayer.None;
		campType = CampType.Unknown;
		collisionMass = 0;
		isDeadReleaseEffect = false;
		currentTickCreate = false;
	}
}
