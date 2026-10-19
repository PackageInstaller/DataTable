using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class FollowOwnerOffsetMovementPattern : TrajectoryMovementPattern
{
	public bool freezeWhenOwnerMissing = true;

	public bool syncOwnerRotation;

	public VelocityModifier[] velocityModifiers;

	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		FollowOwnerOffsetMovementRunner followOwnerOffsetMovementRunner = new FollowOwnerOffsetMovementRunner();
		followOwnerOffsetMovementRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return followOwnerOffsetMovementRunner;
	}
}
