using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

internal struct AttitudeState : IInputStateTypeInfo
{
	[InputControl(displayName = "Attitude", processors = "CompensateRotation", noisy = true)]
	public Quaternion attitude;

	public static FourCC kFormat => new FourCC('A', 'T', 'T', 'D');

	public FourCC format => kFormat;
}
