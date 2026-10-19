using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 560)]
internal struct TouchscreenState : IInputStateTypeInfo
{
	public const int MaxTouches = 10;

	[FieldOffset(0)]
	[InputControl(name = "primaryTouch", displayName = "Primary Touch", layout = "Touch", synthetic = true)]
	[InputControl(name = "position", useStateFrom = "primaryTouch/position")]
	[InputControl(name = "delta", useStateFrom = "primaryTouch/delta", layout = "Delta")]
	[InputControl(name = "pressure", useStateFrom = "primaryTouch/pressure")]
	[InputControl(name = "radius", useStateFrom = "primaryTouch/radius")]
	[InputControl(name = "press", useStateFrom = "primaryTouch/phase", layout = "TouchPress", synthetic = true, usages = new string[] { })]
	[InputControl(name = "displayIndex", useStateFrom = "primaryTouch/displayIndex", format = "BYTE")]
	[InputControl(name = "primaryTouch/tap", usage = "PrimaryAction")]
	public unsafe fixed byte primaryTouchData[56];

	internal const int kTouchDataOffset = 56;

	[FieldOffset(56)]
	[InputControl(layout = "Touch", name = "touch", displayName = "Touch", arraySize = 10)]
	public unsafe fixed byte touchData[560];

	public static FourCC Format => new FourCC('T', 'S', 'C', 'R');

	public unsafe TouchState* primaryTouch
	{
		get
		{
			fixed (byte* result = primaryTouchData)
			{
				return (TouchState*)result;
			}
		}
	}

	public unsafe TouchState* touches
	{
		get
		{
			fixed (byte* result = touchData)
			{
				return (TouchState*)result;
			}
		}
	}

	public FourCC format => Format;
}
