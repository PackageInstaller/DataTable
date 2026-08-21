using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI执行队友跟随指令", 0)]
[Category("Logic/AI")]
[Description("队友跟随指令")]
public class AIDoFollowPlayerCommand : FlowNode
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
		ValueInput<int> followDistanceBasePartInput = AddValueInput<int>("跟随距离基础值");
		ValueInput<int> followDistanceRandomPtInput = AddValueInput<int>("跟随距离随机值");
		ValueInput<int> lerpMinDistanceInput = AddValueInput<int>("插值距离最小值");
		ValueInput<int> lerpMaxDistanceInput = AddValueInput<int>("插值距离最大值");
		ValueInput<int> speedFactorMiniInput = AddValueInput<int>("最小速度阈值");
		ValueInput<int> speedFactorMaxiInput = AddValueInput<int>("最大速度阈值");
		ValueInput<Int> followOffsetAngleInput = AddValueInput<Int>("偏移角度");
		ValueInput<int> followOffsetDistanceInput = AddValueInput<int>("偏移距离");
		ValueInput<int> startMoveDistanceInput = AddValueInput<int>("开始移动的距离阈值");
		AddValueOutput("动作ID", () => actionID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			if (!simEntity.entityAIThink.mAICommandSet.TryGetValue(actionID.value, out var _))
			{
				AIFollowTargetCommand value2 = new AIFollowTargetCommand
				{
					mParent = null,
					mID = actionID.value,
					mTimeout = timeout.value,
					mDisanceBase = followDistanceBasePartInput.value,
					mDistanceRandomOffset = followDistanceRandomPtInput.value,
					mLerpMinDistance = lerpMinDistanceInput.value,
					mLerpMaxDistance = lerpMaxDistanceInput.value,
					mSpeedFactorMini = speedFactorMiniInput.value,
					mSpeedFactorMaxi = speedFactorMaxiInput.value,
					mFollowOffsetAngleInput = followOffsetAngleInput.value.i,
					mFollowOffsetDistanceInput = followOffsetDistanceInput.value,
					mStartMoveDistanceInput = startMoveDistanceInput.value
				};
				simEntity.entityAIThink.mAICommandSet[actionID.value] = value2;
			}
			simEntity.entityAIThink.mInterruptCommand = simEntity.entityAIThink.mAICommandSet[actionID.value];
			f.Call(output);
		});
	}
}
