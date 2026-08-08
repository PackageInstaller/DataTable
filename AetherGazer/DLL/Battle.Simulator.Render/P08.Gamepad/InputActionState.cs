namespace P08.Gamepad;

public class InputActionState
{
	public struct TriggerState
	{
		internal EInputActionPhase _phase;

		internal bool _consumed;
	}

	internal TriggerState triggerState;

	public EInputActionPhase phase => triggerState._phase;

	public bool consumed => triggerState._consumed;
}
