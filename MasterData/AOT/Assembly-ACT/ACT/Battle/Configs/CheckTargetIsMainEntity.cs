namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断目标主控实体", "Predicate", new string[] { "check", "target", "is", "main", "entity", "retarget", "aim", "predicate", "condition" })]
public class CheckTargetIsMainEntity : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return MonoECS.instance.mainEntityId == memory.target.entity.Id;
	}
}
