using ACT.Battle.Configs;

namespace ACT.Battle;

[AbilityTypeMetadata("获取动态变量变化值", "Function", new string[] { "dynamic", "value", "changed", "float", "int" })]
public class DynamicValueChanged : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		if (!(memory.evt is EvtDynamicValueChange evtDynamicValueChange))
		{
			return 0f;
		}
		return evtDynamicValueChange.changeValue;
	}
}
