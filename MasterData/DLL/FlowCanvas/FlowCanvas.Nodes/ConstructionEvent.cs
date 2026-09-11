using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("On Awake", 10)]
[Category("Events/Graph")]
[Description("Called only once and the first time the Graph is enabled.\nUse this for initialization of this graph.")]
[ExecutionPriority(10)]
public class ConstructionEvent : EventNode
{
	private FlowOutput awake;

	private bool called;

	public override void OnGraphStarted()
	{
		if (!called)
		{
			called = true;
			awake.Call(default(Flow));
		}
	}

	protected override void RegisterPorts()
	{
		awake = AddFlowOutput("Once");
	}
}
