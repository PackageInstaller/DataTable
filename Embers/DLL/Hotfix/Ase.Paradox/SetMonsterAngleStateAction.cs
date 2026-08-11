using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置怪物阶段", 0)]
[Category("✫ DragonLost/Monster")]
[Description("设置怪物的当前阶段")]
public class SetMonsterAngleStateAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要设置阶段的怪物实体的ID")]
	public BBParameter<int> EntityId;

	[Name("怪物阶段", 0)]
	[Description("要设置的怪物阶段")]
	public BBParameter<MonsterPhaseEnum> MonsterState;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			EndAction();
			return;
		}
		entity.GetComponent<MonsterPhaseComponent>().SetMonsterPhase(MonsterState.value);
		EndAction();
	}
}
