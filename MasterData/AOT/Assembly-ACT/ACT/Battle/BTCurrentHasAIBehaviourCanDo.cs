using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("当前是否有行为可以执行")]
public class BTCurrentHasAIBehaviourCanDo : Conditional
{
	public SharedAIBehaviourList canDoBehaviourList;

	public SharedAIBehaviourList canDoBehaviourList1;

	private Entity m_entity;

	public override void OnStart()
	{
		m_entity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		if (m_entity.GetCompAI().HasPendingAttackRequest())
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
