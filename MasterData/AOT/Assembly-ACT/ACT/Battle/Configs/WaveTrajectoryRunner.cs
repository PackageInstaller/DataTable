using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class WaveTrajectoryRunner : TrajectoryMovementRunner
{
	private Vector3 m_HoriVelocity;

	private float m_Time;

	private Vector3 m_VerticalDir;

	protected override void OnCreate()
	{
		WaveMovementPattern waveMovementPattern = (WaveMovementPattern)config;
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompTransform compTransform = bullet.GetCompTransform();
		compVelocity.velocity = (m_HoriVelocity = waveMovementPattern.initVelocity.GetVelocity(bullet, ability));
		if (waveMovementPattern.useVelocityDir)
		{
			compTransform.rotation = Quaternion.LookRotation(compVelocity.velocity, Vector3.up);
		}
		bullet.GetRootTransform().rotation = compTransform.rotation;
		m_VerticalDir = Vector3.Cross(-(compTransform.FaceRotation * Vector3.right), m_HoriVelocity).normalized;
	}

	public override void FixedUpdate(float dt)
	{
		WaveMovementPattern waveMovementPattern = (WaveMovementPattern)config;
		if (!bullet.IsActive())
		{
			return;
		}
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompTransform compTransform = bullet.GetCompTransform();
		CompTrajectory compTrajectory = bullet.GetCompTrajectory();
		float num = m_Time + dt * waveMovementPattern.speed;
		float num2 = waveMovementPattern.amplitude * Mathf.Cos(waveMovementPattern.angular * m_Time + waveMovementPattern.phase);
		float num3 = waveMovementPattern.amplitude * Mathf.Cos(waveMovementPattern.angular * num + waveMovementPattern.phase);
		Vector3 vector = ((dt == 0f) ? 0f : ((num3 - num2) / dt)) * m_VerticalDir;
		compVelocity.velocity = vector + m_HoriVelocity;
		if (waveMovementPattern.velocityModifiers != null)
		{
			Vector3 velocity = compVelocity.velocity;
			for (int i = 0; i < waveMovementPattern.velocityModifiers.Length; i++)
			{
				velocity = waveMovementPattern.velocityModifiers[i].Modify(velocity, dt, compTrajectory.life);
			}
			compVelocity.velocity = velocity;
		}
		(Vector3, Vector3, Quaternion) state = (compVelocity.velocity, compTransform.physicsPosition, compTransform.rotation);
		(Entity, Ability, float) message = (bullet, ability, dt);
		generalTrajectory.Evaluate(in message, in state, out (Vector3, Vector3, Quaternion) nextState);
		compTransform.UpdatePosition(nextState.Item2);
		if (waveMovementPattern.useVelocityDir)
		{
			compTransform.rotation = Quaternion.LookRotation(compVelocity.velocity, Vector3.up);
		}
		m_Time = num;
	}

	public override void Update(float dt)
	{
		UpdatePositionInterpolation();
	}

	protected override void OnReset()
	{
	}
}
