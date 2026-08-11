using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 9)]
public struct QueryCanRunInBackground : IInputDeviceCommandInfo
{
	internal const int kSize = 9;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	public bool canRunInBackground;

	public static FourCC Type => new FourCC('Q', 'R', 'I', 'B');

	public FourCC typeStatic => Type;

	public static QueryCanRunInBackground Create()
	{
		return new QueryCanRunInBackground
		{
			baseCommand = new InputDeviceCommand(Type, 9),
			canRunInBackground = false
		};
	}
}
