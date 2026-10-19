using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("增量修改换人援护冷却", "Action", new string[] { "change", "add", "current", "assist", "cd" })]
public class ActionModifyChangeCD : ConfigAction
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
		Entity entity = memory.target.entity;
		entity.SetChangeCd(entity.GetChangeCd() + configFunction.Return(memory));
	}
}
