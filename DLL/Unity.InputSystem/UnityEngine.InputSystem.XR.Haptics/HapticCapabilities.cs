namespace UnityEngine.InputSystem.XR.Haptics;

public struct HapticCapabilities(uint numChannels, uint frequencyHz, uint maxBufferSize)
{
	public uint numChannels { get; private set; } = numChannels;

	public uint frequencyHz { get; private set; } = frequencyHz;

	public uint maxBufferSize { get; private set; } = maxBufferSize;
}
