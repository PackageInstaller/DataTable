namespace UnityEngine.InputSystem.Haptics;

public interface IDualMotorRumble : IHaptics
{
	void SetMotorSpeeds(float lowFrequency, float highFrequency);
}
