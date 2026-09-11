using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI执行指令", 0)]
[Category("Logic/AI")]
[Description("AI执行指令，如果没有预先配置的动作ID,会根据配置自动生成对应的指令并执行，这种情况下动作ID不可重复")]
public class AIDoAction : FlowNode
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
		ValueInput<int> actionID = AddValueInput<int>("动作ID");
		ValueInput<int> actionBeginFrame = AddValueInput<int>("起始帧数");
		ValueInput<int> actionEndFrame = AddValueInput<int>("结束帧数");
		ValueInput<int> actionLoopCount = AddValueInput<int>("循环次数").SetDefaultAndSerializedValue(1);
		ValueInput<int> actionTimeout = AddValueInput<int>("超时时间").SetDefaultAndSerializedValue(10000);
		ValueInput<int> actionRange = AddValueInput<int>("接近范围距离");
		ValueInput<int> actionSpeed = AddValueInput<int>("接近速度百分比").SetDefaultAndSerializedValue(100);
		ValueInput<bool> actionDisableApproach = AddValueInput<bool>("原地释放").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> actionInterrupt = AddValueInput<bool>("强制打断当前动作").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> edgeDistanceInput = AddValueInput<bool>("使用边界距离").SetDefaultAndSerializedValue(v: true);
		AddValueOutput("动作ID", () => actionID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			if (!simEntity.entityAIThink.mAICommandSet.TryGetValue(actionID.value, out var _))
			{
				AIAbilityCommand value2 = new AIAbilityCommand
				{
					mID = actionID.value,
					mBeginFrame = actionBeginFrame.value,
					mEndFrame = actionEndFrame.value,
					mLoop = actionLoopCount.value,
					mTimeout = actionTimeout.value,
					mRange = actionRange.value,
					mApproachSpeed = actionSpeed.value,
					mDisableApproach = actionDisableApproach.value,
					mForceInterruptAbility = actionInterrupt.value,
					mUseEdgeDistance = edgeDistanceInput.value
				};
				simEntity.entityAIThink.mAICommandSet[actionID.value] = value2;
			}
			simEntity.entityAIThink.mInterruptCommand = simEntity.entityAIThink.mAICommandSet[actionID.value];
			simEntity.entityAIThink.mInterruptCommand.mForceInterruptAbility = actionInterrupt.value;
			f.Call(output);
		});
	}
}
