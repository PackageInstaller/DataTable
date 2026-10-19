using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class ActionSetTrajectoryLifeEnd : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		entity.GetCompTrajectory()?.trajectory.SetLifeEnd(entity);
	}
}
