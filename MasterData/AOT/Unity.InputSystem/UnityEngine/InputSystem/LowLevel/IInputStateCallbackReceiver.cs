namespace UnityEngine.InputSystem.LowLevel;

public interface IInputStateCallbackReceiver
{
	void OnNextUpdate();

	void OnStateEvent(InputEventPtr eventPtr);

	bool GetStateOffsetForEvent(InputControl control, InputEventPtr eventPtr, ref uint offset);
}
