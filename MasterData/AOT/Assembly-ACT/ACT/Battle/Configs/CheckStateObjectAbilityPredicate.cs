using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断状态对象技能", "Predicate", new string[] { "check", "state", "object", "ability", "status", "tag", "predicate", "condition" })]
public class CheckStateObjectAbilityPredicate : ConfigPredicate
{
	public string name;

	public override bool Check(ActionMemory memory)
	{
		if (memory.target.entity.IsCollection())
		{
			return memory.target.entity.GetCompAbility().HasAbility(name);
		}
		return false;
	}
}
