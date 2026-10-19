using System.Runtime.InteropServices;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.XR.Haptics;

[StructLayout(LayoutKind.Explicit, Size = 28)]
public struct GetHapticCapabilitiesCommand : IInputDeviceCommandInfo
{
	private const int kSize = 28;

	[FieldOffset(0)]
	private InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	public uint numChannels;

	[FieldOffset(12)]
	public bool supportsImpulse;

	[FieldOffset(13)]
	public bool supportsBuffer;

	[FieldOffset(16)]
	public uint frequencyHz;

	[FieldOffset(20)]
	public uint maxBufferSize;

	[FieldOffset(24)]
	public uint optimalBufferSize;

	private static FourCC Type => new FourCC('X', 'H', 'C', '0');

	public FourCC typeStatic => Type;

	public HapticCapabilities capabilities => new HapticCapabilities(numChannels, supportsImpulse, supportsBuffer, frequencyHz, maxBufferSize, optimalBufferSize);

	public static GetHapticCapabilitiesCommand Create()
	{
		return new GetHapticCapabilitiesCommand
		{
			baseCommand = new InputDeviceCommand(Type, 28)
		};
	}
}
