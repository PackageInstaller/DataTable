using System;
using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 28)]
public struct GamepadState : IInputStateTypeInfo
{
	internal const string ButtonSouthShortDisplayName = "A";

	internal const string ButtonNorthShortDisplayName = "Y";

	internal const string ButtonWestShortDisplayName = "X";

	internal const string ButtonEastShortDisplayName = "B";

	[FieldOffset(0)]
	[InputControl(name = "dpad", layout = "Dpad", usage = "Hatswitch", displayName = "D-Pad", format = "BIT", sizeInBits = 4u, bit = 0u)]
	[InputControl(name = "buttonSouth", layout = "Button", bit = 6u, usages = new string[] { "PrimaryAction", "Submit" }, aliases = new string[] { "a", "cross" }, displayName = "Button South", shortDisplayName = "A")]
	[InputControl(name = "buttonWest", layout = "Button", bit = 7u, usage = "SecondaryAction", aliases = new string[] { "x", "square" }, displayName = "Button West", shortDisplayName = "X")]
	[InputControl(name = "buttonNorth", layout = "Button", bit = 4u, aliases = new string[] { "y", "triangle" }, displayName = "Button North", shortDisplayName = "Y")]
	[InputControl(name = "buttonEast", layout = "Button", bit = 5u, usages = new string[] { "Back", "Cancel" }, aliases = new string[] { "b", "circle" }, displayName = "Button East", shortDisplayName = "B")]
	[InputControl(name = "leftShoulder", layout = "Button", bit = 10u, displayName = "Left Shoulder", shortDisplayName = "LB")]
	[InputControl(name = "rightShoulder", layout = "Button", bit = 11u, displayName = "Right Shoulder", shortDisplayName = "RB")]
	[InputControl(name = "start", layout = "Button", bit = 12u, usage = "Menu", displayName = "Start")]
	[InputControl(name = "select", layout = "Button", bit = 13u, displayName = "Select")]
	[InputControl(name = "rightStickPress", layout = "Button", bit = 9u, displayName = "Right Stick Press")]
	[InputControl(name = "leftStickPress", layout = "Button", bit = 8u, displayName = "Left Stick Press")]
	public uint buttons;

	[FieldOffset(4)]
	[InputControl(layout = "Stick", usage = "Primary2DMotion", processors = "stickDeadzone", displayName = "Left Stick", shortDisplayName = "LS")]
	public Vector2 leftStick;

	[FieldOffset(12)]
	[InputControl(layout = "Stick", usage = "Secondary2DMotion", processors = "stickDeadzone", displayName = "Right Stick", shortDisplayName = "RS")]
	public Vector2 rightStick;

	[FieldOffset(20)]
	[InputControl(layout = "Button", format = "FLT", usage = "SecondaryTrigger", displayName = "Left Trigger", shortDisplayName = "LT")]
	public float leftTrigger;

	[FieldOffset(24)]
	[InputControl(layout = "Button", format = "FLT", usage = "SecondaryTrigger", displayName = "Right Trigger", shortDisplayName = "RT")]
	public float rightTrigger;

	public static FourCC Format => new FourCC('G', 'P', 'A', 'D');

	public FourCC format => Format;

	public GamepadState(params GamepadButton[] buttons)
	{
		this = default(GamepadState);
		if (buttons == null)
		{
			throw new ArgumentNullException("buttons");
		}
		foreach (GamepadButton gamepadButton in buttons)
		{
			uint num = (uint)(1 << (int)gamepadButton);
			this.buttons |= num;
		}
	}

	public GamepadState WithButton(GamepadButton button, bool value = true)
	{
		uint num = (uint)(1 << (int)button);
		if (value)
		{
			buttons |= num;
		}
		else
		{
			buttons &= ~num;
		}
		return this;
	}
}
