using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断AI指令", "Predicate", new string[] { "check", "ai", "command", "predicate", "condition" })]
public class CheckAICommand : ConfigPredicate
{
	private const string AICommandList = "AICommandList";

	public string command;

	public override bool Check(ActionMemory memory)
	{
		ActBehaviorTree actBehaviorTree = memory.owner.GetCompAI().ActBehaviorTree;
		if (actBehaviorTree == null)
		{
			return false;
		}
		if (!(actBehaviorTree.GetVariable("AICommandList") is SharedAICommandList { Value: not null } sharedAICommandList))
		{
			return false;
		}
		if (sharedAICommandList.Value.TryPeek(out var result))
		{
			return result.command == command;
		}
		return false;
	}
}
