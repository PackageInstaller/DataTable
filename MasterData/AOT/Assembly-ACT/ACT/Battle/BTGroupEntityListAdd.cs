using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("在队列尾部新增")]
public class BTGroupEntityListAdd : Action
{
	[SharedRequired]
	public SharedEntity value;

	[SharedRequired]
	public SharedEntityList list;

	public override TaskStatus OnUpdate()
	{
		if (!list.Value.Contains(value.Value))
		{
			list.Value.Add(value.Value);
		}
		return TaskStatus.Success;
	}
}
