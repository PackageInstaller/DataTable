namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断重新目标Attackee", "Predicate", new string[] { "re", "target", "attackee", "retarget", "aim", "predicate", "check", "condition" })]
public class ReTargetAttackee : ConfigPredicate
{
	public ConfigPredicate predicate;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			return predicate.Check(new ActionMemory(memory.caster, memory.owner, getAttackData.GetAttackData().attackee, memory.evt, memory.ability));
		}
		return false;
	}
}
