using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI执行指令集", 0)]
[Category("Logic/AI")]
[Description("AI执行指令集")]
public class AIDoCommandSet : FlowNode
{
	private ValueInput<int> commandStep;

	private ValueInput<int> commandSetID;

	protected override void RegisterPorts()
	{
		commandSetID = AddValueInput<int>("指令集ID");
		commandStep = AddValueInput<int>("第几步");
		FlowOutput true_output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			int value = commandSetID.value;
			simEntity.entityAIThink.mInterruptCommand = simEntity.entityAIThink.mAICommandSet[value];
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2216, value, 0L, 0L);
			base.status = Status.Running;
			f.Call(true_output);
		});
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAICommandResetEvent = (Action<int, AIProcessor.AICommandStatus>)Delegate.Combine(simInterface.mAICommandResetEvent, new Action<int, AIProcessor.AICommandStatus>(OnAICommandResetEventHandler));
	}

	private void OnAICommandResetEventHandler(int entityID, AIProcessor.AICommandStatus lastStatus)
	{
		if (lastStatus == AIProcessor.AICommandStatus.Failed)
		{
			base.status = Status.Failure;
		}
		else
		{
			base.status = Status.Resting;
		}
	}
}
