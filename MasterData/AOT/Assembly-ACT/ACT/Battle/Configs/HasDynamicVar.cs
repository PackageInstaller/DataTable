using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断是否有动态变量", "Predicate", new string[] { "has", "dynamic", "var", "predicate", "check", "condition" })]
public class HasDynamicVar : ConfigPredicate
{
	public string name;

	public override bool Check(ActionMemory memory)
	{
		FindTargetResult target = memory.target;
		if (target.IsValid)
		{
			Entity entity = target.entity;
			if (entity.TryGetCompAbility(out CompAbility component))
			{
				return component.HasDynamicVar(name);
			}
		}
		return false;
	}
}
