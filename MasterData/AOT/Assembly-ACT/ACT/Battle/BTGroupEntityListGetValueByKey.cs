using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("通过序号获取到 队列中的特定值")]
public class BTGroupEntityListGetValueByKey : Action
{
	[SharedRequired]
	public SharedEntityList list;

	public SharedInt key;

	[SharedRequired]
	public SharedEntity res;

	public override TaskStatus OnUpdate()
	{
		res.Value = list.Value[key.Value];
		return TaskStatus.Success;
	}
}
