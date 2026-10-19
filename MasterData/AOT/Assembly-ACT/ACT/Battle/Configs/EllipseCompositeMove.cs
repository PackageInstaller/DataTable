using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class EllipseCompositeMove : CompositeMoveBase
{
	private float currentAngle;

	private float time;

	private EllipseConfigCompositeMove m_EllipseConfig;

	public EllipseCompositeMove(EllipseConfigCompositeMove ellipseConfig)
	{
		m_EllipseConfig = ellipseConfig;
	}

	protected override void RuntimeGeneralTrajectory(Entity bullet, Ability ability, RuntimeGeneralTrajectory generalTrajectory)
	{
		currentAngle = 0f;
		time = 0f;
	}

	public override void FixedUpdate(float deltaTime)
	{
		time += deltaTime;
		float num = m_EllipseConfig.speedCurve.Evaluate(time / 360f);
		currentAngle += num * deltaTime;
		float t = currentAngle + m_EllipseConfig.phase;
		m_Position = GetEllipsePosition(t);
		m_Rotation = Quaternion.LookRotation(GetEllipseDirection(t));
	}

	private Vector3 GetEllipsePosition(float t)
	{
		float x = m_EllipseConfig.semiMajorAxis.Return(ActionMemory()) * Mathf.Cos(t);
		float z = m_EllipseConfig.semiMinorAxis.Return(ActionMemory()) * Mathf.Sin(t);
		return new Vector3(x, 0f, z);
	}

	private Vector3 GetEllipseDirection(float t)
	{
		float x = (0f - m_EllipseConfig.semiMajorAxis.Return(ActionMemory())) * Mathf.Sin(t);
		float z = m_EllipseConfig.semiMinorAxis.Return(ActionMemory()) * Mathf.Cos(t);
		return new Vector3(x, 0f, z).normalized;
	}
}
