using UnityEngine.InputSystem.Haptics;

namespace UnityEngine.InputSystem.DualShock;

public interface IDualShockHaptics : IDualMotorRumble, IHaptics
{
	void SetLightBarColor(Color color);
}
