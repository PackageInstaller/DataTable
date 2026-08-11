using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建子弹", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("可选择固定位置or位置偏移（相对偏移，绝对偏移），角度偏移（根据位置偏移决定相对or绝对），高度偏移")]
public class CreateBullet : ActionTaskBase
{
	[Name("子弹坐标", 0)]
	[ShowIf("useSelfPoint", 0)]
	[Description("子弹的初始坐标")]
	public BBParameter<Vector3> bulletPoint;

	[Name("初始位置偏移配置类型", 0)]
	[Description("配置子弹初始位置偏移的类型")]
	public OffsetConfigurationType ConfigurationType;

	[Name("水平距离", 0)]
	[ShowIf("ConfigurationType", 1)]
	[Description("子弹的水平距离")]
	public BBParameter<float> distance = 0f;

	[Name("水平角度", 0)]
	[ShowIf("ConfigurationType", 1)]
	[Description("子弹的水平角度")]
	public BBParameter<float> angle;

	[Name("高度偏移", 0)]
	[ShowIf("ConfigurationType", 1)]
	[Description("子弹的高度偏移")]
	public BBParameter<float> heightOffset = 0f;

	[Name("是否跟随行为树销毁子弹", 0)]
	[Description("确定子弹是否在行为树结束时被销毁")]
	public bool isFollowDispose;

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
			LockstepData.Instance?.WriteAuthorityEntityId($"行为树准备创建子弹  子弹id {skillId}", ownerEntity);
		}
		BulletEntity bulletEntity = await ownerEntity.GetSystem<BulletSystem>().CreateBulletEntity(ownerEntity, skillId, useSelfPoint, bulletPoint.value, rotationOffsetY.value, ConfigurationType, offset.value, distance.value, angle.value, heightOffset.value, isCurrentTickCreate, ViewIsNeedLerp, StableMovementSharpness, StableRotationSharpness);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"行为树创建子弹的时间  子弹id {skillId}", bulletEntity);
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
		if (isFollowDispose && ownerEntity != null)
		{
			EntitySystem system = ownerEntity.GetSystem<EntitySystem>();
			if (system != null && system.GetEntity(returnBulletId.value, isGetCache: true) is BulletEntity bulletEntity)
			{
				bulletEntity.DoEntityDead();
			}
		}
	}
}
