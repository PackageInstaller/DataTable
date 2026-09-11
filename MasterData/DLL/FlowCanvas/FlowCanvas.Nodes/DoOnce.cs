using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Filters")]
[Description("Filters Out to be called only once. After the first call, Out is no longer called until Reset is called")]
public class DoOnce : FlowControlNode
{
	private bool called;

	public override void OnGraphStarted()
	{
		called = false;
	}

	protected override void RegisterPorts()
	{
		FlowOutput o = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			if (!called)
			{
				called = true;
				o.Call(f);
			}
		});
		AddFlowInput("Reset", delegate
		{
			called = false;
		});
	}
}
