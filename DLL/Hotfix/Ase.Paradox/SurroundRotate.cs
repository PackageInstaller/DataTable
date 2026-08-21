#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("实体环绕旋转", 0)]
[Description("控制实体环绕旋转的行为")]
[Category("✫ DragonLost/Transform")]
public class SurroundRotate : ActionTaskBase
{
	public enum SurroundedType
	{
		Entity,
		FixedPoint
	}

	[ParadoxNotion.Design.Header("旋转")]
	[Name("- 启动环绕旋转", 0)]
	[Description("启动环绕旋转功能")]
	public bool useSurroundRotation = true;

	[RequiredField]
	[Name("被环绕物体类型", 0)]
	[Description("选择被环绕的物体类型")]
	[ShowIf("useSurroundRotation", 1)]
	[HideIf("useSurroundRotation", 0)]
	public SurroundedType surroundedType;

	[RequiredField]
	[Name("被环绕实体Id", 0)]
	[Description("被环绕的实体的ID")]
	[ShowIf("surroundedType", 0)]
	[HideIf("useSurroundRotation", 0)]
	public BBParameter<int> entityId;

	[RequiredField]
	[Name("固定点坐标", 0)]
	[Description("固定点的坐标")]
	[ShowIf("surroundedType", 1)]
	public BBParameter<Vector3> fixPoint;

	[ParadoxNotion.Design.Header("参数")]
	[Name("环绕时间", 0)]
	[Description("环绕旋转的持续时间")]
	public BBParameter<float> surroundRotateTime;

	[Name("环绕角速度", 0)]
	[Description("环绕旋转的角速度")]
	public BBParameter<float> surroundRotateAngularVelocity;

	[Name("是否等待完成", 0)]
	[Description("是否等待环绕旋转完成")]
	public bool waitUntilFinish;

	[Name("面朝中心", 0)]
	[Description("是否使实体面朝环绕中心")]
	public bool immediateLookAtTarget = true;

	private SurroundRotateComponent surroundComponent;

	private BaseEntity entity;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (!useSurroundRotation)
		{
			OnActionFail();
			return;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId("节点开启环绕旋转", ownerEntity);
		}
		surroundComponent = ownerEntity.GetComponent<SurroundRotateComponent>();
		if (surroundComponent == null)
		{
			OnActionFail();
			return;
		}
		entity = GetEntity(entityId.value, isSyncEntity: true);
		if (entity == null && surroundedType == SurroundedType.Entity)
		{
			LogActionError("获取实体");
			OnActionFinish();
			return;
		}
		switch (surroundedType)
		{
		case SurroundedType.Entity:
			surroundComponent.SetForecastingAngle(surroundRotateTime.value);
			surroundComponent.OpenSurroundEntity(entity, surroundRotateAngularVelocity.value, immediateLookAtTarget);
			surroundComponent.SetErrorFix(ownerEntity.transform.position, entity.transform.position);
			break;
		case SurroundedType.FixedPoint:
			surroundComponent.SetForecastingAngle(surroundRotateTime.value);
			surroundComponent.OpenSurroundFixedPoint(fixPoint.value, surroundRotateAngularVelocity.value, immediateLookAtTarget);
			surroundComponent.SetErrorFix(ownerEntity.transform.position, fixPoint.value);
			break;
		}
		if (!waitUntilFinish)
		{
			OnActionFinish();
		}
	}

	protected override void OnUpdate()
	{
		if (waitUntilFinish && base.elapsedTime >= surroundRotateTime.value)
		{
			surroundComponent.ShieldAll();
			switch (surroundedType)
			{
			case SurroundedType.Entity:
				surroundComponent.CorrectionError(entity.transform.position, surroundRotateTime.value);
				break;
			case SurroundedType.FixedPoint:
				surroundComponent.CorrectionError(fixPoint.value, surroundRotateTime.value);
				break;
			}
			OnActionFinish();
		}
	}
}
