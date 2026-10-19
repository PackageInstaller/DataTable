using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class StraightLineMovementPattern : TrajectoryMovementPattern
{
	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		StraightLineMovementRunner straightLineMovementRunner = new StraightLineMovementRunner();
		straightLineMovementRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return straightLineMovementRunner;
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
	}
}
