using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("广播仇恨目标给组成员, 有没有仇恨目标都返回成功")]
public class BTBroadcastHatred : Action
{
	public override TaskStatus OnUpdate()
	{
		if (!(Owner is ActBehaviorTree actBehaviorTree) || !actBehaviorTree.Entity.GetCompHatred().hatredTarget.IsValid)
		{
			return TaskStatus.Success;
		}
		if (Singleton<GroupAIManager>.instance.GetGroupAI(actBehaviorTree.Entity.GetCompAI().groupUid, out var entity) && entity.IsValid)
		{
			foreach (Entity item in entity.GetCompGroupAI().GetChildrenEntity())
			{
				item.SetHatred(actBehaviorTree.Entity.GetCompHatred().hatredTarget);
			}
		}
		return TaskStatus.Success;
	}
}
