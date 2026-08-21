using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体位置", 0)]
[Description("从指定的实体获取其位置信息，并将结果存储在指定的变量中。如果目标实体为空，则会返回自身的坐标。")]
[Category("✫ DragonLost/Entity")]
public class GetEntityPosition : ActionTaskBase
{
	[Name("返回坐标", 0)]
	[Description("存储获取到的实体位置。")]
	public BBParameter<Vector3> positionParam;

	[Name("目标实体", 0)]
	[Description("要获取位置的目标实体的ID。如果目标实体为空，则会返回自身的坐标。")]
	[Tooltip("目标实体为空时，则会返回自身的坐标。")]
	public BBParameter<int> targetId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(targetId.value, isSyncEntity: true);
		if (entity == null)
		{
			EndAction();
			return;
		}
		positionParam.value = entity.transform.position;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取实体位置 {positionParam.value}", ownerEntity);
		}
		OnActionFinish();
	}
}
