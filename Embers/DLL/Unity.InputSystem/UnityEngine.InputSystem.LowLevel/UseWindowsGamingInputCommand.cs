using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 9)]
internal struct UseWindowsGamingInputCommand : IInputDeviceCommandInfo
{
	internal const int kSize = 9;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	public byte enable;

	public static FourCC Type => new FourCC('U', 'W', 'G', 'I');

	public FourCC typeStatic => Type;

	public static UseWindowsGamingInputCommand Create(bool enable)
	{
		return new UseWindowsGamingInputCommand
		{
			baseCommand = new InputDeviceCommand(Type, 9),
			enable = (byte)(enable ? 1u : 0u)
		};
	}
}
