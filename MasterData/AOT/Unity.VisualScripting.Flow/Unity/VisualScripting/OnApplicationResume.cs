namespace Unity.VisualScripting;

[UnitCategory("Events/Application")]
public sealed class OnApplicationResume : GlobalEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnApplicationResume";
}
