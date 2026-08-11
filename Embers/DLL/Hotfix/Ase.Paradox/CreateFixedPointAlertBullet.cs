using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建预警子弹 (基于固定位置和角度)", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于创建固定点预警子弹，并设置相关参数")]
public class CreateFixedPointAlertBullet : ActionTaskBase
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

	[Name("预警子弹领先时间", 0)]
	[Description("子弹的预警领先时间")]
	public BBParameter<float> leadTime;

	[Name("返回子弹实体Id", 0)]
	[Description("返回创建的子弹实体的ID")]
	public BBParameter<int> returnBulletId;

	[Name("子弹Id", 0)]
	[Description("子弹的ID")]
	public int bulletId;

	[Name("子弹受击盒缩放", 0)]
	[Description("子弹的受击盒缩放比例")]
	public BBParameter<float> bulletHitColliderScale;

	[Name("子弹生命时间", 0)]
	[Description("子弹的生命时间")]
	public BBParameter<float> bulletLifeTime;

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

	protected override void OnExecute()
	{
		base.OnExecute();
		BulletSystem system = ownerEntity.GetSystem<BulletSystem>();
		if (system == null)
		{
			OnActionFail();
			return;
		}
		if (bulletHitColliderScale.value == 0f)
		{
			bulletHitColliderScale.value = 1.2f;
		}
		if (bulletLifeTime.value == 0f)
		{
			bulletLifeTime.value = 1f;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"行为树准备创建预警子弹 子弹id {bulletId}", ownerEntity);
		}
		AlertBulletEntity alertBulletEntity = system.CreateFixedPointAlertBulletEntity(leadTime.value, ownerEntity, bulletId, bulletPoint.value, angle.value, bulletHitColliderScale.value, bulletLifeTime.value, isCurrentTickCreate, ViewIsNeedLerp, StableMovementSharpness, StableRotationSharpness);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"行为树创建预警子弹的时间  子弹id {bulletId}", alertBulletEntity);
		}
		if (alertBulletEntity != null)
		{
			returnBulletId.value = alertBulletEntity.Id;
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && isFollowDispose)
		{
			AlertBulletEntity alertBulletEntity = (AlertBulletEntity)ownerEntity.GetSystem<EntitySystem>().GetEntity(returnBulletId.value);
			if (alertBulletEntity != null && alertBulletEntity.IsSurvival)
			{
				alertBulletEntity.GetComponent<BulletLifeComponent>().DoShadowEndLife();
			}
		}
	}
}
