using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("怪物对于 组AI的一些初始化")]
public class BTGroupAIInit : Action
{
	public override void OnStart()
	{
	}

	public override void OnEnd()
	{
	}

	public override TaskStatus OnUpdate()
	{
		CompAI compAI = ((ActBehaviorTree)Owner).Entity.GetCompAI();
		if (compAI.NeedGroupAIControl())
		{
			compAI.SetAttackToken(res: false);
		}
		else
		{
			compAI.SetAttackToken(res: true);
		}
		return TaskStatus.Success;
	}
}
