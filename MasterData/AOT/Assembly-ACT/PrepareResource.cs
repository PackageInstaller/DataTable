using Unity.VisualScripting;

[UnitCategory("Events/ACT")]
[UnitTitle("On Resource Prepared")]
public class PrepareResource : MachineEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnResourcePrepared";
}
