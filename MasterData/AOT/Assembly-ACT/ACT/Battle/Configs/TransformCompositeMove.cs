using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class TransformCompositeMove : CompositeMoveBase
{
	private TransformConfigCompositeMove m_TransformConfig;

	private CompositeMoveBase parentMove;

	private CompositeMoveBase childMove;

	public TransformCompositeMove(TransformConfigCompositeMove transformConfig)
	{
		m_TransformConfig = transformConfig;
		childMove = transformConfig.childMove.CreateInstance();
		parentMove = transformConfig.parentMove.CreateInstance();
	}

	protected override void RuntimeGeneralTrajectory(Entity bullet, Ability ability, RuntimeGeneralTrajectory generalTrajectory)
	{
		parentMove?.Create(bullet, ability, generalTrajectory);
		childMove.Create(bullet, ability, generalTrajectory);
	}

	public override void FixedUpdate(float deltaTime)
	{
		parentMove?.FixedUpdate(deltaTime);
		childMove.FixedUpdate(deltaTime);
		if (parentMove != null)
		{
			Quaternion quaternion = parentMove.Rotation * Quaternion.Euler(m_TransformConfig.localEulerAngles);
			m_Rotation = quaternion * childMove.Rotation;
			m_Position = quaternion * (childMove.Position + m_TransformConfig.localPosition) + parentMove.Position;
		}
		else
		{
			m_Rotation = childMove.Rotation * Quaternion.Euler(m_TransformConfig.localEulerAngles);
			m_Position = childMove.Position + m_TransformConfig.localPosition;
		}
	}
}
