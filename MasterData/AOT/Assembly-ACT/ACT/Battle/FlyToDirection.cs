using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/移动")]
[TaskDescription("沿着方向飞行")]
public class FlyToDirection : Action
{
	[Tooltip("移动方向（局部坐标系）")]
	public SharedVector3 direction;

	private Entity m_Entity;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		m_Entity.GetCompInput().dir = direction.Value;
		return TaskStatus.Running;
	}
}
