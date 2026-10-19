namespace Unity.VisualScripting.Community;

[UnitOrder(0)]
[UnitCategory("Community\\Control")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.Gate")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Gate")]
[TypeIcon(typeof(ISelectUnit))]
public sealed class Gate : Unit
{
	private bool _isInitial = true;

	private bool _isOpen;

	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ControlInput open { get; private set; }

	[DoNotSerialize]
	public ControlInput close { get; private set; }

	[DoNotSerialize]
	public ControlInput toggle { get; private set; }

	[PortLabel("Initially Open")]
	[DoNotSerialize]
	public ValueInput initialState { get; private set; }

	[DoNotSerialize]
	[PortLabel("Exit")]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		open = ControlInput("open", Open);
		close = ControlInput("close", Close);
		toggle = ControlInput("toggle", Toggle);
		initialState = ValueInput("initialState", @default: true);
		exit = ControlOutput("exit");
		Succession(enter, exit);
		Requirement(initialState, enter);
	}

	public ControlOutput Enter(Flow flow)
	{
		PrepInitialState(flow);
		if (_isOpen)
		{
			return exit;
		}
		return null;
	}

	private ControlOutput Open(Flow obj)
	{
		_isInitial = false;
		_isOpen = true;
		return null;
	}

	private ControlOutput Close(Flow obj)
	{
		_isInitial = false;
		_isOpen = false;
		return null;
	}

	private ControlOutput Toggle(Flow obj)
	{
		_isInitial = false;
		_isOpen = !_isOpen;
		return null;
	}

	private void PrepInitialState(Flow flow)
	{
		if (_isInitial)
		{
			_isOpen = flow.GetValue<bool>(initialState);
		}
		_isInitial = false;
	}
}
