using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("设置实体信息", 0)]
[Category("✫ DragonLost/Entity")]
[Description("设置指定实体的信息。")]
public class SetEntityInfo : ActionTaskBase
{
	[RequiredField]
	[Name("目标实体", 0)]
	[Description("要设置信息的目标实体的ID。")]
	public BBParameter<int> entityId;

	[Name("是否同时设置位置旋转", 0)]
	[Description("指示是否同时设置目标实体的位置和旋转。")]
	public bool setTargetPos;

	[Name("目标位置", 0)]
	[ShowIf("setTargetPos", 1)]
	[Description("要设置的目标位置。")]
	public BBParameter<Vector3> targetPosition;

	[Name("目标朝向", 0)]
	[ShowIf("setTargetPos", 1)]
	[Description("要设置的目标朝向。")]
	public BBParameter<Vector3> targetRotation;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: true);
		if (entity == null)
		{
			OnActionFail();
			return;
		}
		if (setTargetPos)
		{
			entity.transform.position = targetPosition.value;
			entity.transform.rotation = Quaternion.Euler(targetRotation.value);
		}
		OnActionFinish();
	}
}
