using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidSensorState), variants = "GameRotationVector", hideInUI = true)]
public class AndroidGameRotationVector : AttitudeSensor
{
}
