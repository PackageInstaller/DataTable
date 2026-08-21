using System;
using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 24)]
public struct TextEvent : IInputEventTypeInfo
{
	public const int Type = 1413830740;

	[FieldOffset(0)]
	public InputEvent baseEvent;

	[FieldOffset(20)]
	public int character;

	public FourCC typeStatic => 1413830740;

	public unsafe static TextEvent* From(InputEventPtr eventPtr)
	{
		if (!eventPtr.valid)
		{
			throw new ArgumentNullException("eventPtr");
		}
		if (!eventPtr.IsA<TextEvent>())
		{
			throw new InvalidCastException($"Cannot cast event with type '{eventPtr.type}' into TextEvent");
		}
		return (TextEvent*)eventPtr.data;
	}

	public static TextEvent Create(int deviceId, char character, double time = -1.0)
	{
		return new TextEvent
		{
			baseEvent = new InputEvent(1413830740, 24, deviceId, time),
			character = character
		};
	}

	public static TextEvent Create(int deviceId, int character, double time = -1.0)
	{
		return new TextEvent
		{
			baseEvent = new InputEvent(1413830740, 24, deviceId, time),
			character = character
		};
	}
}
