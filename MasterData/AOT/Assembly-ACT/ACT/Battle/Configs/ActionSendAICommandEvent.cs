using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("发送AI指令事件", "Action", new string[] { "send", "ai", "command", "event", "bt", "behavior", "behaviour" })]
public class ActionSendAICommandEvent : ConfigAction
{
	private const string eventName = "AICommandEvent";

	public string command;

	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		ActBehaviorTree actBehaviorTree = entity.GetCompAI().ActBehaviorTree;
		if (entity.IsActive() && !(actBehaviorTree == null) && !string.IsNullOrEmpty(command))
		{
			AICommandData arg = AICommandData.Get(command);
			actBehaviorTree.SendEvent("AICommandEvent", (object)arg);
		}
	}
}
