using ParadoxNotion.Design;
using ParadoxNotion.Services;

namespace FlowCanvas.Nodes;

[Name("On Late Update", 6)]
[Category("Events/Graph")]
[Description("Called per-frame, but after normal Update")]
[ExecutionPriority(6)]
public class LateUpdateEvent : EventNode
{
	private FlowOutput lateUpdate;

	protected override void RegisterPorts()
	{
		lateUpdate = AddFlowOutput("Out");
	}

	public override void OnGraphStarted()
	{
		MonoManager.current.onLateUpdate += LateUpdate;
	}

	public override void OnGraphStoped()
	{
		MonoManager.current.onLateUpdate -= LateUpdate;
	}

	private void LateUpdate()
	{
		lateUpdate.Call(default(Flow));
	}
}
