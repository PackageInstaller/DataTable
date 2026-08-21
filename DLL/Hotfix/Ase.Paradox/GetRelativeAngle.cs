#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取相对角度(该节点弃用)", 0)]
[Description("根据指定的实体或坐标点，获取相对角度。注意：该节点已弃用，请考虑使用其他方法替代。")]
[Category("✫ DragonLost/Transform")]
public class GetRelativeAngle : ActionTaskBase
{
	[Name("相对角度类型", 0)]
	[Description("要获取的相对角度类型。")]
	public RelativeAngleType RelativeAngleType;

	[HideIf("RelativeAngleType", 3)]
	[Name("一号实体", 0)]
	[Description("用于相对角度计算的第一个实体的ID。")]
	public BBParameter<int> EntityOneId;

	[ShowIf("RelativeAngleType", 0)]
	[Name("二号实体", 0)]
	[Description("用于相对角度计算的第二个实体的ID。")]
	public BBParameter<int> EntityTwoId;

	[HideIf("RelativeAngleType", 0)]
	[Name("一号点位", 0)]
	[Description("用于相对角度计算的第一个坐标点。")]
	public BBParameter<Vector3> PointOne;

	[HideIf("RelativeAngleType", 0)]
	[Name("一号点位角度", 0)]
	[Description("用于相对角度计算的第一个坐标点的角度。")]
	public BBParameter<float> PointOneAngle;

	[ShowIf("RelativeAngleType", 3)]
	[Name("二号点位", 0)]
	[Description("用于相对角度计算的第二个坐标点。")]
	public BBParameter<Vector3> PointTwo;

	[Name("角度", 0)]
	[Description("存储计算得到的相对角度。")]
	public BBParameter<float> Angle;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = null;
		BaseEntity baseEntity2 = null;
		switch (RelativeAngleType)
		{
		case RelativeAngleType.Entity2Entity:
			baseEntity = GetEntity(EntityOneId.value, isSyncEntity: true);
			baseEntity2 = GetEntity(EntityTwoId.value, isSyncEntity: true);
			if (baseEntity == null || baseEntity2 == null)
			{
				LogActionError("获取相对角度 : 实体为空!");
				EndAction();
				return;
			}
			Angle.value = TSUtil.TargetFwdAngleToSelf(baseEntity.transform.position, baseEntity.transform.eulerAngles.y - 180f, baseEntity2.transform.position);
			break;
		case RelativeAngleType.Entity2Point:
			baseEntity = GetEntity(EntityOneId.value, isSyncEntity: true);
			if (baseEntity == null)
			{
				LogActionError("获取相对角度 : 实体为空!");
				EndAction();
				return;
			}
			Angle.value = TSUtil.TargetFwdAngleToSelf(baseEntity.transform.position, baseEntity.transform.eulerAngles.y - 180f, PointOne.value);
			break;
		case RelativeAngleType.Point2Entity:
			baseEntity = GetEntity(EntityOneId.value, isSyncEntity: true);
			if (baseEntity == null)
			{
				LogActionError("获取相对角度 : 实体为空!");
				EndAction();
				return;
			}
			Angle.value = TSUtil.TargetFwdAngleToSelf(PointOne.value, PointOneAngle.value, baseEntity.transform.position);
			break;
		case RelativeAngleType.Point2Point:
			Angle.value = TSUtil.TargetFwdAngleToSelf(PointOne.value, PointOneAngle.value, PointTwo.value);
			break;
		}
		EndAction();
	}
}
