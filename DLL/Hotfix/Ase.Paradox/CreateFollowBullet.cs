using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建环绕型子弹", 0)]
[Description("用于创建跟随目标或固定点旋转的子弹")]
[Category("✫ DragonLost/Bullet")]
public class CreateFollowBullet : ActionTaskBase
{
	[Name("子弹Id", 0)]
	[Description("要创建的子弹的ID")]
	public int bulletId;

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

	[Name("子弹自身角度Y轴偏移", 0)]
	[Description("子弹自身的Y轴角度偏移量")]
	public BBParameter<float> rotationOffsetY = 0f;

	[Name("配置水平角度方式", 0)]
	[Description("选择子弹的初始水平角度方式")]
	public BulletAngleType bulletAngleType;

	[Name("初始水平角度,绝对角度", 0)]
	[ShowIf("bulletAngleType", 0)]
	[Description("子弹初始的绝对水平角度")]
	public BBParameter<float> oriAngle;

	[Name("初始水平角度,相对角度", 0)]
	[ShowIf("bulletAngleType", 1)]
	[Description("子弹初始的相对水平角度")]
	public BBParameter<float> offsetAngle;

	[Name("环绕速度", 0)]
	[Description("子弹的环绕速度")]
	public BBParameter<float> speed;

	[Name("环绕半径", 0)]
	[Description("子弹的环绕半径")]
	public BBParameter<float> radius;

	[Name("是否为顺时针方向", 0)]
	[Description("子弹环绕目标的旋转方向，true表示顺时针，false表示逆时针")]
	public BBParameter<bool> isClockwise;

	[Name("返回子弹实体Id", 0)]
	[Description("用于存储创建的子弹实体的ID")]
	public BBParameter<int> returnBulletId;

	[Name("是否跟随行为树销毁子弹", 0)]
	[Description("指示子弹是否在行为树停止时销毁")]
	public bool isFollowDispose;

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

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity.GetSystem<BulletSystem>() == null)
		{
			OnActionFail();
			return;
		}
		BaseEntity targetEntity = null;
		if (bulletFollowType == BulletFollowType.TARGET)
		{
			targetEntity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
			if (targetEntity == null)
			{
				EndAction();
				return;
			}
		}
		float num = 0f;
		switch (bulletAngleType)
		{
		case BulletAngleType.WORLD:
			num = oriAngle.value;
			break;
		case BulletAngleType.OFFSET:
			num = ((bulletFollowType != BulletFollowType.WORLDPOINT) ? (targetEntity.transform.eulerAngles.y + offsetAngle.value) : offsetAngle.value);
			break;
		}
		BulletEntity bulletEntity = await ownerEntity.GetSystem<BulletSystem>().CreateBulletEntity(ownerEntity, bulletId, targetEntity, rotationOffsetY.value, worldPoint.value + worldOffset.value, num, radius.value, isCurrentTickCreate, ViewIsNeedLerp, StableMovementSharpness, StableRotationSharpness);
		if (bulletEntity == null)
		{
			EndAction();
			return;
		}
		returnBulletId.value = bulletEntity.Id;
		switch (bulletFollowType)
		{
		case BulletFollowType.TARGET:
			bulletEntity.GetComponent<BulletMoveComponent>().SetToFollowTargetRotate(targetEntity, targetWorldOffset.value, targetLocalOffset.value, speed.value, radius.value, isClockwise.value);
			break;
		case BulletFollowType.WORLDPOINT:
		{
			Vector3 followPoint = worldPoint.value + worldOffset.value;
			bulletEntity.GetComponent<BulletMoveComponent>().SetToFollowFixedPointRotate(followPoint, speed.value, radius.value, isClockwise.value);
			break;
		}
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && isFollowDispose)
		{
			BulletEntity bulletEntity = (BulletEntity)(ownerEntity?.GetSystem<EntitySystem>().GetEntity(returnBulletId.value));
			if (bulletEntity != null && bulletEntity.IsSurvival)
			{
				bulletEntity.DoEntityDead();
			}
		}
	}
}
