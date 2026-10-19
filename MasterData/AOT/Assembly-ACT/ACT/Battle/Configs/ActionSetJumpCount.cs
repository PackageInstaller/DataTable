using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置跳跃数量", "Action", new string[] { "set", "jump", "count", "move", "movement", "position", "velocity" })]
public class ActionSetJumpCount : ConfigAction
{
	public ConfigFunction<int> jumpCount;

	public ConfigFunction<float> reSetJumpCount = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public override void Do(ActionMemory memory)
	{
		if (reSetJumpCount != null)
		{
			memory.target.entity.GetCompMotion().JumpInAirCount = (int)reSetJumpCount.Return(memory);
		}
		else
		{
			memory.target.entity.GetCompMotion().JumpInAirCount = jumpCount.Return(memory);
		}
	}
}
