using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI前往目标点指令", 0)]
[Category("Logic/AI")]
[Description("AI前往目标点指令")]
public class AIMoveToPositionAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<bool> loockAtTargetInput = AddValueInput<bool>("移动时看着锁定目标");
		ValueInput<int> speedFactorInput = AddValueInput<int>("移动速度百分比").SetDefaultAndSerializedValue(100);
		ValueInput<Int3> positionInput = AddValueInput<Int3>("目标位置");
		ValueInput<int> distanceInput = AddValueInput<int>("目标半径");
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
				aICommandSet.mCommands.Add(new AIMovetoPositionCommand
				{
					mParent = aICommandSet,
					mID = actionID.value,
					mTimeout = timeout.value,
					mLookat = loockAtTargetInput.value,
					mSpeedFactor = speedFactorInput.value,
					mPosition = positionInput.value,
					mArriveDistance = distanceInput.value,
					mStopWhenFinished = stopInput.value
				});
			}
			f.Call(output);
		});
	}
}
