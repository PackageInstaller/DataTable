using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取当前怪物阶段", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取指定实体的当前怪物阶段")]
public class GetMonsterAngleStateAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要获取当前阶段的怪物实体的ID")]
	public BBParameter<int> EntityId;

	[Name("返回的怪物阶段", 0)]
	[Description("存储获取到的怪物阶段")]
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
		MonsterState.value = entity.GetComponent<MonsterPhaseComponent>().GetMonsterPhase();
		EndAction();
	}
}
