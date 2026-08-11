using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改抛物线子弹参数", 0)]
[Description("用于修改抛物线运动类子弹的参数，包括落点方式、落点坐标等")]
[Category("✫ DragonLost/Bullet")]
public class SetBulletMotionToParabola : ActionTaskBase
{
	public enum EndPointSetting
	{
		WORLDPOSITION,
		DIRECT
	}

	private QuerryBulletType querryBulletType;

	[Name("子弹实体Id", 0)]
	[ShowIf("querryBulletType", 0)]
	[Description("要修改参数的子弹实体的ID")]
	public BBParameter<int> bulletId;

	[Name("子弹实体", 0)]
	[Description("子弹实体(变量描述)")]
	[ShowIf("querryBulletType", 1)]
	public BBParameter<BaseEntity> bulletEntity;

	[Name("设置落点方式", 0)]
	[Description("设置子弹抛物线运动的落点方式")]
	public EndPointSetting endPointSetting;

	[Name("落点世界坐标", 0)]
	[ShowIf("endPointSetting", 0)]
	[Description("设置子弹抛物线运动的目标落点的世界坐标")]
	public BBParameter<Vector3> endPointPos;

	[Name("落点与起点的水平距离", 0)]
	[ShowIf("endPointSetting", 1)]
	[Description("设置子弹抛物线运动的目标落点与起点的水平距离")]
	public BBParameter<float> distance = 0f;

	[Name("落点与起点的高度差", 0)]
	[ShowIf("endPointSetting", 1)]
	[Description("设置子弹抛物线运动的目标落点与起点的高度差")]
	public BBParameter<float> heightOffset = 0f;

	[Name("水平角度", 0)]
	[ShowIf("endPointSetting", 1)]
	[Description("设置子弹抛物线运动的水平角度")]
	public BBParameter<float> angle;

	[Name("位移总时长", 0)]
	[Description("设置子弹抛物线运动的总时长")]
	public float moveTime;

	[Name("抛物线位移最高点(相对量)", 0)]
	[Tooltip("相对于起点落点的最高位置 高出多少")]
	[Description("设置子弹抛物线运动的最高点的相对高度")]
	public float height;

	protected override void OnExecute()
	{
		base.OnExecute();
		BulletEntity bulletEntity = null;
		switch (querryBulletType)
		{
		case QuerryBulletType.ID:
			bulletEntity = (BulletEntity)GetOwnerEntity().GetSystem<EntitySystem>().GetEntity(bulletId.value);
			break;
		case QuerryBulletType.ENTITY:
			bulletEntity = (BulletEntity)this.bulletEntity.value;
			break;
		}
		if (bulletEntity == null)
		{
			EndAction();
			return;
		}
		Vector3 targetPoint = endPointPos.value;
		if (endPointSetting == EndPointSetting.DIRECT)
		{
			targetPoint = ownerEntity.transform.position + ownerEntity.transform.rotation * new Vector3(distance.value * Mathf.Cos(90f + angle.value), ownerEntity.transform.position.y + heightOffset.value, distance.value * Mathf.Sin(90f + angle.value));
		}
		bulletEntity.GetComponent<BulletMoveComponent>().SetToParabolaMove(targetPoint, height, moveTime);
		EndAction();
	}
}
