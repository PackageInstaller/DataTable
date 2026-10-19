using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("空中单位 飞向目标点")]
public class BTFlyMoveToPosition : Action
{
	[BehaviorDesigner.Runtime.Tasks.Tooltip("输入位置")]
	public SharedVector3 position;

	private Entity m_Entity;

	private CompNav m_CompNav;

	private CompTransform m_CompTransform;

	private CompInput m_CompInput;

	public override void OnStart()
	{
		m_Entity = Owner.ToEntity();
		m_CompNav = m_Entity.GetCompNav();
		m_CompTransform = m_Entity.GetCompTransform();
		m_CompInput = m_Entity.GetCompInput();
	}

	public override TaskStatus OnUpdate()
	{
		if (!m_Entity.GetCompAI().TryCommitCombatMoveDestination(m_CompNav, position.Value, "BTFlyMoveToPosition"))
		{
			m_CompInput.dir = Vector3.zero;
			return TaskStatus.Success;
		}
		if (m_CompNav.isArrived)
		{
			m_CompInput.dir = Vector3.zero;
			return TaskStatus.Success;
		}
		m_CompInput.dir = (position.Value - m_CompTransform.physicsPosition).normalized;
		return TaskStatus.Running;
	}
}
