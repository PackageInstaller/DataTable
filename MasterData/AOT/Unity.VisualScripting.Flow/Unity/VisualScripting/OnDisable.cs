namespace Unity.VisualScripting;

[UnitOrder(6)]
[UnitCategory("Events/Lifecycle")]
public sealed class OnDisable : MachineEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnDisable";
}
