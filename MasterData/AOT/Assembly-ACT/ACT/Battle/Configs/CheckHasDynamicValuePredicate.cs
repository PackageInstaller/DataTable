using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断动态值", "Predicate", new string[] { "check", "has", "dynamic", "value", "predicate", "condition" })]
public class CheckHasDynamicValuePredicate : ConfigPredicate
{
	public string dynamicName;

	public override bool Check(ActionMemory memory)
	{
		return memory.target.entity.GetCompAbility()?.vars.ContainsKey(dynamicName) ?? false;
	}
}
