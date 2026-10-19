using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Android;

[InputControlLayout(stateType = typeof(AndroidSensorState), variants = "HingeAngle", hideInUI = true)]
public class AndroidHingeAngle : HingeAngle
{
}
