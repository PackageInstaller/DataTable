namespace Unity.VisualScripting.Community;

[UnitCategory("Community\\Control")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.EdgeTrigger")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.EdgeTrigger")]
[TypeIcon(typeof(ISelectUnit))]
public sealed class EdgeTrigger : Unit
{
	private bool? _lastEdge;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ValueInput inValue { get; private set; }

	[DoNotSerialize]
	public ValueOutput outValue { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		inValue = ValueInput("inValue", @default: false);
		outValue = ValueOutput("outValue", (Flow recursion) => _lastEdge.HasValue && _lastEdge.Value);
		exit = ControlOutput("exit");
		Succession(enter, exit);
		Requirement(inValue, enter);
		Requirement(inValue, outValue);
	}

	public ControlOutput Enter(Flow flow)
	{
		bool value = flow.GetValue<bool>(inValue);
		if (!_lastEdge.HasValue || _lastEdge != value)
		{
			_lastEdge = value;
			return exit;
		}
		return null;
	}
}
