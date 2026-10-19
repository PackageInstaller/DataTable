using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

internal struct PointerState : IInputStateTypeInfo
{
	private uint pointerId;

	[InputControl(layout = "Vector2", displayName = "Position", usage = "Point", dontReset = true)]
	public Vector2 position;

	[InputControl(layout = "Delta", displayName = "Delta", usage = "Secondary2DMotion")]
	public Vector2 delta;

	[InputControl(layout = "Analog", displayName = "Pressure", usage = "Pressure", defaultState = 1f)]
	public float pressure;

	[InputControl(layout = "Vector2", displayName = "Radius", usage = "Radius")]
	public Vector2 radius;

	[InputControl(name = "press", displayName = "Press", layout = "Button", format = "BIT", bit = 0u)]
	public ushort buttons;

	[InputControl(name = "displayIndex", layout = "Integer", displayName = "Display Index")]
	public ushort displayIndex;

	public static FourCC kFormat => new FourCC('P', 'T', 'R');

	public FourCC format => kFormat;
}
