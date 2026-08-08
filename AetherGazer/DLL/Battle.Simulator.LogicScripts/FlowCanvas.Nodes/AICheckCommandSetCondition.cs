using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI执行指令集条件", 0)]
[Category("Logic/AI")]
[Description("AI执行指令集条件")]
public class AICheckCommandSetCondition : FlowNode
{
	private ValueInput<int> commandSetID;

	protected override void RegisterPorts()
	{
		commandSetID = AddValueInput<int>("指令集ID");
		FlowOutput true_output = AddFlowOutput("true");
		FlowOutput false_output = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			simEntity.entityAIThink.mReevalute = false;
			if (simEntity.entityAIThink.mAICommandSet.TryGetValue(commandSetID.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				aICommandSet.mCurrent %= aICommandSet.mCommands.Count;
				base.mSimContext.GetSimInterface().mAICommandSetConditionEvent?.Invoke(simEntity.creationIndex, aICommandSet, simEntity.entityConfig.mId);
				if (!simEntity.entityAIThink.mReevalute)
				{
					f.Call(true_output);
				}
				else
				{
					f.Call(false_output);
				}
			}
		});
	}
}
