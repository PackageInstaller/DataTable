using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI模拟按键指令", 0)]
[Category("Logic/AI")]
[Description("AI模拟按键指令")]
public class AIButtonAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> finishedActionID = AddValueInput<int>("成功时动作ID");
		ValueInput<int> finishedFrameCount = AddValueInput<int>("成功时动作帧数");
		ValueInput<ButtonType> buttonType = AddValueInput<ButtonType>("按钮类型");
		ValueInput<bool> subJoy = AddValueInput<bool>("是否需要子摇杆");
		ValueInput<bool> press = AddValueInput<bool>("是否按住");
		ValueInput<int> actionID = AddValueInput<int>("timeline ID");
		ValueInput<int> actionTimeout = AddValueInput<int>("超时时间").SetDefaultAndSerializedValue(10000);
		ValueInput<int> during = AddValueInput<int>("持续时间");
		ValueInput<bool> singlePress = AddValueInput<bool>("是否单次点击");
		ValueInput<bool> failedWhenNoTargetInput = AddValueInput<bool>("目标无效时退出");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = (SimEntity)f.userData;
			if (simEntity.hasEntityAIThink && simEntity.entityAIThink.mAICommandSet.TryGetValue(commandSetID.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				if (aICommandSet.mCommands == null)
				{
					aICommandSet.mCommands = new List<AICommand>();
				}
				aICommandSet.mCommands.Add(new AIButtonCommand
				{
					mParent = aICommandSet,
					mID = actionID.value,
					mTimelineID = actionID.value,
					mButtonType = buttonType.value,
					mIsSubStick = subJoy.value,
					mPressing = press.value,
					mDuring = during.value,
					mTimeout = actionTimeout.value,
					mSingleClick = singlePress.value,
					mFailedWhenNoTarget = failedWhenNoTargetInput.value,
					mFinishedAbilityID = finishedActionID.value,
					mFinishedAbilityFrame = finishedFrameCount.value
				});
			}
			f.Call(output);
		});
	}
}
