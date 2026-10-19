namespace Unity.VisualScripting;

[UnitCategory("Events/Application")]
public sealed class OnApplicationLostFocus : GlobalEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnApplicationLostFocus";
}
