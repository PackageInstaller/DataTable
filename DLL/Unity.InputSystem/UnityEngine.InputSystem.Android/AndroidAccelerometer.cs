using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidSensorState), variants = "Accelerometer", hideInUI = true)]
public class AndroidAccelerometer : Accelerometer
{
}
