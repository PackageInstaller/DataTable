using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("组AI给组内成员发送行为树")]
[TaskIcon("{SkinColor}SendEventIcon.png")]
public class BTGroupSendEvent : Action
{
	[Tooltip("是否发送给group内所有成员")]
	public bool sendAllChildren;

	public bool sendToEntityList;

	[SharedRequired]
	public SharedEntityList targetEntityList;

	[Tooltip("发送事件的目标entity")]
	[SharedRequired]
	public SharedEntity targetEntity;

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

	private List<BehaviorTree> behaviorTrees;

	public override void OnAwake()
	{
		behaviorTrees = new List<BehaviorTree>();
		base.OnAwake();
	}

	public override void OnStart()
	{
		behaviorTrees.Clear();
		if (sendAllChildren)
		{
			ActBehaviorTree actBehaviorTree = Owner as ActBehaviorTree;
			if (!actBehaviorTree)
			{
				return;
			}
			{
				foreach (Entity item in actBehaviorTree.Entity.GetCompGroupAI().GetChildrenEntity())
				{
					ActBehaviorTree actBehaviorTree2 = item.GetCompAI().ActBehaviorTree;
					if ((object)actBehaviorTree2 != null)
					{
						behaviorTrees.Add(actBehaviorTree2);
					}
				}
				return;
			}
		}
		if (!sendToEntityList)
		{
			if (targetEntity != null && targetEntity.Value.TryGetCompAI(out CompAI component))
			{
				behaviorTrees.Add(component.ActBehaviorTree);
			}
			return;
		}
		foreach (Entity item2 in targetEntityList.Value)
		{
			if (item2.TryGetCompAI(out CompAI component2))
			{
				behaviorTrees.Add(component2.ActBehaviorTree);
			}
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (argument1 == null || argument1.IsNone)
		{
			foreach (BehaviorTree behaviorTree in behaviorTrees)
			{
				behaviorTree.SendEvent(eventName.Value);
			}
		}
		else if (argument2 == null || argument2.IsNone)
		{
			foreach (BehaviorTree behaviorTree2 in behaviorTrees)
			{
				behaviorTree2.SendEvent(eventName.Value, argument1.GetValue());
			}
		}
		else if (argument3 == null || argument3.IsNone)
		{
			foreach (BehaviorTree behaviorTree3 in behaviorTrees)
			{
				behaviorTree3.SendEvent(eventName.Value, argument1.GetValue(), argument2.GetValue());
			}
		}
		else
		{
			foreach (BehaviorTree behaviorTree4 in behaviorTrees)
			{
				behaviorTree4.SendEvent(eventName.Value, argument1.GetValue(), argument2.GetValue(), argument3.GetValue());
			}
		}
		return TaskStatus.Success;
	}

	public override void OnReset()
	{
		eventName = "";
	}
}
