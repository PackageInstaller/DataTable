using System;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("获取行为树整数值", "Function", new string[] { "bt", "int", "value", "float" })]
public class FunctionBTInt : ConfigFunction<int>
{
	public string key;

	public ConfigFunction<int> fallback;

	protected override int Evaluate(ActionMemory memory)
	{
		ActBehaviorTree actBehaviorTree = memory.owner.GetCompAI().ActBehaviorTree;
		if ((object)actBehaviorTree != null)
		{
			return ((SharedInt)actBehaviorTree.GetVariable(key)).Value;
		}
		return fallback.Return(memory);
	}
}
