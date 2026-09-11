using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI替换等待指令", 0)]
[Category("Logic/AI")]
[Description("AI等待指令")]
public class AIReplaceWaitAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> stepIndex = AddValueInput<int>("步骤");
		ValueInput<int> actionTimeout = AddValueInput<int>("超时时间");
		ValueInput<bool> succeedWhenTimeOut = AddValueInput<bool>("超时按完成处理");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (((SimEntity)f.userData).entityAIThink.mAICommandSet.TryGetValue(commandSetID.value, out var value))
			{
				AICommandSet aICommandSet = (AICommandSet)value;
				int value2 = stepIndex.value;
				AIWaitCommand obj = (AIWaitCommand)aICommandSet.mCommands[value2];
				obj.mParent = aICommandSet;
				obj.mTimeout = actionTimeout.value;
				obj.mSucceedWhenTimeOut = succeedWhenTimeOut.value;
			}
			f.Call(output);
		});
	}
}
