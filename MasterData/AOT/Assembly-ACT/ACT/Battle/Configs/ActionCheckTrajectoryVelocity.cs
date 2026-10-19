using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断轨迹速度", "Action", new string[] { "check", "trajectory", "velocity", "predicate", "condition" })]
public class ActionCheckTrajectoryVelocity : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return memory.owner.GetCompVelocity().velocity.x > 0f;
	}
}
