using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("玩家的当前出战角色是否在Timeline中， 在Timeline中就返回false， 不在Timeline中就返回True")]
public class CheckMainEntityInTimeline : Conditional
{
	private Entity m_entity;

	public override void OnStart()
	{
		m_entity = (Owner as ActBehaviorTree).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity != null)
		{
			if (mainEntity.GetMotionBool("InTimeline"))
			{
				return TaskStatus.Failure;
			}
			return TaskStatus.Success;
		}
		return TaskStatus.Success;
	}
}
