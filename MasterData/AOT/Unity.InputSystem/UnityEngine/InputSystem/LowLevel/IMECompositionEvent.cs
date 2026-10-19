using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 152)]
public struct IMECompositionEvent : IInputEventTypeInfo
{
	internal const int kIMECharBufferSize = 64;

	public const int Type = 1229800787;

	[FieldOffset(0)]
	public InputEvent baseEvent;

	[FieldOffset(20)]
	public IMECompositionString compositionString;

	public FourCC typeStatic => 1229800787;

	public static IMECompositionEvent Create(int deviceId, string compositionString, double time)
	{
		return new IMECompositionEvent
		{
			baseEvent = new InputEvent(1229800787, 152, deviceId, time),
			compositionString = new IMECompositionString(compositionString)
		};
	}
}
