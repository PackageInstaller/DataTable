using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取换人援护最大冷却", "Function", new string[] { "get", "max", "change", "assist", "cd" })]
public class FunctionGetMaxChangeCD : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompBehave(out CompBehave component))
		{
			return 0f;
		}
		return component.ChangeCDTotal;
	}
}
