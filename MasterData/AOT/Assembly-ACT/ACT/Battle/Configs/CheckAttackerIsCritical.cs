namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断攻击者Critical", "Predicate", new string[] { "check", "attacker", "is", "critical", "predicate", "condition" })]
public class CheckAttackerIsCritical : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			return getAttackData.GetAttackData().critical;
		}
		return false;
	}
}
