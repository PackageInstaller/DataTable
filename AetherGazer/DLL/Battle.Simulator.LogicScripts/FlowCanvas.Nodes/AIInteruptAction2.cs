using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI中断指令(立即终止)", 0)]
[Category("Logic/AI")]
[Description("AI尝试中断当前正在运行的指令或者指令集，并将AI的条件判断设置为失败，不会重新决策, 指令集ID为0时不作为过滤条件\n将立刻终止当前正在运行的指令集以及指令，但不会强行打断当前正在执行的动作。\n本节点适用于【AI指令事件】中的【前置条件】分支内使用")]
public class AIInteruptAction2 : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("实体ID");
		ValueInput<int> actionID = AddValueInput<int>("指令集ID");
		AddValueOutput("实体ID", () => entityID.value);
		AddValueOutput("指令集ID", () => actionID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = actionID.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID.value);
			if (entityWithEntityID.entityAIThink.mCurrentCommand != null && (entityWithEntityID.entityAIThink.mCurrentCommand.mID == value || value == 0) && entityWithEntityID.entityAIThink.mCurrentCommand.mStatus == AIProcessor.AICommandStatus.Running)
			{
				entityWithEntityID.entityAIThink.mCurrentCommand.mForceInterruptSelf = true;
				entityWithEntityID.entityAIThink.mCurrentCommand.mStatus = AIProcessor.AICommandStatus.Failed;
				if (entityWithEntityID.entityAIThink.mCurrentCommand is AICommandSet aICommandSet)
				{
					aICommandSet.mCommands[aICommandSet.mCurrent].mStatus = AIProcessor.AICommandStatus.Failed;
					aICommandSet.mCommands[aICommandSet.mCurrent].mForceInterruptSelf = true;
				}
			}
			entityWithEntityID.entityAIThink.mReevalute = true;
			f.Call(output);
		});
	}
}
