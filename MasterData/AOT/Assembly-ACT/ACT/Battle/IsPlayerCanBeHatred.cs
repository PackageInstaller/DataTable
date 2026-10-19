using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/可用的")]
[TaskDescription("判断怪点的仇恨范围内有没有玩家，有则返回success并将玩家设为仇恨目标，没有返回failure， 具体的仇恨范围逻辑见行为树节点文档")]
public class IsPlayerCanBeHatred : Conditional
{
	protected Entity m_Entity;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		if (m_Entity.IsLogicAvailable() && m_Entity.TryGetCompAI(out CompAI component))
		{
			Entity playerCanBeHatred = component.GetPlayerCanBeHatred();
			if (playerCanBeHatred.IsValid && playerCanBeHatred.IsLogicAvailable())
			{
				m_Entity.SetHatred(playerCanBeHatred);
				return TaskStatus.Success;
			}
		}
		return TaskStatus.Failure;
	}
}
