using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("返回失败")]
public class ReturnFailureAction : Action
{
	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Failure;
	}
}
