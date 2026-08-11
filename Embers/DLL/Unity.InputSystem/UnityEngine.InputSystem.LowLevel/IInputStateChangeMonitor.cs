namespace UnityEngine.InputSystem.LowLevel;

public interface IInputStateChangeMonitor
{
	void NotifyControlStateChanged(InputControl control, double time, InputEventPtr eventPtr, long monitorIndex);

	void NotifyTimerExpired(InputControl control, double time, long monitorIndex, int timerIndex);
}
