using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建追踪型子弹", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于创建追踪目标的子弹")]
public class CreateTrackedBullet : ActionTaskBase
{
	[ShowIf("useSelfPoint", 0)]
	[Name("初始位置", 0)]
	[Description("子弹的初始位置")]
	public BBParameter<Vector3> position;

	[Name("初始位置偏移量", 0)]
	[Description("子弹的初始位置偏移量")]
	public BBParameter<Vector3> positionOffset;

	[Name("初始角度偏移", 0)]
	[Description("子弹的初始角度偏移量")]
	public BBParameter<Vector3> eulerOffset;

	[Name("子弹ID", 0)]
	[Description("要创建的子弹的ID")]
	public BBParameter<int> bulletCfgId;

	[Name("返回子弹实体ID", 0)]
	[Description("用于存储创建的子弹实体的ID")]
	public BBParameter<int> returnBulletId;

	[Name("目标ID", 0)]
	[ShowIf("useTargetIdPoint", 1)]
	[Description("追踪目标的实体ID")]
	public BBParameter<int> targetId;

	[Name("目标坐标", 0)]
	[ShowIf("useTargetIdPoint", 0)]
	[Description("追踪目标的坐标")]
	public BBParameter<Vector3> targetPos;

	[Name("目标位置偏移量", 0)]
	[Description("追踪目标的位置偏移量")]
	public BBParameter<Vector3> targetPosOffset;

	[Name("是否随行为树销毁", 0)]
	[Description("指示子弹是否在行为树停止时销毁")]
	public bool isFollowDispose;

	[Name("基于自身坐标创建", 0)]
	[Description("指示子弹是否基于自身坐标创建")]
	public bool useSelfPoint = true;

	[Name("基于目标ID创建", 0)]
	[Description("指示子弹是否基于目标ID创建")]
	public bool useTargetIdPoint = true;

	[Name("跟踪行为数据列表", 0)]
	[Description("子弹的跟踪行为数据列表")]
	public BBParameter<List<BulletTrackedStageData>> stageDataList;

	[Name("是否当帧创建", 0)]
	public bool isCurrentTickCreate;

	[Name("特效是否需要插值运动", 0)]
	[Description("子弹加载的特效是否需要插值")]
	public bool ViewIsNeedLerp;

	[Name("特效移动的插值速度", 0)]
	[Description("特效移动的插值速度")]
	[ShowIf("ViewIsNeedLerp", 1)]
	public float StableMovementSharpness = 0.2f;

	[Name("特效旋转的插值速度", 0)]
	[Description("特效旋转的插值速度")]
	[ShowIf("ViewIsNeedLerp", 1)]
	public float StableRotationSharpness = 0.033f;

	protected override bool IsDisplayNode => false;

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity.GetSystem<BulletSystem>() == null)
		{
			OnActionFail();
			return;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"行为树准备创建跟踪子弹  子弹id {bulletCfgId}", ownerEntity);
		}
		BulletEntity bulletEntity = await ownerEntity.GetSystem<BulletSystem>().CreateTrackedBulletEntity(ownerEntity, bulletCfgId.value, useSelfPoint, useTargetIdPoint, position.value, positionOffset.value, eulerOffset.value, targetId.value, targetPos.value, targetPosOffset.value, stageDataList.value, isCurrentTickCreate, ViewIsNeedLerp, StableMovementSharpness, StableRotationSharpness);
		if (bulletEntity == null)
		{
			OnActionFail();
			return;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"行为树创建子弹的时间  子弹id {bulletCfgId}", bulletEntity);
		}
		returnBulletId.value = bulletEntity.Id;
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && isFollowDispose)
		{
			BulletEntity bulletEntity = (BulletEntity)ownerEntity.GetSystem<EntitySystem>().GetEntity(returnBulletId.value);
			if (bulletEntity != null && bulletEntity.IsSurvival)
			{
				bulletEntity.DoEntityDead();
			}
		}
	}
}
