namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断重新目标攻击者", "Predicate", new string[] { "re", "target", "attacker", "retarget", "aim", "predicate", "check", "condition" })]
public class ReTargetAttacker : ConfigPredicate
{
	public ConfigPredicate predicate;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			return predicate.Check(new ActionMemory(memory.caster, memory.owner, getAttackData.GetAttackData().attacker, memory.evt, memory.ability));
		}
		return false;
	}
}
