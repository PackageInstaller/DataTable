using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidSensorState), variants = "RotationVector", hideInUI = true)]
public class AndroidRotationVector : AttitudeSensor
{
}
