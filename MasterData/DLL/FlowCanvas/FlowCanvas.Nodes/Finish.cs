using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Description("Stops and cease execution of the FlowSript")]
public class Finish : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> c = AddValueInput<bool>("Success");
		AddFlowInput("In", delegate
		{
			base.graph.Stop(c.value);
		});
	}
}
