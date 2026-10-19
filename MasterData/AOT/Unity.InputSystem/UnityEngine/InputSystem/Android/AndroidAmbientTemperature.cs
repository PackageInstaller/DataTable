using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidSensorState), variants = "AmbientTemperature", hideInUI = true)]
public class AndroidAmbientTemperature : AmbientTemperatureSensor
{
}
