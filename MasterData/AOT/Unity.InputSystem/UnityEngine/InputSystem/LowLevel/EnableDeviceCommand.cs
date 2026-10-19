using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 8)]
public struct EnableDeviceCommand : IInputDeviceCommandInfo
{
	internal const int kSize = 8;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	public static FourCC Type => new FourCC('E', 'N', 'B', 'L');

	public FourCC typeStatic => Type;

	public static EnableDeviceCommand Create()
	{
		return new EnableDeviceCommand
		{
			baseCommand = new InputDeviceCommand(Type)
		};
	}
}
