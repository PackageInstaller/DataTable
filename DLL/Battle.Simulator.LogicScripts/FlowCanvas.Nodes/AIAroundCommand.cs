using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI连招环绕目标指令", 0)]
[Category("Logic/AI")]
[Description("AI连招环绕目标指令")]
public class AIAroundCommand : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<int> arriveSpeed = AddValueInput<int>("速度百分比").SetDefaultAndSerializedValue(100);
		ValueInput<bool> stopInput = AddValueInput<bool>("结束时是否停止").SetDefaultAndSerializedValue(v: true);
		AddValueOutput("指令ID", () => actionID.value);
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
				aICommandSet.mCommands.Add(new AIMoveAroundTargetCommand
				{
					mParent = aICommandSet,
					mID = actionID.value,
					mApproachSpeed = arriveSpeed.value,
					mTimeout = timeout.value,
					mStopWhenFinished = stopInput.value
				});
			}
			f.Call(output);
		});
	}
}
