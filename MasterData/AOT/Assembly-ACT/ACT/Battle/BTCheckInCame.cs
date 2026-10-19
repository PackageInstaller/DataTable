using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("判断是否在相机内")]
public class BTCheckInCame : Conditional
{
	private Vector3 m_ViewportPosition;

	private Vector3 m_LeftViewPoint;

	private Vector3 m_RightViewPoint;

	public override TaskStatus OnUpdate()
	{
		Vector3 physicsPosition = Owner.ToEntity().GetCompTransform().physicsPosition;
		Camera main = Camera.main;
		m_ViewportPosition = main.WorldToViewportPoint(physicsPosition);
		m_LeftViewPoint = main.ViewportToWorldPoint(new Vector3(0f, 0.5f, 10f));
		m_RightViewPoint = main.ViewportToWorldPoint(new Vector3(1f, 0.5f, 10f));
		if (physicsPosition.x >= m_LeftViewPoint.x && physicsPosition.x <= m_RightViewPoint.x)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
