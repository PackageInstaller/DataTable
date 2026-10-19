namespace Unity.VisualScripting.Community;

[UnitCategory("Events/Community")]
[TypeIcon(typeof(EventUnit<CustomEventArgs>))]
public sealed class ResetGraphListener : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit;

	protected override void Definition()
	{
		enter = ControlInput("enter", (Flow flow) =>
		{
			graph.StopListening(flow.stack.AsReference());
			graph.StartListening(flow.stack.AsReference());
			return exit;
		});
		exit = ControlOutput("exit");
		Succession(enter, exit);
	}
}
