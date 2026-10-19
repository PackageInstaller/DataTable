using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class GeneralMovementRunner : TrajectoryMovementRunner
{
	protected Quaternion m_Rotation;

	private float totalTime;

	protected override void OnCreate()
	{
		GeneralMovementPattern generalMovementPattern = (GeneralMovementPattern)config;
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompTransform compTransform = bullet.GetCompTransform();
		compVelocity.velocity = GetTrajectoryInitVelocity(bullet, ability, generalMovementPattern.initSpeed, generalMovementPattern.attachPoint, generalMovementPattern.initVelocityMode);
		if (generalMovementPattern.useVelocityDir)
		{
			compTransform.rotation = Quaternion.LookRotation(compVelocity.velocity, Vector3.up);
		}
		if (generalMovementPattern.initRotate != Vector3.zero)
		{
			compTransform.rotation *= Quaternion.Euler(generalMovementPattern.initRotate);
		}
		bullet.GetRootTransform().rotation = compTransform.rotation;
		if (generalMovementPattern.useRotate)
		{
			m_Rotation = Quaternion.identity;
		}
		totalTime = 0f;
	}

	public static Vector3 GetTrajectoryInitVelocity(Entity eb, Ability ability, Vector3 initSpeed, string attachPoint, InitVelocityMode mode)
	{
		Vector3 result = Vector3.zero;
		switch (mode)
		{
		case InitVelocityMode.UseOwnerCoordinate:
		{
			Entity productOwner = eb.GetCompProduct().productOwner;
			result = ((!productOwner.TryGetCompPhysics(out CompPhysics component)) ? (productOwner.GetCompTransform().rotation * initSpeed) : (component.faceDirRot * initSpeed));
			break;
		}
		case InitVelocityMode.UseSelfCoordinate:
			result = eb.GetCompTransform().rotation * initSpeed;
			break;
		case InitVelocityMode.UseAim:
		{
			Vector3 toDirection = eb.GetCompAim().aimTargetPosition - eb.GetCompTransform().physicsPosition;
			result = Quaternion.FromToRotation(Vector3.forward, toDirection) * initSpeed;
			break;
		}
		case InitVelocityMode.UseAttachPoint:
			if (!string.IsNullOrEmpty(attachPoint))
			{
				if (ability.caster.GetMono().TryGetAttachPointAll(attachPoint, out var attachPoint2))
				{
					Vector3 forward = attachPoint2.GetForward();
					result = Quaternion.FromToRotation(Vector3.forward, forward) * initSpeed;
				}
				else if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"子弹{eb} 的发射者{ability.caster} 没有attach point {attachPoint}");
				}
			}
			break;
		case InitVelocityMode.UseInheritanceSpeed:
			result = Quaternion.Euler(eb.GetCompVelocity().velocity) * initSpeed;
			break;
		default:
			throw new ArgumentOutOfRangeException("mode", mode, null);
		}
		return result;
	}

	public override void FixedUpdate(float dt)
	{
		GeneralMovementPattern generalMovementPattern = (GeneralMovementPattern)config;
		if (!bullet.IsActive())
		{
			return;
		}
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompTrajectory compTrajectory = bullet.GetCompTrajectory();
		CompTransform compTransform = bullet.GetCompTransform();
		if (generalMovementPattern.velocityModifiers != null)
		{
			Vector3 velocity = compVelocity.velocity;
			for (int i = 0; i < generalMovementPattern.velocityModifiers.Length; i++)
			{
				velocity = generalMovementPattern.velocityModifiers[i].Modify(velocity, dt, compTrajectory.life);
			}
			compVelocity.velocity = velocity;
		}
		if (generalMovementPattern.useRotate)
		{
			FixedUpdateRotation(dt);
		}
		(Vector3, Vector3, Quaternion) state = (compVelocity.velocity, compTransform.physicsPosition, compTransform.rotation);
		(Entity, Ability, float) message = (bullet, ability, dt);
		generalTrajectory.Evaluate(in message, in state, out (Vector3, Vector3, Quaternion) nextState);
		compTransform.UpdatePosition(nextState.Item2);
		if (generalMovementPattern.useVelocityDir && !generalMovementPattern.useRotate)
		{
			compTransform.rotation = Quaternion.LookRotation(compVelocity.velocity, Vector3.up);
		}
	}

	public void FixedUpdateRotation(float deltaTime)
	{
		GeneralMovementPattern generalMovementPattern = (GeneralMovementPattern)config;
		totalTime += deltaTime;
		float angle = generalMovementPattern.angleDegreeSpeed * deltaTime;
		m_Rotation = Quaternion.AngleAxis(angle, generalMovementPattern.axis);
		bullet.GetCompTransform().rotation *= m_Rotation;
	}

	public override void Update(float dt)
	{
		UpdatePositionInterpolation();
	}

	protected override void OnReset()
	{
	}
}
