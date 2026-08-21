using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 20)]
public struct DeviceRemoveEvent : IInputEventTypeInfo
{
	public const int Type = 1146242381;

	[FieldOffset(0)]
	public InputEvent baseEvent;

	public FourCC typeStatic => 1146242381;

	public unsafe InputEventPtr ToEventPtr()
	{
		fixed (DeviceRemoveEvent* eventPtr = &this)
		{
			return new InputEventPtr((InputEvent*)eventPtr);
		}
	}

	public static DeviceRemoveEvent Create(int deviceId, double time = -1.0)
	{
		return new DeviceRemoveEvent
		{
			baseEvent = new InputEvent(1146242381, 20, deviceId, time)
		};
	}
}
