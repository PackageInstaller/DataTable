using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidGameControllerState), variants = "Joystick")]
public class AndroidJoystick : Joystick
{
}
