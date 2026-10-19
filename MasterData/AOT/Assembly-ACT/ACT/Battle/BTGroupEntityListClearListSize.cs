using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("清空队列")]
public class BTGroupEntityListClearListSize : Action
{
	[SharedRequired]
	public SharedEntityList list;

	public override TaskStatus OnUpdate()
	{
		list.Value.Clear();
		return TaskStatus.Success;
	}
}
