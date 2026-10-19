using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ParabolaMovementRunner : TrajectoryMovementRunner
{
	protected override void OnCreate()
	{
		ParabolaMovementPattern parabolaMovementPattern = (ParabolaMovementPattern)config;
		CompProduct compProduct = bullet.GetCompProduct();
		CompTransform compTransform = bullet.GetCompTransform();
		CompVelocity compVelocity = bullet.GetCompVelocity();
		Vector3 vector = parabolaMovementPattern.targetPos.Return(new ActionMemory(compProduct.caster, compProduct.productOwner, bullet, null, ability)) - compTransform.physicsPosition;
		Vector3 vector2 = Vector3.Project(vector, Physics.gravity);
		Vector3 vector3 = vector - vector2;
		float num = vector3.magnitude / parabolaMovementPattern.velocityXZ;
		Vector3 vector4;
		Vector3 vector5;
		if (num != 0f)
		{
			vector4 = vector3 / num;
			vector5 = vector2 / num - Physics.gravity * (0.5f * parabolaMovementPattern.gravityScale * num);
		}
		else
		{
			vector4 = Vector3.zero;
			vector5 = Vector3.zero - Physics.gravity * (0.5f * parabolaMovementPattern.gravityScale * num);
		}
		compVelocity.velocity = vector4 + vector5;
		if (parabolaMovementPattern.useVelocityDir)
		{
			compTransform.rotation = Quaternion.LookRotation(compVelocity.velocity, Vector3.up);
		}
		bullet.GetRootTransform().rotation = compTransform.rotation;
	}

	public override void FixedUpdate(float dt)
	{
		ParabolaMovementPattern parabolaMovementPattern = (ParabolaMovementPattern)config;
		CompTransform compTransform = bullet.GetCompTransform();
		CompVelocity compVelocity = bullet.GetCompVelocity();
		compVelocity.velocity += Physics.gravity * parabolaMovementPattern.gravityScale * dt;
		(Vector3, Vector3, Quaternion) state = (compVelocity.velocity, compTransform.physicsPosition, compTransform.rotation);
		(Entity, Ability, float) message = (bullet, ability, dt);
		generalTrajectory.Evaluate(in message, in state, out (Vector3, Vector3, Quaternion) nextState);
		compTransform.UpdatePosition(nextState.Item2);
		if (parabolaMovementPattern.useVelocityDir)
		{
			compTransform.rotation = Quaternion.LookRotation(compVelocity.velocity, Vector3.up);
		}
	}

	public override void Update(float dt)
	{
		UpdatePositionInterpolation();
	}

	protected override void OnReset()
	{
	}
}
