using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidSensorState), variants = "MagneticField", hideInUI = true)]
public class AndroidMagneticFieldSensor : MagneticFieldSensor
{
}
