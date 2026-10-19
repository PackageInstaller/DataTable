namespace Unity.VisualScripting;

[UnitOrder(3)]
[UnitTitle("On Update")]
[UnitCategory("Events/Lifecycle")]
public sealed class Update : MachineEventUnit<EmptyEventArgs>
{
	protected override string hookName => "Update";
}
