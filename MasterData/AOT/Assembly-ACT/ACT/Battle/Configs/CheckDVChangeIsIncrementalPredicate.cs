namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断DVIncremental", "Predicate", new string[] { "check", "dv", "change", "is", "incremental", "predicate", "condition" })]
public class CheckDVChangeIsIncrementalPredicate : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtDynamicValueChange evtDynamicValueChange)
		{
			if (evtDynamicValueChange.changeValue >= 0f)
			{
				return true;
			}
			return false;
		}
		return false;
	}
}
