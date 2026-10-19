namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Before普通能量", "Predicate", new string[] { "check", "before", "modify", "normal", "energy", "value", "float", "int", "predicate", "condition" })]
public class CheckBeforeModifyNormalEnergy : ConfigPredicate
{
	public ActionChangeNormalEnergy.ModifySource modifySource;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtBeforeModifyNormalEnergy evtBeforeModifyNormalEnergy)
		{
			return evtBeforeModifyNormalEnergy.modifySource == modifySource;
		}
		return false;
	}
}
