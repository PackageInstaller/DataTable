using System;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.InputSystem.LowLevel;

internal static class InputRuntimeExtensions
{
	public unsafe static long DeviceCommand<TCommand>(this IInputRuntime runtime, int deviceId, ref TCommand command) where TCommand : struct, IInputDeviceCommandInfo
	{
		if (runtime == null)
		{
			throw new ArgumentNullException("runtime");
		}
		return runtime.DeviceCommand(deviceId, (InputDeviceCommand*)UnsafeUtility.AddressOf(ref command));
	}
}
