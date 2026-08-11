using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建预警子弹", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于创建预警子弹，并设置相关参数")]
public class CreateAlertBullet : ActionTaskBase
{
	[Name("水平角度", 0)]
	[ShowIf("ConfigurationType", 1)]
	[Description("子弹的水平角度")]
	public BBParameter<float> angle;

	[Name("子弹坐标", 0)]
	[ShowIf("useSelfPoint", 0)]
	[Description("子弹的初始位置")]
	public BBParameter<Vector3> bulletPoint;

	[Name("初始位置偏移配置类型", 0)]
	[Description("配置子弹初始位置偏移的类型")]
	public OffsetConfigurationType ConfigurationType;

	[Name("水平距离", 0)]
	[ShowIf("ConfigurationType", 1)]
	[Description("子弹的水平距离")]
	public BBParameter<float> distance = 0f;

	[Name("高度偏移", 0)]
	[ShowIf("ConfigurationType", 1)]
	[Description("子弹的高度偏移")]
	public BBParameter<float> heightOffset = 0f;

	[Name("是否跟随行为树销毁子弹", 0)]
	[Description("确定子弹是否在行为树结束时被销毁")]
	public bool isFollowDispose;

	[Name("预警子弹领先时间", 0)]
	[Description("子弹的预警领先时间")]
	public BBParameter<float> leadTime;

	[Name("位置偏移量", 0)]
	[ShowIf("ConfigurationType", 0)]
	[Description("子弹的位置偏移量")]
	public BBParameter<Vector3> offset = Vector3.zero;

	[Name("返回子弹实体Id", 0)]
	[Description("返回创建的子弹实体的ID")]
	public BBParameter<int> returnBulletId;

	[Name("子弹自身角度Y轴偏移", 0)]
	[Description("子弹自身角度Y轴偏移(变量描述)")]
	public BBParameter<float> rotationOffsetY = 0f;

	[Name("子弹Id", 0)]
	[Description("子弹的ID")]
	public int skillId;

	[Name("基于自身坐标创建", 0)]
	[Description("确定子弹是否基于自身坐标创建")]
	public bool useSelfPoint = true;

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
		if (ownerEntity.GetSystem<BulletSystem>() == null)
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
		AlertBulletEntity alertBulletEntity = ownerEntity.GetSystem<BulletSystem>().CreateAlertBulletEntity(leadTime.value, ownerEntity, skillId, useSelfPoint, bulletPoint.value, rotationOffsetY.value, ConfigurationType, offset.value, distance.value, angle.value, heightOffset.value, bulletHitColliderScale.value, bulletLifeTime.value, isCurrentTickCreate, ViewIsNeedLerp, StableMovementSharpness, StableRotationSharpness);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId("行为树创建子弹创建子弹的时间", alertBulletEntity);
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
