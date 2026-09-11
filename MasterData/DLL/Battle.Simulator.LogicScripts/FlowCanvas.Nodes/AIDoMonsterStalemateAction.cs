using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI执行通用怪物对峙指令", 0)]
[Category("Logic/AI")]
[Description("AI执行通用怪物对峙指令")]
public class AIDoMonsterStalemateAction : FlowNode
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
		ValueInput<int> actionID = AddValueInput<int>("对峙ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<int> moveTimeInput = AddValueInput<int>("移动时间");
		ValueInput<int> speedFactorInput = AddValueInput<int>("速度百分比");
		ValueInput<int> minWaitTimeInput = AddValueInput<int>("最小停步时间");
		ValueInput<int> deltaProbabilityInput = AddValueInput<int>("移动概率增量");
		ValueInput<Int> startAngleInput = AddValueInput<Int>("起始角度");
		ValueInput<Int> endAngleInput = AddValueInput<Int>("结束角度");
		ValueInput<int> intervalInput = AddValueInput<int>("判定间隔").SetDefaultAndSerializedValue(1000);
		AddValueOutput("动作ID", () => actionID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			if (!simEntity.entityAIThink.mAICommandSet.TryGetValue(actionID.value, out var _))
			{
				AIMonsterStalemateCommand value2 = new AIMonsterStalemateCommand
				{
					mParent = null,
					mID = actionID.value,
					mTimeout = timeout.value,
					moveTimeInput = moveTimeInput.value,
					speedFactorInput = speedFactorInput.value,
					minWaitTimeInput = minWaitTimeInput.value,
					deltaProbabilityInput = deltaProbabilityInput.value,
					startAngleInput = startAngleInput.value.i,
					endAngleInput = endAngleInput.value.i,
					intervalInput = intervalInput.value
				};
				simEntity.entityAIThink.mAICommandSet[actionID.value] = value2;
			}
			simEntity.entityAIThink.mInterruptCommand = simEntity.entityAIThink.mAICommandSet[actionID.value];
			f.Call(output);
		});
	}
}
