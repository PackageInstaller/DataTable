using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体朝向", 0)]
[Description("从指定的实体获取其朝向角度，并将结果存储在指定的变量中。如果目标实体为空，则返回执行该任务的实体的朝向角度。")]
[Category("✫ DragonLost/Entity")]
public class GetEntityRotation : ActionTaskBase
{
	[Name("目标实体", 0)]
	[Tooltip("要获取朝向角度的目标实体的ID。如果目标实体为空，则默认为执行该任务的实体。")]
	[Description("要获取朝向角度的目标实体的ID。如果目标实体为空，则默认为执行该任务的实体。")]
	public BBParameter<int> entityId;

	[Name("返回的角度", 0)]
	[Description("存储获取到的实体朝向角度。")]
	public BBParameter<float> angle;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: true);
		if (entity == null)
		{
			angle.value = ownerEntity.transform.eulerAngles.y;
		}
		else
		{
			angle.value = entity.transform.eulerAngles.y;
		}
		EndAction();
	}
}
