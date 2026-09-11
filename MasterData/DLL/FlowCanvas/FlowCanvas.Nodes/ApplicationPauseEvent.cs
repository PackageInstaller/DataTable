using ParadoxNotion.Design;
using ParadoxNotion.Services;

namespace FlowCanvas.Nodes;

[Name("On Application Pause", 0)]
[Category("Events/Application")]
[Description("Called when the Application is paused or resumed")]
public class ApplicationPauseEvent : EventNode
{
	private FlowOutput pause;

	private bool isPause;

	public override void OnGraphStarted()
	{
		MonoManager.current.onApplicationPause += ApplicationPause;
	}

	public override void OnGraphStoped()
	{
		MonoManager.current.onApplicationPause -= ApplicationPause;
	}

	private void ApplicationPause(bool isPause)
	{
		this.isPause = isPause;
		pause.Call(default(Flow));
	}

	protected override void RegisterPorts()
	{
		pause = AddFlowOutput("Out");
		AddValueOutput("Is Pause", () => isPause);
	}
}
