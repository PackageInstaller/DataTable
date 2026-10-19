namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断实体Valid", "Predicate", new string[] { "check", "entity", "valid", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckEntityValidPredicate : ConfigPredicate
{
	public MemoryEntityRef checkEntityRef;

	public override bool Check(ActionMemory memory)
	{
		return memory.GetEntityReference(checkEntityRef).IsValid;
	}
}
