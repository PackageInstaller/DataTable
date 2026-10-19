using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ToFixedPosMovementRunner : TrajectoryMovementRunner
{
	protected Vector3 realTargetPos;

	protected float time;

	protected override void OnCreate()
	{
		ToFixedPosMovementPattern toFixedPosMovementPattern = (ToFixedPosMovementPattern)config;
		CompProduct compProduct = bullet.GetCompProduct();
		CompTransform compTransform = bullet.GetCompTransform();
		CompVelocity compVelocity = bullet.GetCompVelocity();
		time = toFixedPosMovementPattern.time;
		realTargetPos = toFixedPosMovementPattern.targetPos.Return(new ActionMemory(compProduct.caster, compProduct.productOwner, bullet, null, ability));
		Vector3 vector = realTargetPos - compTransform.physicsPosition;
		if (toFixedPosMovementPattern.fixedSpeed)
		{
			compVelocity.velocity = toFixedPosMovementPattern.speed * vector.normalized;
		}
		else if (toFixedPosMovementPattern.fixedTime)
		{
			compVelocity.velocity = ((toFixedPosMovementPattern.time == 0f) ? vector : (vector / toFixedPosMovementPattern.time));
		}
		if (toFixedPosMovementPattern.useVelocityDir)
		{
			if (toFixedPosMovementPattern.upwards)
			{
				compTransform.rotation = Quaternion.LookRotation(compVelocity.velocity, Vector3.up);
			}
			else
			{
				compTransform.rotation = Quaternion.FromToRotation(Vector3.forward, compVelocity.velocity);
			}
		}
		bullet.GetRootTransform().rotation = compTransform.rotation;
	}

	public override void FixedUpdate(float dt)
	{
		if (!bullet.IsActive())
		{
			return;
		}
		ToFixedPosMovementPattern toFixedPosMovementPattern = (ToFixedPosMovementPattern)config;
		CompProduct compProduct = bullet.GetCompProduct();
		Entity productOwner = compProduct.productOwner;
		CompTransform compTransform = bullet.GetCompTransform();
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompTime compTime = bullet.GetCompTime();
		bool flag = false;
		time -= dt;
		if (toFixedPosMovementPattern.updateTargetPos)
		{
			realTargetPos = toFixedPosMovementPattern.targetPos.Return(new ActionMemory(compProduct.caster, productOwner, bullet, null, ability));
		}
		Vector3 vector = realTargetPos - compTransform.physicsPosition;
		if (toFixedPosMovementPattern.fixedSpeed)
		{
			float num = vector.magnitude / dt;
			Vector3 normalized = vector.normalized;
			if (num < toFixedPosMovementPattern.speed)
			{
				compVelocity.velocity = normalized * num;
				flag = true;
			}
			else
			{
				compVelocity.velocity = normalized * toFixedPosMovementPattern.speed;
			}
		}
		else if (toFixedPosMovementPattern.fixedTime)
		{
			if (time > compTime.fixedDeltaTime)
			{
				compVelocity.velocity = vector.normalized * (vector.magnitude / time);
			}
			else
			{
				compVelocity.velocity = vector / dt;
				flag = true;
			}
		}
		(Vector3, Vector3, Quaternion) state = (compVelocity.velocity, compTransform.physicsPosition, compTransform.rotation);
		(Entity, Ability, float) message = (bullet, ability, dt);
		generalTrajectory.Evaluate(in message, in state, out (Vector3, Vector3, Quaternion) nextState);
		compTransform.UpdatePosition(nextState.Item2);
		if (toFixedPosMovementPattern.useVelocityDir)
		{
			if (toFixedPosMovementPattern.upwards)
			{
				compTransform.rotation = Quaternion.LookRotation(compVelocity.velocity, Vector3.up);
			}
			else
			{
				compTransform.rotation = Quaternion.FromToRotation(Vector3.forward, compVelocity.velocity);
			}
		}
		if (flag && !toFixedPosMovementPattern.arriveDontDie)
		{
			generalTrajectory.SetLifeEnd(bullet);
			SystemAbility.DoActions(compProduct.caster, productOwner, FindTargetResult.EntityOnly(bullet), null, ability, toFixedPosMovementPattern.onArriveTarget);
		}
	}

	public override void Update(float dt)
	{
		UpdatePositionInterpolation();
	}

	private bool CheckArriveFixedPos(Entity bulletEntity, Vector3 fixPos)
	{
		return Vector3.Distance(bulletEntity.GetCompTransform().physicsPosition, fixPos) <= 0.01f;
	}

	protected override void OnReset()
	{
	}
}
