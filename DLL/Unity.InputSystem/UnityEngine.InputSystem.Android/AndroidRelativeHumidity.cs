using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidSensorState), variants = "RelativeHumidity", hideInUI = true)]
public class AndroidRelativeHumidity : HumiditySensor
{
}
