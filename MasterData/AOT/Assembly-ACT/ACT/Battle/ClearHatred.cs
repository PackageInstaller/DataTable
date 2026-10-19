using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/仇恨")]
[TaskDescription("释放仇恨目标,同时将battleState设为false")]
public class ClearHatred : Action
{
	public override TaskStatus OnUpdate()
	{
		((ActBehaviorTree)Owner).Entity.SetHatred(default);
		return TaskStatus.Success;
	}
}
