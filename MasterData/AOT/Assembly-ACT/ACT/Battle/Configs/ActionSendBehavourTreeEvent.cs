using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("发送行为Tree事件", "Action", new string[] { "send", "behavour", "tree", "event", "ai", "bt", "behavior", "behaviour" })]
public class ActionSendBehavourTreeEvent : ConfigAction
{
	public string eventName;

	public bool useArg;

	public string stringArg;

	public override void Do(ActionMemory memory)
	{
		ActBehaviorTree actBehaviorTree = memory.target.entity.GetCompAI().ActBehaviorTree;
		if (memory.target.entity.IsActive() && actBehaviorTree != null)
		{
			if (useArg)
			{
				actBehaviorTree.SendEvent(eventName, (object)stringArg);
			}
			else
			{
				actBehaviorTree.SendEvent(eventName);
			}
		}
	}
}
