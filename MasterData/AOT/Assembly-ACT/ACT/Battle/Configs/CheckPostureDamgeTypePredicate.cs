namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断架势Damge类型", "Predicate", new string[] { "check", "posture", "damge", "type", "predicate", "condition" })]
public class CheckPostureDamgeTypePredicate : ConfigPredicate
{
	public PostureDmgType postureDmgTye;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtPostureDamage evtPostureDamage)
		{
			return evtPostureDamage.attackData.postureDmgType == postureDmgTye;
		}
		return false;
	}
}
