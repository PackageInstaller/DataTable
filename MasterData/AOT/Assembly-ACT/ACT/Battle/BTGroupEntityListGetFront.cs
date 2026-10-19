using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("获取队列首部的Entity， 当needDelete==True时，会同时删除队列首部的Entity")]
public class BTGroupEntityListGetFront : Action
{
	[SharedRequired]
	public SharedEntityList list;

	[SharedRequired]
	public SharedEntity res;

	public bool needDelete;

	public override TaskStatus OnUpdate()
	{
		if (list.Value.Count == 0)
		{
			return TaskStatus.Failure;
		}
		res.Value = list.Value[0];
		if (needDelete)
		{
			list.Value.Remove(res.Value);
		}
		return TaskStatus.Success;
	}
}
