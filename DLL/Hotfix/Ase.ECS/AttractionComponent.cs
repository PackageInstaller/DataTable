using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

public class AttractionComponent : BaseComponent
{
	private KinematicMoveComponent moveComponent;

	private Vector2 stopAngle = new Vector2(-180f, 180f);

	private Dictionary<int, Vector3> entityAttractionDic = new Dictionary<int, Vector3>();

	public override void OnStart(object data = null)
	{
		moveComponent = mBaseEntity.GetComponent<KinematicMoveComponent>();
	}

	public void ExecuteAttraction(BaseEntity entity, Vector3 add)
	{
		if (entityAttractionDic.TryGetValue(entity.Id, out var value))
		{
			entityAttractionDic[entity.Id] = value + add;
		}
		else
		{
			entityAttractionDic.Add(entity.Id, add);
		}
	}

	private Vector3 GetAttraction()
	{
		Vector3 zero = Vector3.zero;
		float property = mBaseEntity.GetProperty("AttractionResistance");
		float property2 = mBaseEntity.GetProperty("AttractionMultiplier");
		foreach (KeyValuePair<int, Vector3> item in entityAttractionDic)
		{
			BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(item.Key);
			if (entity != null && !(entity.GetProperty("AttractionResistance") <= property))
			{
				float property3 = entity.GetProperty("AttractionPower");
				Vector3 vector = property2 * property3 * item.Value;
				zero += vector;
			}
		}
		entityAttractionDic.Clear();
		return zero;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (!mBaseEntity.IsSurvival || moveComponent == null)
		{
			return;
		}
		Vector3 attraction = GetAttraction();
		if (attraction == Vector3.zero)
		{
			return;
		}
		attraction *= deltaTime;
		if (moveComponent.CheckMovementCollision(1f, attraction.normalized, out var raycastHit))
		{
			Vector3 vector = ((RaycastHit)(ref raycastHit)).transform.position - base.transform.position;
			vector.y = 0f;
			float num = Vector3.SignedAngle(vector, base.transform.rotation * Vector3.forward, Vector3.up);
			if (num > stopAngle.x && num < stopAngle.y)
			{
				return;
			}
		}
		moveComponent.StackedMovePosition(attraction, "AttractionComponent");
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"Attraction : {attraction}", mBaseEntity);
		}
	}

	public override void OnDispose()
	{
		moveComponent = null;
		entityAttractionDic.Clear();
		base.OnDispose();
	}
}
