using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

public class QWorldCameraShakeTimelinePreviewNodePlayable : PlayableBehaviour
{
	public NoiseSettings noiseSettings;

	public float amplitudeGainInput;

	public float frequencyGainInput;

	private CinemachineVirtualCamera virtualCamera;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		virtualCamera = Camera.main.GetComponent<CinemachineBrain>().ActiveVirtualCamera as CinemachineVirtualCamera;
		if (virtualCamera != null)
		{
			CinemachineBasicMultiChannelPerlin cinemachineBasicMultiChannelPerlin = virtualCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
			if (null == cinemachineBasicMultiChannelPerlin)
			{
				cinemachineBasicMultiChannelPerlin = virtualCamera.AddCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
			}
			cinemachineBasicMultiChannelPerlin.m_NoiseProfile = noiseSettings;
			cinemachineBasicMultiChannelPerlin.m_AmplitudeGain = amplitudeGainInput;
			cinemachineBasicMultiChannelPerlin.m_FrequencyGain = frequencyGainInput;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (virtualCamera != null)
		{
			CinemachineBasicMultiChannelPerlin cinemachineComponent = virtualCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
			if (!(null == cinemachineComponent))
			{
				cinemachineComponent.m_NoiseProfile = null;
				cinemachineComponent.m_AmplitudeGain = 0f;
				cinemachineComponent.m_FrequencyGain = 0f;
			}
		}
	}
}
