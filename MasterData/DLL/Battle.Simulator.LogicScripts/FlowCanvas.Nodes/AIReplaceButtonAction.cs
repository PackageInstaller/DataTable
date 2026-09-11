using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI替换按键指令", 0)]
[Category("Logic/AI")]
[Description("AI替换按键指令")]
public class AIReplaceButtonAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> actionStep = AddValueInput<int>("步骤");
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
		AddValueOutput("动作ID", () => actionID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (((SimEntity)f.userData).entityAIThink.mAICommandSet.TryGetValue(commandSetID.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				int value2 = actionStep.value;
				AIButtonCommand obj = (AIButtonCommand)aICommandSet.mCommands[value2];
				obj.mParent = aICommandSet;
				obj.mID = actionID.value;
				obj.mButtonType = buttonType.value;
				obj.mIsSubStick = subJoy.value;
				obj.mPressing = press.value;
				obj.mTimeout = actionTimeout.value;
				obj.mDuring = during.value;
				obj.mSingleClick = singlePress.value;
				obj.mFailedWhenNoTarget = failedWhenNoTargetInput.value;
				obj.mFinishedAbilityID = finishedActionID.value;
				obj.mFinishedAbilityFrame = finishedFrameCount.value;
			}
			f.Call(output);
		});
	}
}
