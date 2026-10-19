using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class CompositeMovementPattern : TrajectoryMovementPattern
{
	[Tooltip("特效方向由速度决定，持续更新")]
	public bool useVelocityDir;

	public ConfigCompositeMove configCompositeMove;

	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		CompositeMovementRunner compositeMovementRunner = new CompositeMovementRunner();
		compositeMovementRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return compositeMovementRunner;
	}
}
