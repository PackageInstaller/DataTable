namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断动态值", "Predicate", new string[] { "check", "is", "dynamic", "value", "predicate", "condition" })]
public class CheckIsDynamicValuePredicate : ConfigPredicate
{
	public string dynamicName;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtDynamicValueChange evtDynamicValueChange)
		{
			return evtDynamicValueChange.name == dynamicName;
		}
		return false;
	}
}
