using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI指令", 0)]
[Category("Logic/AI")]
[Description("配置AI连招指令, 起始帧数只有在打断或者配了循环的时候才会生效")]
public class AIComboAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
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
		AddValueOutput("指令集ID", () => commandSetID.value);
		AddValueOutput("动作ID", () => actionID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (((SimEntity)f.userData).entityAIThink.mAICommandSet.TryGetValue(commandSetID.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				if (aICommandSet.mCommands == null)
				{
					aICommandSet.mCommands = new List<AICommand>();
				}
				aICommandSet.mCommands.Add(new AIAbilityCommand
				{
					mParent = aICommandSet,
					mID = actionID.value,
					mBeginFrame = actionBeginFrame.value,
					mEndFrame = actionEndFrame.value,
					mTimeout = actionTimeout.value,
					mRange = actionRange.value,
					mApproachSpeed = actionSpeed.value,
					mDisableApproach = actionDisableApproach.value,
					mForceInterruptAbility = actionInterrupt.value,
					mLoop = actionLoopCount.value,
					mUseEdgeDistance = edgeDistanceInput.value
				});
			}
			f.Call(output);
		});
	}
}
