using UnityEngine.InputSystem.XR.Haptics;

namespace UnityEngine.InputSystem.XR;

public class XRControllerWithRumble : XRController
{
	public void SendImpulse(float amplitude, float duration)
	{
		SendHapticImpulseCommand command = SendHapticImpulseCommand.Create(0, amplitude, duration);
		ExecuteCommand(ref command);
	}
}
