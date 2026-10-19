using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("判断有没有攻击权限，如果不受组AI控制，那就一直有权限 ,有权限返回成功，没有返回失败")]
public class CheckHasAttackToken : Conditional
{
	public override TaskStatus OnUpdate()
	{
		Entity entity = (Owner as ActBehaviorTree).Entity;
		if (entity.GetCompAI().NeedGroupAIControl())
		{
			if (entity.GetCompAI().HasAttackToken())
			{
				return TaskStatus.Success;
			}
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
