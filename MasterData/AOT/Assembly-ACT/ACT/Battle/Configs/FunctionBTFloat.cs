using Bamboo.ECS;
using BehaviorDesigner.Runtime;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取行为树浮点值", "Function", new string[] { "bt", "float", "value", "int" })]
public class FunctionBTFloat : ConfigFunction<float>
{
	public string key;

	public ConfigFunction<float> fallback;

	protected override float Evaluate(ActionMemory memory)
	{
		ActBehaviorTree actBehaviorTree = memory.owner.GetCompAI().ActBehaviorTree;
		if ((object)actBehaviorTree != null)
		{
			return ((SharedFloat)actBehaviorTree.GetVariable(key)).Value;
		}
		return fallback.Return(memory);
	}
}
