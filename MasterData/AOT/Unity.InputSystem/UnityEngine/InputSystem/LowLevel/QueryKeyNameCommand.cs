using System;
using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 268)]
public struct QueryKeyNameCommand : IInputDeviceCommandInfo
{
	internal const int kMaxNameLength = 256;

	internal const int kSize = 268;

	[FieldOffset(0)]
	public InputDeviceCommand baseCommand;

	[FieldOffset(8)]
	public int scanOrKeyCode;

	[FieldOffset(12)]
	public unsafe fixed byte nameBuffer[256];

	public static FourCC Type => new FourCC('K', 'Y', 'C', 'F');

	public FourCC typeStatic => Type;

	public unsafe string ReadKeyName()
	{
		fixed (QueryKeyNameCommand* ptr = &this)
		{
			return StringHelpers.ReadStringFromBuffer(new IntPtr(ptr->nameBuffer), 256);
		}
	}

	public static QueryKeyNameCommand Create(Key key)
	{
		return new QueryKeyNameCommand
		{
			baseCommand = new InputDeviceCommand(Type, 268),
			scanOrKeyCode = (int)key
		};
	}
}
