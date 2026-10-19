using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidGameControllerState), displayName = "Android DualShock 4 Gamepad", variants = "Gamepad;DpadAxes")]
public class DualShock4GamepadAndroid : DualShockGamepad
{
}
