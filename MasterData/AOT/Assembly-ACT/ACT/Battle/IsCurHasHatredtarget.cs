using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/可用的")]
[TaskDescription("当前是否有仇恨目标")]
public class IsCurHasHatredtarget : Conditional
{
	protected Entity m_Entity;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		if (m_Entity.GetCompHatred().HasHatredTarget())
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
