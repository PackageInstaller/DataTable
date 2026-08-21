using System.Runtime.InteropServices;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.XR.Haptics;

[StructLayout(LayoutKind.Explicit, Size = 20)]
public struct GetHapticCapabilitiesCommand : IInputDeviceCommandInfo
{
	private const int kSize = 20;

	[FieldOffset(0)]
	private InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	public uint numChannels;

	[FieldOffset(12)]
	public uint frequencyHz;

	[FieldOffset(16)]
	public uint maxBufferSize;

	private static FourCC Type => new FourCC('X', 'H', 'C', '0');

	public FourCC typeStatic => Type;

	public HapticCapabilities capabilities => new HapticCapabilities(numChannels, frequencyHz, maxBufferSize);

	public static GetHapticCapabilitiesCommand Create()
	{
		return new GetHapticCapabilitiesCommand
		{
			baseCommand = new InputDeviceCommand(Type, 20)
		};
	}
}
