namespace Unity.VisualScripting;

[UnitCategory("Events/Editor")]
public sealed class OnDrawGizmos : ManualEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnDrawGizmos";
}
