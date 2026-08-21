using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 36)]
public struct PenState : IInputStateTypeInfo
{
	[FieldOffset(0)]
	[InputControl(usage = "Point", dontReset = true)]
	public Vector2 position;

	[FieldOffset(8)]
	[InputControl(usage = "Secondary2DMotion", layout = "Delta")]
	public Vector2 delta;

	[FieldOffset(16)]
	[InputControl(layout = "Vector2", displayName = "Tilt", usage = "Tilt")]
	public Vector2 tilt;

	[FieldOffset(24)]
	[InputControl(layout = "Analog", usage = "Pressure", defaultState = 0f)]
	public float pressure;

	[FieldOffset(28)]
	[InputControl(layout = "Axis", displayName = "Twist", usage = "Twist")]
	public float twist;

	[FieldOffset(32)]
	[InputControl(name = "inRange", displayName = "In Range?", layout = "Button", bit = 4u, synthetic = true)]
	[InputControl(name = "eraser", displayName = "Eraser", layout = "Button", bit = 1u)]
	[InputControl(name = "press", useStateFrom = "tip", synthetic = true, usages = new string[] { })]
	[InputControl(name = "tip", displayName = "Tip", layout = "Button", bit = 0u, usage = "PrimaryAction")]
	[InputControl(name = "barrel2", displayName = "Barrel Button #2", layout = "Button", bit = 3u, alias = "barrelSecond")]
	[InputControl(name = "barrel4", displayName = "Barrel Button #4", layout = "Button", bit = 6u, alias = "barrelFourth")]
	[InputControl(name = "barrel3", displayName = "Barrel Button #3", layout = "Button", bit = 5u, alias = "barrelThird")]
	[InputControl(name = "pointerId", layout = "Digital", format = "UINT", sizeInBits = 32u, offset = 4294967294u)]
	[InputControl(name = "radius", layout = "Vector2", format = "VEC2", sizeInBits = 64u, usage = "Radius", offset = 4294967294u)]
	[InputControl(name = "barrel1", displayName = "Barrel Button #1", layout = "Button", bit = 2u, alias = "barrelFirst", usage = "SecondaryAction")]
	public ushort buttons;

	[FieldOffset(34)]
	private ushort displayIndex;

	public static FourCC Format => new FourCC('P', 'E', 'N');

	public FourCC format => Format;

	public PenState WithButton(PenButton button, bool state = true)
	{
		uint num = (uint)(1 << (int)button);
		if (state)
		{
			buttons |= (ushort)num;
		}
		else
		{
			buttons &= (ushort)(~num);
		}
		return this;
	}
}
