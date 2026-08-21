using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 8)]
public struct RequestResetCommand : IInputDeviceCommandInfo
{
	internal const int kSize = 8;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	public static FourCC Type => new FourCC('R', 'S', 'E', 'T');

	public FourCC typeStatic => Type;

	public static RequestResetCommand Create()
	{
		return new RequestResetCommand
		{
			baseCommand = new InputDeviceCommand(Type)
		};
	}
}
