namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断实体Valid", "Predicate", new string[] { "check", "entity", "valid", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckFunctionEntityValidPredicate : ConfigPredicate
{
	public ConfigFunction<EntityReference> configEntity;

	public override bool Check(ActionMemory memory)
	{
		return configEntity?.Return(memory).IsValid ?? false;
	}
}
