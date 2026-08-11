using System;

namespace UnityEngine.InputSystem.XR.Haptics;

public struct BufferedRumble
{
	public HapticCapabilities capabilities { get; private set; }

	private InputDevice device { get; set; }

	public BufferedRumble(InputDevice device)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		this.device = device;
		GetHapticCapabilitiesCommand command = GetHapticCapabilitiesCommand.Create();
		device.ExecuteCommand(ref command);
		capabilities = command.capabilities;
	}

	public void EnqueueRumble(byte[] samples)
	{
		SendBufferedHapticCommand command = SendBufferedHapticCommand.Create(samples);
		device.ExecuteCommand(ref command);
	}
}
