using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("实体是否存在", 0)]
[Description("检查指定的实体是否存在于系统中。")]
[Category("✫ DragonLost/EntityCalculateTool")]
public class EntityIsActiveCondition : ConditionTaskBase
{
	[RequiredField]
	[Name("实体Id", 0)]
	[Description("要检查的实体的ID。")]
	public BBParameter<int> entityId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		return ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value) != null;
	}
}
