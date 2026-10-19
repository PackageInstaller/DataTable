namespace Unity.VisualScripting;

[UnitCategory("Events/Editor")]
public sealed class OnDrawGizmosSelected : ManualEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnDrawGizmosSelected";
}
