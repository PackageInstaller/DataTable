using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("超过设定distance后每超过1m辅助机速度提升distanceSpeed")]
public class SetRobotVelocity : Action
{
	public SharedVector3 robotTarget;

	public float distance = 1.2f;

	public float distanceSpeed = 1.5f;

	private Entity m_Entity;

	private Vector3 m_Velocity;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		m_Velocity = new Vector3(distanceSpeed, 0f, 0f);
	}

	public override TaskStatus OnUpdate()
	{
		Vector3 value = robotTarget.Value;
		Vector3 physicsPosition = m_Entity.GetCompTransform().physicsPosition;
		float num = Mathf.Abs((value - physicsPosition).magnitude);
		if (num > distance)
		{
			m_Entity.GetCompPhysics().lastFramePathLocalVelocity += m_Velocity * num;
		}
		return TaskStatus.Success;
	}
}
