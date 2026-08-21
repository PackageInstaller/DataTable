using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建子弹 (基于固定位置和角度)", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于创建固定点子弹，并设置相关参数")]
public class CreateFixedPointBullet : ActionTaskBase
{
	[Name("子弹坐标", 0)]
	[Description("子弹的初始坐标")]
	public BBParameter<Vector3> bulletPoint;

	[Name("水平角度", 0)]
	[Description("子弹的水平角度")]
	public BBParameter<float> angle;

	[Name("是否跟随行为树销毁子弹", 0)]
	[Description("确定子弹是否在行为树结束时被销毁")]
	public bool isFollowDispose;

	[Name("返回子弹实体Id", 0)]
	[Description("返回创建的子弹实体的ID")]
	public BBParameter<int> returnBulletId;

	[Name("子弹Id", 0)]
	[Description("子弹的ID")]
	public int bulletId;

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
			LockstepData.Instance?.WriteAuthorityEntityId($"行为树准备创建子弹  子弹id {bulletId}", ownerEntity);
		}
		BulletEntity bulletEntity = await ownerEntity.GetSystem<BulletSystem>().CreateFixedPointBulletEntity(ownerEntity, bulletId, bulletPoint.value, angle.value, isCurrentTickCreate, ViewIsNeedLerp, StableMovementSharpness, StableRotationSharpness);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"行为树创建子弹的时间  子弹id {bulletId}", bulletEntity);
		}
		if (bulletEntity != null)
		{
			returnBulletId.value = bulletEntity.Id;
		}
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
