namespace Unity.VisualScripting;

[UnitTitle("On Fixed Update")]
[UnitOrder(4)]
[UnitCategory("Events/Lifecycle")]
public sealed class FixedUpdate : MachineEventUnit<EmptyEventArgs>
{
	protected override string hookName => "FixedUpdate";
}
