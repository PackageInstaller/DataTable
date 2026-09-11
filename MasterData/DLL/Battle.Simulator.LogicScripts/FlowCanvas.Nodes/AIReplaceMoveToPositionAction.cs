using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI替换前往目标点指令", 0)]
[Category("Logic/AI")]
[Description("AI前往目标点指令")]
public class AIReplaceMoveToPositionAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> stepInput = AddValueInput<int>("步骤");
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionID = AddValueInput<int>("指令ID");
		ValueInput<int> timeout = AddValueInput<int>("超时时间");
		ValueInput<bool> loockAtTargetInput = AddValueInput<bool>("移动时看着锁定目标");
		ValueInput<int> speedFactorInput = AddValueInput<int>("移动速度百分比").SetDefaultAndSerializedValue(100);
		ValueInput<Int3> positionInput = AddValueInput<Int3>("目标位置");
		ValueInput<int> distanceInput = AddValueInput<int>("目标半径");
		ValueInput<bool> stopInput = AddValueInput<bool>("结束时是否停止").SetDefaultAndSerializedValue(v: true);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (((SimEntity)f.userData).entityAIThink.mAICommandSet.TryGetValue(commandSetID.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				int value2 = stepInput.value;
				AIMovetoPositionCommand obj = (AIMovetoPositionCommand)aICommandSet.mCommands[value2];
				obj.mParent = aICommandSet;
				obj.mID = actionID.value;
				obj.mTimeout = timeout.value;
				obj.mLookat = loockAtTargetInput.value;
				obj.mSpeedFactor = speedFactorInput.value;
				obj.mPosition = positionInput.value;
				obj.mArriveDistance = distanceInput.value;
				obj.mStopWhenFinished = stopInput.value;
			}
			f.Call(output);
		});
	}
}
