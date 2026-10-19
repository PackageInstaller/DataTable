namespace UnityEngine.InputSystem.XR.Haptics;

public struct HapticCapabilities(uint numChannels, bool supportsImpulse, bool supportsBuffer, uint frequencyHz, uint maxBufferSize, uint optimalBufferSize)
{
	public uint numChannels { get; } = numChannels;

	public bool supportsImpulse { get; } = supportsImpulse;

	public bool supportsBuffer { get; } = supportsBuffer;

	public uint frequencyHz { get; } = frequencyHz;

	public uint maxBufferSize { get; } = maxBufferSize;

	public uint optimalBufferSize { get; } = optimalBufferSize;

	public HapticCapabilities(uint numChannels, uint frequencyHz, uint maxBufferSize)
		: this(numChannels, supportsImpulse: false, supportsBuffer: false, frequencyHz, maxBufferSize, 0u)
	{
	}
}
