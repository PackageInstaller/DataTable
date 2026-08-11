#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取当前实体的状态Id", 0)]
[Category("✫ DragonLost/State")]
[Description("获取当前实体的状态ID，并将其存储在指定的变量中。")]
public class GetEntityStateAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要获取状态ID的实体的ID。")]
	public BBParameter<int> entityId;

	[Name("状态ID", 0)]
	[Description("存储实体当前状态的变量。")]
	public BBParameter<int> stateId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
		if (entity == null)
		{
			LogActionError($"获取当前实体的状态Id:{entityId.value}错误:实体为空!");
			EndAction();
		}
		else
		{
			stateId.value = entity.GetComponent<StateComponent>().GetCurrentState().Id;
			EndAction();
		}
	}
}
