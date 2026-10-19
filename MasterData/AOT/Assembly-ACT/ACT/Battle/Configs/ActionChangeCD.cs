using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改换人援护冷却", "Action", new string[] { "change", "cd", "skill", "ability" })]
public class ActionChangeCD : ConfigAction
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
		memory.target.entity.SetChangeCd(configFunction.Return(memory));
	}
}
