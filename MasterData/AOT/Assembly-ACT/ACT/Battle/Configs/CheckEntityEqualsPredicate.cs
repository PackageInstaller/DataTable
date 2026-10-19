namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断实体Equals", "Predicate", new string[] { "check", "entity", "equals", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckEntityEqualsPredicate : ConfigPredicate
{
	public ConfigFunction<EntityReference> entityA;

	public ConfigFunction<EntityReference> entityB;

	public override bool Check(ActionMemory memory)
	{
		return entityA.Return(memory) == entityB.Return(memory);
	}
}
