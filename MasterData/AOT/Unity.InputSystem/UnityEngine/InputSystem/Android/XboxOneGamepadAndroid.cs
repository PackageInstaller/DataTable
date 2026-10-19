using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.XInput;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidGameControllerState), displayName = "Android Xbox One Controller", variants = "Gamepad;DpadAxes")]
public class XboxOneGamepadAndroid : XInputController
{
}
