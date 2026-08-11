using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改环绕子弹参数", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于修改环绕类子弹的运动参数，如速度、半径等")]
public class SetBulletMotionToFollow : ActionTaskBase
{
	[Name("子弹实体Id", 0)]
	[Description("要修改参数的子弹实体的ID")]
	public BBParameter<int> bulletId;

	[Name("配置环绕目标方式", 0)]
	[Description("选择子弹的环绕目标方式")]
	public BulletFollowType bulletFollowType;

	[Name("环绕目标点世界坐标", 0)]
	[ShowIf("bulletFollowType", 0)]
	[Description("子弹环绕的目标点的世界坐标")]
	public BBParameter<Vector3> worldPoint;

	[Name("目标位置偏移量", 0)]
	[ShowIf("bulletFollowType", 0)]
	public BBParameter<Vector3> worldOffset;

	[Name("环绕目标实体Id", 0)]
	[ShowIf("bulletFollowType", 1)]
	[Description("子弹环绕的目标实体的Id")]
	public BBParameter<int> entityId;

	[Name("目标位置相对偏移量", 0)]
	[ShowIf("bulletFollowType", 1)]
	public BBParameter<Vector3> targetLocalOffset;

	[Name("目标位置绝对偏移量", 0)]
	[ShowIf("bulletFollowType", 1)]
	public BBParameter<Vector3> targetWorldOffset;

	[Name("环绕速度", 0)]
	[Description("设置子弹环绕的速度")]
	public BBParameter<float> speed;

	[Name("速度变化时间", 0)]
	[Description("设置子弹速度的变化时间")]
	public BBParameter<float> speedAcTime;

	[Name("环绕半径", 0)]
	[Description("设置子弹环绕的半径")]
	public BBParameter<float> radius;

	[Name("半径变化时间", 0)]
	[Description("设置子弹半径的变化时间")]
	public BBParameter<float> radiusAcTime;

	[Name("是否为顺时针方向", 0)]
	[Description("设置子弹环绕的方向，true为顺时针，false为逆时针")]
	public BBParameter<bool> isClockwise;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity.GetSystem<BulletSystem>() == null)
		{
			OnActionFail();
			return;
		}
		BulletEntity bulletEntity = (BulletEntity)ownerEntity.GetSystem<EntitySystem>().GetEntity(bulletId.value);
		if (bulletEntity == null)
		{
			EndAction();
			return;
		}
		BaseEntity baseEntity = null;
		if (bulletFollowType == BulletFollowType.TARGET)
		{
			baseEntity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
			if (baseEntity == null)
			{
				EndAction();
				return;
			}
		}
		bulletEntity.GetComponent<BulletMoveComponent>().SetToFollowMove(radius.value, radiusAcTime.value, speed.value, 1f, speedAcTime.value, isClockwise.value, baseEntity, worldPoint.value, targetWorldOffset.value, targetLocalOffset.value);
		EndAction();
	}
}
