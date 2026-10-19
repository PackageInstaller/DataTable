using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 8)]
public struct DisableDeviceCommand : IInputDeviceCommandInfo
{
	internal const int kSize = 8;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	public static FourCC Type => new FourCC('D', 'S', 'B', 'L');

	public FourCC typeStatic => Type;

	public static DisableDeviceCommand Create()
	{
		return new DisableDeviceCommand
		{
			baseCommand = new InputDeviceCommand(Type)
		};
	}
}
