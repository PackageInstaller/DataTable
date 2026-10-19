using Unity.VisualScripting;

[TypeIcon(typeof(FlowGraph))]
[UnitCategory("Community/Variables")]
[UnitTitle("ClearSavedVars")]
public class ClearSavedVars : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput In;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput Out;

	[DoNotSerialize]
	public ValueInput Key;

	protected override void Definition()
	{
		In = ControlInput("In", _Enter_);
		Out = ControlOutput("Out");
		Succession(In, Out);
	}

	public ControlOutput _Enter_(Flow flow)
	{
		SavedVariables.saved.Clear();
		SavedVariables.SaveDeclarations(SavedVariables.saved);
		return Out;
	}
}
