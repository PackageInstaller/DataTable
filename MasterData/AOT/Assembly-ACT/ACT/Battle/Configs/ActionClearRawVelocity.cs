using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("清除Raw速度", "Action", new string[] { "clear", "raw", "velocity" })]
public class ActionClearRawVelocity : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompPhysics()?.ClearVelocity();
	}
}
