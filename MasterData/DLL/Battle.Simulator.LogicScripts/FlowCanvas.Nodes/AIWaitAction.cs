using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI等待指令", 0)]
[Category("Logic/AI")]
[Description("AI等待指令")]
public class AIWaitAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> commandSetID = AddValueInput<int>("指令集ID");
		ValueInput<int> actionTimeout = AddValueInput<int>("超时时间");
		ValueInput<bool> succeedWhenTimeOut = AddValueInput<bool>("超时按完成处理");
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
				aICommandSet.mCommands.Add(new AIWaitCommand
				{
					mParent = aICommandSet,
					mTimeout = actionTimeout.value,
					mSucceedWhenTimeOut = succeedWhenTimeOut.value
				});
			}
			f.Call(output);
		});
	}
}
