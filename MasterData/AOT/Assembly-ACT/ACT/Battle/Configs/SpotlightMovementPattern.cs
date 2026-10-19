using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class SpotlightMovementPattern : TrajectoryMovementPattern
{
	public bool followPlayer;

	public float followSpeed;

	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		SpotlightMovementRunner spotlightMovementRunner = new SpotlightMovementRunner();
		spotlightMovementRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return spotlightMovementRunner;
	}
}
