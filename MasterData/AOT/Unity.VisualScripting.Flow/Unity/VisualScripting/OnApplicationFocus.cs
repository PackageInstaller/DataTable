namespace Unity.VisualScripting;

[UnitCategory("Events/Application")]
public sealed class OnApplicationFocus : GlobalEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnApplicationFocus";
}
