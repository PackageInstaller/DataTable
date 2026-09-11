using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI执行通用怪物追击指令", 0)]
[Category("Logic/AI")]
[Description("AI执行通用怪物追击指令")]
public class AIDoMonsterCommonApproachAction : FlowNode
{
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

	protected override void RegisterPorts()
	{
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<int> originInput = AddValueInput<int>("移动初始概率");
		ValueInput<int> delayIncrementTimeInput = AddValueInput<int>("延时概率增加时间");
		ValueInput<int> incrementInput = AddValueInput<int>("概率增量");
		ValueInput<int> incrementIntervalInput = AddValueInput<int>("概率增加间隔");
		ValueInput<int> resetTimeInput = AddValueInput<int>("概率重置时间");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			if (!simEntity.entityAIThink.mAICommandSet.TryGetValue(actionID.value, out var _))
			{
				AIMonsterCommonApproachCommand value2 = new AIMonsterCommonApproachCommand
				{
					mParent = null,
					mID = actionID.value,
					mTimeout = timeout.value,
					originInput = originInput.value,
					delayIncrementTimeInput = delayIncrementTimeInput.value,
					incrementInput = incrementInput.value,
					incrementIntervalInput = incrementIntervalInput.value,
					resetTimeInput = resetTimeInput.value
				};
				simEntity.entityAIThink.mAICommandSet[actionID.value] = value2;
			}
			simEntity.entityAIThink.mInterruptCommand = simEntity.entityAIThink.mAICommandSet[actionID.value];
			f.Call(output);
		});
	}
}
