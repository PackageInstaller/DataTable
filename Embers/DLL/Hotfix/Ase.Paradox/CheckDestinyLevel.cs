using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查灵冠等级", 0)]
[Category("✫ DragonLost/Condition")]
[Description("检查当前灵冠是否大于等于目标等级，大于等于则返回TRUE。")]
public class CheckDestinyLevel : ConditionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要检查状态的实体的唯一标识符。")]
	public BBParameter<int> EntityId;

	[Name("灵冠等级", 0)]
	[Description("灵冠等级。")]
	public BBParameter<int> DestinyLevel;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetOwnerEntity().GetSystem<EntitySystem>().GetEntity(EntityId.value);
		if (entity == null)
		{
			return false;
		}
		if (!(entity is HeroEntity heroEntity))
		{
			return false;
		}
		return heroEntity.BattleHeroData.ThanDestinyLevel(DestinyLevel.value);
	}
}
