using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class RotateCompositeMove : CompositeMoveBase
{
	private RotateConfigCompositeMove m_RotateConfig;

	private float deltaAngle;

	private float totalTime;

	public RotateCompositeMove(RotateConfigCompositeMove rotateConfig)
	{
		m_RotateConfig = rotateConfig;
	}

	protected override void RuntimeGeneralTrajectory(Entity bullet, Ability ability, RuntimeGeneralTrajectory generalTrajectory)
	{
		m_Position = Vector3.zero;
		m_Rotation = Quaternion.identity;
		deltaAngle = m_RotateConfig.angleRange.y - m_RotateConfig.angleRange.x;
		totalTime = 0f;
	}

	public override void FixedUpdate(float deltaTime)
	{
		totalTime += deltaTime;
		float num = m_RotateConfig.angleDegreeSpeed * totalTime;
		if (m_RotateConfig.hasRange)
		{
			num -= m_RotateConfig.angleRange.x;
			float num2 = num % deltaAngle;
			num = (((int)(num / deltaAngle) % 2 != 0) ? (m_RotateConfig.angleRange.y - num2) : (m_RotateConfig.angleRange.x + num2));
		}
		if (m_RotateConfig.reverse)
		{
			num = 0f - num;
		}
		m_Rotation = Quaternion.AngleAxis(num, m_RotateConfig.axis);
	}
}
