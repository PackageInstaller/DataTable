using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

internal struct LinearAccelerationState : IInputStateTypeInfo
{
	[InputControl(displayName = "Acceleration", processors = "CompensateDirection", noisy = true)]
	public Vector3 acceleration;

	public static FourCC kFormat => new FourCC('L', 'A', 'A', 'C');

	public FourCC format => kFormat;
}
