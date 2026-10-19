using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("获取队列的大小")]
public class BTGroupEntityListGetListSize : Action
{
	[SharedRequired]
	public SharedEntityList list;

	public SharedInt listSizee;

	public override TaskStatus OnUpdate()
	{
		listSizee.Value = list.Value.Count;
		return TaskStatus.Success;
	}
}
