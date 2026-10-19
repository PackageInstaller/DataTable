namespace Unity.VisualScripting;

[UnitCategory("Variables")]
public sealed class SaveVariables : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		exit = ControlOutput("exit");
		Succession(enter, exit);
	}

	private ControlOutput Enter(Flow arg)
	{
		SavedVariables.SaveDeclarations(SavedVariables.merged);
		return exit;
	}
}
