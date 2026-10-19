using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/可用的")]
[TaskDescription("判断怪点配置的脱战范围内有没有玩家（不仅是仇恨目标），有玩家返回True，没有玩家返回False， 具体的脱战范围逻辑见行为树节点文档")]
public class IsPlayerLoseBattle : Conditional
{
	protected Entity m_Entity;

	public override void OnStart()
	{
		m_Entity = (Owner as ActBehaviorTree).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		Entity playerCanBeLoseBattle = m_Entity.GetCompAI().GetPlayerCanBeLoseBattle();
		if (playerCanBeLoseBattle.IsValid)
		{
			m_Entity.SetHatred(playerCanBeLoseBattle);
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
