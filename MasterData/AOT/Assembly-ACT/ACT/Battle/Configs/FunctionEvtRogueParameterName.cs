namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取事件Rogue参数名称", "Function", new string[] { "evt", "rogue", "parameter", "name" })]
public class FunctionEvtRogueParameterName : ConfigFunction<string>
{
	protected override string Evaluate(ActionMemory memory)
	{
		if (memory.evt is EvtRogueParameterChange evtRogueParameterChange)
		{
			return evtRogueParameterChange.parameterName;
		}
		return null;
	}
}
