using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI执行空等指令", 0)]
[Category("Logic/AI")]
[Description("AI执行等待指令")]
public class AIDoWaitAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionTimeout = AddValueInput<int>("超时时间").SetDefaultAndSerializedValue(10000);
		ValueInput<bool> actionInterrupt = AddValueInput<bool>("强制打断当前动作").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> succeedWhenTimeOut = AddValueInput<bool>("超时按完成处理");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			int value = commandSetID.value;
			if (!simEntity.entityAIThink.mAICommandSet.TryGetValue(value, out var _))
			{
				AIWaitCommand value3 = new AIWaitCommand
				{
					mID = value,
					mTimeout = actionTimeout.value,
					mForceInterruptAbility = actionInterrupt.value,
					mSucceedWhenTimeOut = succeedWhenTimeOut.value
				};
				simEntity.entityAIThink.mAICommandSet[value] = value3;
			}
			if (simEntity.entityAIThink.mCurrentCommand != null && simEntity.entityAIThink.mCurrentCommand.mStatus == AIProcessor.AICommandStatus.Running)
			{
				simEntity.entityAIThink.mCurrentCommand.Exit(base.mSimContext, simEntity);
			}
			simEntity.entityAIThink.mInterruptCommand = simEntity.entityAIThink.mAICommandSet[value];
			simEntity.entityAIThink.mInterruptCommand.mForceInterruptAbility = actionInterrupt.value;
			f.Call(output);
		});
	}
}
