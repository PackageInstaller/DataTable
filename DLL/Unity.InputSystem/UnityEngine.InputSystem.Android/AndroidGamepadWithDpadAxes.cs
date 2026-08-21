using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidGameControllerState), hideInUI = true, variants = "Gamepad;DpadAxes")]
public class AndroidGamepadWithDpadAxes : AndroidGamepad
{
}
