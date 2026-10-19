namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取事件Rogue参数名称", "Function", new string[] { "evt", "rogue", "trigger", "parameter", "name" })]
public class FunctionEvtRogueTriggerParameterName : ConfigFunction<string>
{
	protected override string Evaluate(ActionMemory memory)
	{
		if (memory.evt is EvtRogueTriggerParameterChange evtRogueTriggerParameterChange)
		{
			return evtRogueTriggerParameterChange.parameterName;
		}
		return null;
	}
}
