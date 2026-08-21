using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("使实体进入战斗状态", 0)]
[Category("✫ DragonLost/Entity")]
[Description("使实体进入战斗状态")]
public class SetEntityBattleStateAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("实体进入战斗状态。")]
	public BBParameter<int> EntityId;

	[Name("是否要进入实体状态", 0)]
	[Description("是否要进入实体状态。")]
	public BBParameter<bool> EnterState;

	protected override void OnExecute()
	{
		base.OnExecute();
		BattleStateSystem system = ownerEntity.GetSystem<BattleStateSystem>();
		if (system == null)
		{
			OnActionFinish();
			return;
		}
		if (ownerEntity.Id == EntityId.value)
		{
			OnActionFinish();
			return;
		}
		EntitySystem system2 = ownerEntity.GetSystem<EntitySystem>();
		if (system2 == null)
		{
			OnActionFinish();
			return;
		}
		BaseEntity entity = system2.GetEntity(EntityId.value);
		if (entity == null)
		{
			OnActionFinish();
			return;
		}
		system.ForceSetBattleState(entity, ownerEntity);
		OnActionFinish();
	}
}
