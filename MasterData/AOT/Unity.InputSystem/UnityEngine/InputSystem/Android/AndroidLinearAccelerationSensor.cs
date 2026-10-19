using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidSensorState), variants = "LinearAcceleration", hideInUI = true)]
public class AndroidLinearAccelerationSensor : LinearAccelerationSensor
{
}
