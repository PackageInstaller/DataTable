using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI方向性移动指令", 0)]
[Category("Logic/AI")]
[Description("AI方向性移动指令（（前）Forward = 0,（后） Backward = 1,（左） Left = 2,  （右）Right = 3, （上）Up = 4,（下） Down = 5）, 超时算成功\n ")]
public class AIMoveForwardCommand : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<int> direction = AddValueInput<int>("移动方向");
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
				aICommandSet.mCommands.Add(new AIMovementCommand
				{
					mParent = aICommandSet,
					mID = actionID.value,
					mTimeout = timeout.value,
					mMaxDistance = 1000,
					mDirection = (AIProcessor.E_Direction)direction.value,
					mStopWhenFinished = stopInput.value
				});
				f.Call(output);
			}
		});
	}
}
