namespace UnityEngine.InputSystem;

public interface IInputInteraction
{
	void Process(ref InputInteractionContext context);

	void Reset();
}
public interface IInputInteraction<TValue> : IInputInteraction where TValue : struct
{
}
