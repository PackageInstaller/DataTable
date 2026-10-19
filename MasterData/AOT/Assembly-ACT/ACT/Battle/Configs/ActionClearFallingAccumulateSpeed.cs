using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("清除Falling累积速度", "Action", new string[] { "clear", "falling", "accumulate", "speed", "move", "movement", "position", "velocity" })]
public class ActionClearFallingAccumulateSpeed : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompPhysics()?.ClearFallingAccumulateSpeed();
	}
}
