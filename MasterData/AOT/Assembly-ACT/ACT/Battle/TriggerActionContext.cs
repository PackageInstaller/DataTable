using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public readonly struct TriggerActionContext
{
	public Entity Entity { get; }

	public GameObject TargetObject { get; }

	public Collider Collider { get; }

	public bool HasEntity => Entity.IsValid;

	public TriggerActionContext(Entity entity, GameObject targetObject, Collider collider)
	{
		Entity = entity;
		TargetObject = targetObject;
		Collider = collider;
	}
}
