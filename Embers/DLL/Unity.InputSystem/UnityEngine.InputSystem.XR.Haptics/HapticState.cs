namespace UnityEngine.InputSystem.XR.Haptics;

public struct HapticState(uint samplesQueued, uint samplesAvailable)
{
	public uint samplesQueued { get; private set; } = samplesQueued;

	public uint samplesAvailable { get; private set; } = samplesAvailable;
}
