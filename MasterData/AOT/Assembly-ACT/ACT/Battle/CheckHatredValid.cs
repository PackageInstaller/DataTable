using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/废弃")]
[TaskDescription("获取一个合理的攻击目标")]
public class CheckHatredValid : Conditional
{
	public override TaskStatus OnUpdate()
	{
		if (!((ActBehaviorTree)Owner).Entity.GetCompHatred().GetHatred().IsValid)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
