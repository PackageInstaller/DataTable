using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("组内成员发送事件给组AI")]
[TaskIcon("{SkinColor}SendEventIcon.png")]
public class BTSendEventToGroup : Action
{
	[Tooltip("The event to send")]
	public SharedString eventName;

	[Tooltip("Optionally specify a first argument to send")]
	[SharedRequired]
	public SharedVariable argument1;

	[Tooltip("Optionally specify a second argument to send")]
	[SharedRequired]
	public SharedVariable argument2;

	[Tooltip("Optionally specify a third argument to send")]
	[SharedRequired]
	public SharedVariable argument3;

	private BehaviorTree behaviorTree;

	public override void OnStart()
	{
		ActBehaviorTree actBehaviorTree = Owner as ActBehaviorTree;
		if (Singleton<GroupAIManager>.instance.GetGroupAI(actBehaviorTree.Entity.GetCompAI().groupUid, out var entity) && entity.IsValid)
		{
			behaviorTree = entity.GetCompAI().ActBehaviorTree;
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (behaviorTree == null)
		{
			return TaskStatus.Failure;
		}
		if (argument1 == null || argument1.IsNone)
		{
			behaviorTree.SendEvent(eventName.Value);
		}
		else if (argument2 == null || argument2.IsNone)
		{
			behaviorTree.SendEvent(eventName.Value, argument1.GetValue());
		}
		else if (argument3 == null || argument3.IsNone)
		{
			behaviorTree.SendEvent(eventName.Value, argument1.GetValue(), argument2.GetValue());
		}
		else
		{
			behaviorTree.SendEvent(eventName.Value, argument1.GetValue(), argument2.GetValue(), argument3.GetValue());
		}
		return TaskStatus.Success;
	}

	public override void OnReset()
	{
		eventName = "";
	}
}
