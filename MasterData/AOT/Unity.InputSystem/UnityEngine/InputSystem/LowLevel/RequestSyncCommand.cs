using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 8)]
public struct RequestSyncCommand : IInputDeviceCommandInfo
{
	internal const int kSize = 8;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	public static FourCC Type => new FourCC('S', 'Y', 'N', 'C');

	public FourCC typeStatic => Type;

	public static RequestSyncCommand Create()
	{
		return new RequestSyncCommand
		{
			baseCommand = new InputDeviceCommand(Type)
		};
	}
}
