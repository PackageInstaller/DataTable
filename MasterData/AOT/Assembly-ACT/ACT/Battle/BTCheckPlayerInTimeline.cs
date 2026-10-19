using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("检查玩家是否在Timeline内")]
public class BTCheckPlayerInTimeline : Conditional
{
	public override TaskStatus OnUpdate()
	{
		if (MonoECS.instance.InPlayerTag(MonoECS.PlayerTag.Timeline))
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
