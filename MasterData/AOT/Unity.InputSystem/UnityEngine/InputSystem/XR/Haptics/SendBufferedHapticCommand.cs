using System;
using System.Runtime.InteropServices;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.XR.Haptics;

[StructLayout(LayoutKind.Explicit, Size = 1040)]
public struct SendBufferedHapticCommand : IInputDeviceCommandInfo
{
	private const int kMaxHapticBufferSize = 1024;

	private const int kSize = 1040;

	[FieldOffset(0)]
	private InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	private int channel;

	[FieldOffset(12)]
	private int bufferSize;

	[FieldOffset(16)]
	private unsafe fixed byte buffer[1024];

	private static FourCC Type => new FourCC('X', 'H', 'U', '0');

	public FourCC typeStatic => Type;

	public unsafe static SendBufferedHapticCommand Create(byte[] rumbleBuffer)
	{
		if (rumbleBuffer == null)
		{
			throw new ArgumentNullException("rumbleBuffer");
		}
		int num = Mathf.Min(1024, rumbleBuffer.Length);
		SendBufferedHapticCommand result = new SendBufferedHapticCommand
		{
			baseCommand = new InputDeviceCommand(Type, 1040),
			bufferSize = num
		};
		SendBufferedHapticCommand* ptr = &result;
		fixed (byte* ptr2 = rumbleBuffer)
		{
			for (int i = 0; i < num; i++)
			{
				ptr->buffer[i] = ptr2[i];
			}
		}
		return result;
	}
}
