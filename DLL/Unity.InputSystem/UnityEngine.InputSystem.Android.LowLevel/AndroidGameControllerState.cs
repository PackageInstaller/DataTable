using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Android.LowLevel;

public struct AndroidGameControllerState : IInputStateTypeInfo
{
	public class Variants
	{
		public const string Gamepad = "Gamepad";

		public const string Joystick = "Joystick";

		public const string DPadAxes = "DpadAxes";

		public const string DPadButtons = "DpadButtons";
	}

	public const int MaxAxes = 48;

	public const int MaxButtons = 220;

	internal const uint kAxisOffset = 28u;

	public static FourCC kFormat = new FourCC('A', 'G', 'C');

	[InputControl(name = "buttonWest", bit = 99u, variants = "Gamepad")]
	[InputControl(name = "buttonNorth", bit = 100u, variants = "Gamepad")]
	[InputControl(name = "buttonEast", bit = 97u, variants = "Gamepad")]
	[InputControl(name = "dpad/right", bit = 22u, variants = "DpadButtons")]
	[InputControl(name = "dpad/left", bit = 21u, variants = "DpadButtons")]
	[InputControl(name = "dpad/down", bit = 20u, variants = "DpadButtons")]
	[InputControl(name = "dpad/up", bit = 19u, variants = "DpadButtons")]
	[InputControl(name = "dpad", layout = "Dpad", bit = 19u, sizeInBits = 4u, variants = "DpadButtons")]
	[InputControl(name = "buttonSouth", bit = 96u, variants = "Gamepad")]
	[InputControl(name = "leftStickPress", bit = 106u, variants = "Gamepad")]
	[InputControl(name = "rightShoulder", bit = 103u, variants = "Gamepad")]
	[InputControl(name = "leftShoulder", bit = 102u, variants = "Gamepad")]
	[InputControl(name = "start", bit = 108u, variants = "Gamepad")]
	[InputControl(name = "select", bit = 109u, variants = "Gamepad")]
	[InputControl(name = "rightStickPress", bit = 107u, variants = "Gamepad")]
	public unsafe fixed uint buttons[7];

	[InputControl(name = "rightStick/down", offset = 12u, variants = "Gamepad", parameters = "invert=false,clamp=1,clampMin=0,clampMax=1.0")]
	[InputControl(name = "rightStick/up", offset = 12u, variants = "Gamepad", parameters = "invert,clamp=1,clampMin=-1.0,clampMax=0.0")]
	[InputControl(name = "rightStick/y", offset = 12u, variants = "Gamepad", parameters = "invert")]
	[InputControl(name = "rightStick/x", variants = "Gamepad")]
	[InputControl(name = "leftStick/down", variants = "Gamepad", parameters = "invert=false,clamp=1,clampMin=0,clampMax=1.0")]
	[InputControl(name = "leftStick/up", variants = "Gamepad", parameters = "invert,clamp=1,clampMin=-1.0,clampMax=0.0")]
	[InputControl(name = "leftStick/y", variants = "Gamepad", parameters = "invert")]
	[InputControl(name = "leftStick", variants = "Gamepad")]
	[InputControl(name = "rightStick", offset = 72u, sizeInBits = 128u, variants = "Gamepad")]
	[InputControl(name = "leftTrigger", offset = 120u, parameters = "clamp=1,clampMin=0,clampMax=1.0", variants = "Gamepad")]
	[InputControl(name = "dpad/up", offset = 4u, bit = 0u, sizeInBits = 32u, format = "FLT", parameters = "clamp=3,clampConstant=0,clampMin=-1,clampMax=0,invert", variants = "DpadAxes")]
	[InputControl(name = "dpad/down", offset = 4u, bit = 0u, sizeInBits = 32u, format = "FLT", parameters = "clamp=3,clampConstant=0,clampMin=0,clampMax=1", variants = "DpadAxes")]
	[InputControl(name = "dpad/left", offset = 0u, bit = 0u, sizeInBits = 32u, format = "FLT", parameters = "clamp=3,clampConstant=0,clampMin=-1,clampMax=0,invert", variants = "DpadAxes")]
	[InputControl(name = "dpad/right", offset = 0u, bit = 0u, sizeInBits = 32u, format = "FLT", parameters = "clamp=3,clampConstant=0,clampMin=0,clampMax=1", variants = "DpadAxes")]
	[InputControl(name = "dpad", layout = "Dpad", offset = 88u, format = "VEC2", sizeInBits = 64u, variants = "DpadAxes")]
	[InputControl(name = "rightTrigger", offset = 116u, parameters = "clamp=1,clampMin=0,clampMax=1.0", variants = "Gamepad")]
	public unsafe fixed float axis[48];

	public FourCC format => kFormat;

	public unsafe AndroidGameControllerState WithButton(AndroidKeyCode code, bool value = true)
	{
		fixed (uint* ptr = buttons)
		{
			if (value)
			{
				ptr[(int)code / 32] |= (uint)(1 << (int)code % 32);
			}
			else
			{
				ptr[(int)code / 32] &= (uint)(~(1 << (int)code % 32));
			}
		}
		return this;
	}

	public unsafe AndroidGameControllerState WithAxis(AndroidAxis axis, float value)
	{
		fixed (float* ptr = this.axis)
		{
			ptr[(int)axis] = value;
		}
		return this;
	}
}
