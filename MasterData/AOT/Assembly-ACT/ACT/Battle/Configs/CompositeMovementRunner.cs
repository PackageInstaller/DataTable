using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class CompositeMovementRunner : TrajectoryMovementRunner
{
	protected CompositeMoveBase compositeMove;

	protected override void OnCreate()
	{
		CompositeMovementPattern compositeMovementPattern = (CompositeMovementPattern)config;
		compositeMove = compositeMovementPattern.configCompositeMove.CreateInstance();
		compositeMove.Create(bullet, ability, generalTrajectory);
	}

	public override void FixedUpdate(float dt)
	{
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompTransform compTransform = bullet.GetCompTransform();
		if (bullet.IsActive())
		{
			CompositeMovementPattern compositeMovementPattern = (CompositeMovementPattern)config;
			compositeMove.FixedUpdate(dt);
			compVelocity.velocity = (compositeMove.Position - compTransform.physicsPosition) / dt;
			(Vector3, Vector3, Quaternion) state = (compVelocity.velocity, compTransform.colliderPosition, compTransform.rotation);
			(Entity, Ability, float) message = (bullet, ability, dt);
			generalTrajectory.Evaluate(in message, in state, out (Vector3, Vector3, Quaternion) nextState);
			compTransform.UpdatePosition(nextState.Item2);
			if (compositeMovementPattern.useVelocityDir)
			{
				compTransform.rotation = Quaternion.FromToRotation(Vector3.forward, compVelocity.velocity);
			}
			else
			{
				compTransform.rotation = compositeMove.Rotation;
			}
		}
	}

	public override void Update(float dt)
	{
		UpdatePositionInterpolation();
	}

	protected override void OnReset()
	{
		compositeMove = null;
	}
}
