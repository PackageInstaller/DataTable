using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ParabolaMovementPattern : TrajectoryMovementPattern
{
	[Tooltip("为True则特效的方向跟随速度，方向会持续更新")]
	public bool useVelocityDir;

	public ConfigFunction<Vector3> targetPos;

	public float velocityXZ;

	public float gravityScale = 1f;

	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		ParabolaMovementRunner parabolaMovementRunner = new ParabolaMovementRunner();
		parabolaMovementRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return parabolaMovementRunner;
	}
}
