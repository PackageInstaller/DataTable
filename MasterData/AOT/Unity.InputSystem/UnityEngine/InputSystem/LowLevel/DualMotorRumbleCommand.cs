using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 16)]
internal struct DualMotorRumbleCommand : IInputDeviceCommandInfo
{
	internal const int kSize = 16;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	public float lowFrequencyMotorSpeed;

	[FieldOffset(12)]
	public float highFrequencyMotorSpeed;

	public static FourCC Type => new FourCC('R', 'M', 'B', 'L');

	public FourCC typeStatic => Type;

	public static DualMotorRumbleCommand Create(float lowFrequency, float highFrequency)
	{
		return new DualMotorRumbleCommand
		{
			baseCommand = new InputDeviceCommand(Type, 16),
			lowFrequencyMotorSpeed = lowFrequency,
			highFrequencyMotorSpeed = highFrequency
		};
	}
}
