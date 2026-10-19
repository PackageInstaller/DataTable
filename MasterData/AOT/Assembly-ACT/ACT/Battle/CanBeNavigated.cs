using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine.AI;

namespace ACT.Battle;

[TaskCategory("ACT/应该要废弃的")]
[TaskDescription("辅助机能导航就返还Success,不能就Failure")]
public class CanBeNavigated : Conditional
{
	public SharedVector2 targetPos;

	private CompNav m_CompNav;

	private Entity m_Robot;

	public override void OnStart()
	{
		m_Robot = ((ActBehaviorTree)Owner).Entity;
		m_CompNav = m_Robot.GetCompNav();
	}

	public override TaskStatus OnUpdate()
	{
		if (m_CompNav.pathStatus != NavMeshPathStatus.PathInvalid)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
