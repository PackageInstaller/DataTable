using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

[Name("获取和目标的碰撞距离", 0)]
[Category("✫ DragonLost/Collider")]
[Description("获取和目标的碰撞距离")]
public class GetNearestCollider : ActionTaskBase
{
	[Name("目标ID", 0)]
	public BBParameter<int> TargetEntityId;

	[Name("碰撞距离", 0)]
	public BBParameter<float> Distance;

	[Name("受击盒等级", 0)]
	public BBParameter<int> SiteLevel;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (TargetEntityId == null)
		{
			EndAction();
			return;
		}
		if (Distance == null)
		{
			EndAction();
			return;
		}
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(TargetEntityId.value);
		if (entity == null)
		{
			EndAction();
			return;
		}
		LogicEntityCollisionComponent component = ownerEntity.GetComponent<LogicEntityCollisionComponent>();
		LogicEntityCollisionComponent component2 = entity.GetComponent<LogicEntityCollisionComponent>();
		if (component == null || component2 == null)
		{
			EndAction();
			return;
		}
		float colliderNearestDistance = component2.GetColliderNearestDistance(component.BodyCollider);
		Distance.value = colliderNearestDistance;
		Vector3 position = ownerEntity.transform.position;
		HitColliderVariableData hitColliderVariableData = entity.GetComponent<HitColliderComponent>()?.GetClosedPartHitData(position);
		if (hitColliderVariableData != null)
		{
			SiteLevel.value = hitColliderVariableData.SiteLevel;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取和目标的最近的碰撞距离 ：{colliderNearestDistance}", ownerEntity);
		}
		EndAction();
	}
}
