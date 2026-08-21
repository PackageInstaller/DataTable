#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取目标位置相对实体的角度", 0)]
[Description("根据指定的基准实体和目标位置，计算目标位置相对于基准实体的角度。")]
[Category("✫ DragonLost/Transform")]
public class GetTargetPosAngleForEntity : ActionTaskBase
{
	[Name("基准实体ID", 0)]
	[Description("用于计算角度的基准实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("目标位置", 0)]
	[Description("要计算角度的目标位置。")]
	public BBParameter<Vector3> targetPos;

	[Name("获取的角度", 0)]
	[Description("用于存储计算得到的角度的变量。")]
	public BBParameter<float> angleResult;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: true);
		if (entity == null)
		{
			LogActionError("获取目标位置相对实体的角度错误：基准实体为空!");
			EndAction();
		}
		else
		{
			angleResult.value = TSUtil.TargetFwdAngleToSelf(entity.transform.position, entity.transform.eulerAngles.y - 180f, targetPos.value);
			EndAction();
		}
	}
}
