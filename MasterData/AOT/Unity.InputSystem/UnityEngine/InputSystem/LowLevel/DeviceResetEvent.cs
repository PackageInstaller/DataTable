using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Size = 20)]
public struct DeviceResetEvent : IInputEventTypeInfo
{
	public const int Type = 1146245972;

	[FieldOffset(0)]
	public InputEvent baseEvent;

	[FieldOffset(8)]
	public bool hardReset;

	public FourCC typeStatic => 1146245972;

	public static DeviceResetEvent Create(int deviceId, bool hardReset = false, double time = -1.0)
	{
		DeviceResetEvent result = new DeviceResetEvent
		{
			baseEvent = new InputEvent(1146245972, 20, deviceId, time)
		};
		result.hardReset = hardReset;
		return result;
	}
}
