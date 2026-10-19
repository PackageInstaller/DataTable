using System;
using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 520)]
internal struct QueryUserIdCommand : IInputDeviceCommandInfo
{
	public const int kMaxIdLength = 256;

	internal const int kSize = 520;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	public unsafe fixed byte idBuffer[512];

	public static FourCC Type => new FourCC('U', 'S', 'E', 'R');

	public FourCC typeStatic => Type;

	public unsafe string ReadId()
	{
		fixed (QueryUserIdCommand* ptr = &this)
		{
			return StringHelpers.ReadStringFromBuffer(new IntPtr(ptr->idBuffer), 256);
		}
	}

	public static QueryUserIdCommand Create()
	{
		return new QueryUserIdCommand
		{
			baseCommand = new InputDeviceCommand(Type, 520)
		};
	}
}
