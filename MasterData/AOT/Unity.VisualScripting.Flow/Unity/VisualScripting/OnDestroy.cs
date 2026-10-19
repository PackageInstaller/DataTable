namespace Unity.VisualScripting;

[UnitCategory("Events/Lifecycle")]
[UnitOrder(7)]
public sealed class OnDestroy : MachineEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnDestroy";

	public override void StopListening(GraphStack stack)
	{
	}

	private protected override void InternalTrigger(GraphReference reference, EmptyEventArgs args)
	{
		base.InternalTrigger(reference, args);
		using GraphStack stack = reference.ToStackPooled();
		base.StopListening(stack);
	}
}
