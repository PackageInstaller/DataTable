using System;
using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 264)]
public struct QueryKeyboardLayoutCommand : IInputDeviceCommandInfo
{
	internal const int kMaxNameLength = 256;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	public unsafe fixed byte nameBuffer[256];

	public static FourCC Type => new FourCC('K', 'B', 'L', 'T');

	public FourCC typeStatic => Type;

	public unsafe string ReadLayoutName()
	{
		fixed (QueryKeyboardLayoutCommand* ptr = &this)
		{
			return StringHelpers.ReadStringFromBuffer(new IntPtr(ptr->nameBuffer), 256);
		}
	}

	public unsafe void WriteLayoutName(string name)
	{
		fixed (QueryKeyboardLayoutCommand* ptr = &this)
		{
			StringHelpers.WriteStringToBuffer(name, new IntPtr(ptr->nameBuffer), 256);
		}
	}

	public static QueryKeyboardLayoutCommand Create()
	{
		return new QueryKeyboardLayoutCommand
		{
			baseCommand = new InputDeviceCommand(Type, 264)
		};
	}
}
