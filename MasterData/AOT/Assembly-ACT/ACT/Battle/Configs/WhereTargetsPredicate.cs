namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Where目标", "Predicate", new string[] { "where", "targets", "predicate", "check", "condition" })]
public class WhereTargetsPredicate : ConfigPredicate
{
	public WhereTargets whereTargets;

	public override bool Check(ActionMemory memory)
	{
		return whereTargets.Check(memory.owner, memory.target.entity);
	}
}
