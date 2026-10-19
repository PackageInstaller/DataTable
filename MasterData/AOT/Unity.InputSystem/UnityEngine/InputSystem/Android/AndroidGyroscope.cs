using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidSensorState), variants = "Gyroscope", hideInUI = true)]
public class AndroidGyroscope : Gyroscope
{
}
