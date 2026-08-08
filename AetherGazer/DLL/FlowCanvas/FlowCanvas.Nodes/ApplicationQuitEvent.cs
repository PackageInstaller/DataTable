using ParadoxNotion.Design;
using ParadoxNotion.Services;

namespace FlowCanvas.Nodes;

[Name("On Application Quit", 0)]
[Category("Events/Application")]
[Description("Called when the Application quit")]
public class ApplicationQuitEvent : EventNode
{
	private FlowOutput quit;

	public override void OnGraphStarted()
	{
		MonoManager.current.onApplicationQuit += ApplicationQuit;
	}

	public override void OnGraphStoped()
	{
		MonoManager.current.onApplicationQuit -= ApplicationQuit;
	}

	private void ApplicationQuit()
	{
		quit.Call(default(Flow));
	}

	protected override void RegisterPorts()
	{
		quit = AddFlowOutput("Out");
	}
}
