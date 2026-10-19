using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断怪物攻击类型", "Predicate", new string[] { "check", "monster", "attack", "type", "predicate", "condition" })]
public class CheckMonsterAttackType : ConfigPredicate
{
	public MonsterAttackType MonsterAttackType;

	public override bool Check(ActionMemory memory)
	{
		FindTargetResult target = memory.target;
		if (!target.entity.TryGetCompMonster(out CompMonster _))
		{
			return false;
		}
		return target.entity.GetCompBehave().Config.MonsterAttackType == MonsterAttackType;
	}
}
