using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改实体部位伤害阈值层数", 0)]
[Category("✫ DragonLost/Entity")]
public class ModifyEntityPartGroupProcessCount : ActionTaskBase
{
	[Name("实体ID", 0)]
	public BBParameter<int> entityId;

	[Name("部位组索引", 0)]
	public int index;

	[Name("值", 0)]
	public int value;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
		if (entity == null)
		{
			OnActionFail("修改实体部位伤害阈值层数，目标实体为空," + base.agent.name);
			return;
		}
		entity.GetComponent<EntityPartHitComponent>()?.OnModifyPartProcessCount(index, value);
		EndAction();
	}
}
