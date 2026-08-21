using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 16)]
public struct SetIMECursorPositionCommand : IInputDeviceCommandInfo
{
	internal const int kSize = 16;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	private Vector2 m_Position;

	public static FourCC Type => new FourCC('I', 'M', 'E', 'P');

	public Vector2 position => m_Position;

	public FourCC typeStatic => Type;

	public static SetIMECursorPositionCommand Create(Vector2 cursorPosition)
	{
		return new SetIMECursorPositionCommand
		{
			baseCommand = new InputDeviceCommand(Type, 16),
			m_Position = cursorPosition
		};
	}
}
