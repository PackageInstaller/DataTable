using UnityEngine.InputSystem.Haptics;

namespace UnityEngine.InputSystem.XInput;

public interface IXboxOneRumble : IDualMotorRumble, IHaptics
{
	void SetMotorSpeeds(float lowFrequency, float highFrequency, float leftTrigger, float rightTrigger);
}
