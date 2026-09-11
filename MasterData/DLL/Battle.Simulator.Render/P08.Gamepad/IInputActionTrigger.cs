namespace P08.Gamepad;

internal interface IInputActionTrigger
{
	void Process(ref InputActionTriggerContext context);

	void Reset(ref InputActionTriggerContext context);
}
