namespace Unity.VisualScripting;

[UnitTitle("On Late Update")]
[UnitOrder(5)]
[UnitCategory("Events/Lifecycle")]
public sealed class LateUpdate : MachineEventUnit<EmptyEventArgs>
{
	protected override string hookName => "LateUpdate";
}
