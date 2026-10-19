using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 16)]
public struct QueryDimensionsCommand : IInputDeviceCommandInfo
{
	internal const int kSize = 16;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	public Vector2 outDimensions;

	public static FourCC Type => new FourCC('D', 'I', 'M', 'S');

	public FourCC typeStatic => Type;

	public static QueryDimensionsCommand Create()
	{
		return new QueryDimensionsCommand
		{
			baseCommand = new InputDeviceCommand(Type, 16)
		};
	}
}
