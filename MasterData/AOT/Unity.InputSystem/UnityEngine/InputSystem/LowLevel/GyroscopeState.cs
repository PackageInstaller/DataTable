using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

internal struct GyroscopeState : IInputStateTypeInfo
{
	[InputControl(displayName = "Angular Velocity", processors = "CompensateDirection", noisy = true)]
	public Vector3 angularVelocity;

	public static FourCC kFormat => new FourCC('G', 'Y', 'R', 'O');

	public FourCC format => kFormat;
}
