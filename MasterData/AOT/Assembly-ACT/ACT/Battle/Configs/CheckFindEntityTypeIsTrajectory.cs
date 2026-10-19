using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断实体类型轨迹", "Predicate", new string[] { "check", "find", "entity", "type", "is", "trajectory", "target", "retarget", "aim", "predicate" })]
public class CheckFindEntityTypeIsTrajectory : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		switch (memory.target.entity.GetEntityType())
		{
		case EntityType.Character:
		case EntityType.Monster:
		case EntityType.Boss:
		case EntityType.Robot:
		case EntityType.StateObject:
			return false;
		case EntityType.Trajectory:
			return true;
		default:
			return false;
		}
	}
}
