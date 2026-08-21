using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取怪物难度", 0)]
[Category("✫ DragonLost/Entity")]
[Description("获取怪物难度")]
public class GetMonsterDifficultyAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("实体ID")]
	public BBParameter<int> EntityId;

	[Name("难度", 0)]
	[Description("返回的怪物的难度")]
	public BBParameter<int> MonsterDifficulty = 0;

	protected override void OnExecute()
	{
		base.OnExecute();
		MonsterDifficulty.value = 0;
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(EntityId.value);
		if (entity == null)
		{
			OnActionFinish();
			return;
		}
		if (entity is MonsterEntity { MonsterAttrConfig: not null } monsterEntity)
		{
			MonsterDifficulty.value = monsterEntity.MonsterAttrConfig.MonsterDifficulty;
		}
		OnActionFinish();
	}
}
