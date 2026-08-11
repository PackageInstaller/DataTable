#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获得绝对角度带偏移量坐标", 0)]
[Description("根据给定的偏移距离和偏移角度计算目标对象的绝对角度带偏移量的坐标。")]
[Category("✫ DragonLost/EntityCalculateTool")]
public class GetTargetPosOffsetByFixedAction : ActionTaskBase
{
	[Name("偏移距离", 0)]
	[Description("偏移的距离。")]
	public BBParameter<float> OffSet;

	[Name("偏移角度", 0)]
	[Description("偏移的角度。")]
	public BBParameter<float> OffSetAngle;

	[Name("要获取坐标的目标对象的ID", 0)]
	[Description("要获取坐标的目标对象的ID。")]
	public BBParameter<int> TargetID;

	[Name("_目标的坐标存储的位置", 0)]
	[Description("计算得到的带偏移量的目标对象的新坐标。")]
	public BBParameter<Vector3> TargetPosition;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(TargetID.value, isSyncEntity: true);
		if (entity == null)
		{
			LogActionError("获得绝对角度带偏移量坐标错误: 实体为空!");
			EndAction();
			return;
		}
		TargetPosition.value = TSUtil.MoveForward2D(entity.transform.position, OffSetAngle.value, OffSet.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获得绝对角度带偏移量坐标:  position {entity.transform.position}, OffSetAngle {OffSetAngle.value}, " + $"OffSet {OffSet.value}, ID: {entity.Id}", ownerEntity);
		}
		EndAction();
	}
}
