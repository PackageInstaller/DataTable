using System;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("获取整数", "Function", new string[] { "int", "value", "float" })]
public class FunctionInt : ConfigFunction<int>
{
	public int value;

	protected override int Evaluate(ActionMemory memory)
	{
		return value;
	}
}
