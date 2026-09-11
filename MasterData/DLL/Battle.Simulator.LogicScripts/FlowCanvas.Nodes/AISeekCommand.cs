using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI连招靠近目标指令", 0)]
[Category("Logic/AI")]
[Description("AI连招远离目标指令")]
public class AISeekCommand : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<int> arriveDistance = AddValueInput<int>("到达距离");
		ValueInput<int> arriveSpeed = AddValueInput<int>("速度百分比").SetDefaultAndSerializedValue(100);
		ValueInput<int> direction = AddValueInput<int>("移动方向");
		ValueInput<bool> stopInput = AddValueInput<bool>("结束时是否停止").SetDefaultAndSerializedValue(v: true);
		ValueInput<bool> edgeDistanceInput = AddValueInput<bool>("使用边界距离").SetDefaultAndSerializedValue(v: true);
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
				aICommandSet.mCommands.Add(new AIMovetoTargetCommand
				{
					mParent = aICommandSet,
					mID = actionID.value,
					mTimeout = timeout.value,
					mArriveDistance = arriveDistance.value,
					mSpeedFactor = arriveSpeed.value,
					mDirection = (AIProcessor.E_Direction)direction.value,
					mStopWhenFinished = stopInput.value,
					mUseEdgeDistance = edgeDistanceInput.value
				});
			}
			f.Call(output);
		});
	}
}
