using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("清空队列中死亡的Entity")]
public class BTGroupEntityListDeleteDeadEntity : Action
{
	[SharedRequired]
	public SharedEntityList list;

	public override TaskStatus OnUpdate()
	{
		for (int num = list.Value.Count - 1; num >= 0; num--)
		{
			if (!list.Value[num].IsAlive())
			{
				list.Value.Remove(list.Value[num]);
			}
		}
		return TaskStatus.Success;
	}
}
