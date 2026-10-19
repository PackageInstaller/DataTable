namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断普通能量", "Predicate", new string[] { "check", "consume", "normal", "energy", "value", "float", "int", "predicate", "condition" })]
public class CheckConsumeNormalEnergy : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtModifyNormalEnergy evtModifyNormalEnergy)
		{
			return evtModifyNormalEnergy.modifySource == ActionChangeNormalEnergy.ModifySource.consmueAbility;
		}
		return false;
	}
}
