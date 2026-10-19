using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置换人援护最大冷却", "Action", new string[] { "change", "max", "assist", "cd" })]
public class ActionChangeMaxCD : ConfigAction
{
	public ConfigFunction<float> configFunction = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.SetMaxChangeCd(configFunction.Return(memory));
	}
}
