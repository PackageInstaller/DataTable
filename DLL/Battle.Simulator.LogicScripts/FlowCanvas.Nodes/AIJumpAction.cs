using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("AI跳转指令集步骤", 0)]
[Category("Logic/AI")]
[Description("AI跳转指令直接跳跃到指令集的指定步骤,只能")]
public class AIJumpAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("实体ID");
		ValueInput<int> actionID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionStep = AddValueInput<int>("步骤");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = actionID.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID.value);
			if (entityWithEntityID.entityAIThink.mCurrentCommand != null && entityWithEntityID.entityAIThink.mCurrentCommand.mID == value && entityWithEntityID.entityAIThink.mCurrentCommand.mStatus == AIProcessor.AICommandStatus.Running)
			{
				int value2 = actionStep.value;
				AICommandSet aICommandSet = (AICommandSet)entityWithEntityID.entityAIThink.mCurrentCommand;
				if (aICommandSet.mCommands.Count <= value2)
				{
					Debug.LogError(string.Format(base.graph.name + "指令集{0}步骤大于跳转步骤,当前指令集合只有{1}指令 ", value, aICommandSet.mCommands.Count));
					return;
				}
				aICommandSet.JumpStep(value2);
			}
			f.Call(output);
		});
	}
}
