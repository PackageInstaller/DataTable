using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("删除队列中特定的Entity")]
public class BTGroupEntityListDelete : Action
{
	[SharedRequired]
	public SharedEntityList list;

	[SharedRequired]
	public SharedEntity res;

	public bool deleteFront;

	public bool deleteBack;

	public override TaskStatus OnUpdate()
	{
		if (list.Value.Count == 0)
		{
			return TaskStatus.Failure;
		}
		if (deleteFront)
		{
			list.Value.RemoveAt(0);
		}
		else if (deleteBack)
		{
			list.Value.RemoveAt(list.Value.Count - 1);
		}
		else
		{
			list.Value.Remove(res.Value);
		}
		return TaskStatus.Success;
	}
}
