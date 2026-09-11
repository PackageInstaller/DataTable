using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI Log", 0)]
[Category("Logic/AI")]
[Description("AI Log: 日志")]
public class AICommandLog : FlowNode
{
	private Status mTargetStatus = Status.Running;

	protected override void RegisterPorts()
	{
		AddValueInput<int>("实体ID");
		AddValueInput<string>("log");
		AddFlowInput("", delegate
		{
		});
	}
}
