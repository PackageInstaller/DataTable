using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Description("Use to debug send a Flow Signal in PlayMode Only")]
[Category("Events/Other")]
public class DebugEvent : EventNode, IUpdatable
{
	protected override void RegisterPorts()
	{
		AddFlowOutput("Out");
	}

	public void Update()
	{
	}
}
