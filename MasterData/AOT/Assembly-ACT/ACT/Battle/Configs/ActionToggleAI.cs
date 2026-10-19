using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("切换AI", "Action", new string[] { "toggle", "ai", "bt", "behavior", "behaviour" })]
public class ActionToggleAI : ConfigAction
{
	public bool on;

	public override void Do(ActionMemory memory)
	{
		ActBehaviorTree actBehaviorTree = memory.target.entity.GetCompAI().ActBehaviorTree;
		if ((object)actBehaviorTree != null)
		{
			if (on && actBehaviorTree.ExecutionStatus != TaskStatus.Running)
			{
				actBehaviorTree.Resume();
			}
			if (!on && actBehaviorTree.ExecutionStatus == TaskStatus.Running)
			{
				actBehaviorTree.Pause();
			}
		}
	}
}
