using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 9)]
public struct EnableIMECompositionCommand : IInputDeviceCommandInfo
{
	internal const int kSize = 12;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	private byte m_ImeEnabled;

	public static FourCC Type => new FourCC('I', 'M', 'E', 'M');

	public bool imeEnabled => m_ImeEnabled != 0;

	public FourCC typeStatic => Type;

	public static EnableIMECompositionCommand Create(bool enabled)
	{
		return new EnableIMECompositionCommand
		{
			baseCommand = new InputDeviceCommand(Type, 9),
			m_ImeEnabled = (byte)(enabled ? byte.MaxValue : 0)
		};
	}
}
