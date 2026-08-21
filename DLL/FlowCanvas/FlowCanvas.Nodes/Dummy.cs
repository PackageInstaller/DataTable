using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Identity", 100)]
[Description("Use for organization.")]
public class Dummy : FlowControlNode
{
	public override string name => null;

	protected override void RegisterPorts()
	{
		FlowOutput fOut = AddFlowOutput(" ", "Out");
		AddFlowInput(" ", "In", delegate(Flow f)
		{
			fOut.Call(f);
		});
	}
}
