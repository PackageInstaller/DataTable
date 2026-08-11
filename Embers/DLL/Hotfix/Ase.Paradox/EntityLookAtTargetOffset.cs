using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("朝向目标或坐标（带偏移）", 0)]
[Description("使实体朝向指定目标或坐标（带偏移）。")]
[Category("✫ DragonLost/Transform")]
public class EntityLookAtTargetOffset : ActionTaskBase
{
	[Name("最大旋转时间", 0)]
	[Description("旋转的最大持续时间。")]
	public BBParameter<float> duration;

	[Name("旋转完成结束", 0)]
	[Description("指示是否在旋转完成时立即结束动作。")]
	public bool finishImmediatelyEnd;

	[Name("是否立即完成", 0)]
	[Description("指示是否立即将实体朝向目标或坐标。")]
	public bool IsImmediatelyRotate;

	[Name("追踪实体", 0)]
	[Description("指示是否追踪指定的实体。")]
	public bool lookAtEntity;

	private EntityRotationComponent rotateComponent;

	[RequiredField]
	[ShowIf("lookAtEntity", 1)]
	[Name("目标单位", 0)]
	[Description("要朝向的目标实体的ID。")]
	public BBParameter<int> targetId;

	[Name("目标坐标", 0)]
	[ShowIf("lookAtEntity", 0)]
	[Description("要朝向的目标坐标。")]
	public BBParameter<Vector3> targetPosition;

	[Name("偏移角度", 0)]
	public BBParameter<float> angleOffset;

	[Name("等待转向完成", 0)]
	[Description("指示是否等待转向完成。")]
	public bool waitUntilFinish;

	protected override void OnExecute()
	{
		base.OnExecute();
		rotateComponent = ownerEntity.GetComponent<EntityRotationComponent>();
		if (rotateComponent == null)
		{
			OnActionFinish();
			return;
		}
		if (IsImmediatelyRotate)
		{
			if (lookAtEntity)
			{
				BaseEntity entity = GetEntity(targetId.value, isSyncEntity: true);
				if (entity == null)
				{
					OnActionFinish();
					return;
				}
				rotateComponent.ImmediatelyRotate(entity.transform.position, angleOffset.value);
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance?.WriteAuthorityEntityId($"朝向目标或坐标  targetEntity.transform.position {entity.transform.position}", ownerEntity);
				}
			}
			else
			{
				rotateComponent.ImmediatelyRotate(targetPosition.value, angleOffset.value);
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance?.WriteAuthorityEntityId($"targetPosition.value  {targetPosition.value}", ownerEntity);
				}
			}
			OnActionFinish();
			return;
		}
		if (lookAtEntity)
		{
			BaseEntity entity2 = GetEntity(targetId.value, isSyncEntity: true);
			if (entity2 == null)
			{
				OnActionFail();
				return;
			}
			rotateComponent.SetTargetOffset(entity2, duration.value, finishImmediatelyEnd, angleOffset.value);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"朝向目标或坐标 {entity2.Id} duration  {duration.value}  finishImmediatelyEnd {finishImmediatelyEnd}", ownerEntity);
			}
		}
		else
		{
			rotateComponent.SetTargetOffset(targetPosition.value, duration.value, finishImmediatelyEnd, angleOffset.value);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"朝向目标或坐标   targetPosition.value  {targetPosition.value} " + $"duration.value  {duration.value} " + $"finishImmediatelyEnd  {finishImmediatelyEnd}", ownerEntity);
			}
		}
		if (!waitUntilFinish)
		{
			OnActionFinish();
		}
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		if (!waitUntilFinish || IsImmediatelyRotate)
		{
			return;
		}
		if (rotateComponent != null)
		{
			if (rotateComponent.RotationFinish)
			{
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance?.WriteAuthorityEntityId("朝向目标或坐标   结束", ownerEntity);
				}
				OnActionFinish();
			}
		}
		else
		{
			OnActionFail();
		}
	}
}
