using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class WaveMovementPattern : TrajectoryMovementPattern
{
	public float amplitude;

	public float angular;

	public float phase;

	public float speed;

	public InitVelocity initVelocity;

	public VelocityModifier[] velocityModifiers;

	public bool useVelocityDir;

	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		WaveTrajectoryRunner waveTrajectoryRunner = new WaveTrajectoryRunner();
		waveTrajectoryRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return waveTrajectoryRunner;
	}
}
