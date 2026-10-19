namespace Unity.VisualScripting;

public abstract class MachineEventUnit<TArgs> : EventUnit<TArgs>
{
	protected sealed override bool register => true;

	protected virtual string hookName
	{
		get
		{
			throw new InvalidImplementationException($"Missing event hook for '{this}'.");
		}
	}

	public override EventHook GetHook(GraphReference reference)
	{
		return new EventHook(hookName, reference.machine);
	}
}
