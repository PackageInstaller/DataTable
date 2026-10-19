namespace Unity.VisualScripting;

[UnitCategory("Events/Application")]
public sealed class OnApplicationQuit : GlobalEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnApplicationQuit";
}
