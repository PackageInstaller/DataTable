using System.Collections.Generic;
using Cinemachine;

namespace QWorld.Story.Runtime;

public class QWStoryCameraShakeComponent
{
	private Dictionary<string, NoiseSettings> noises;

	private bool isInShake;

	private CinemachineVirtualCamera curShakeCamera;

	public void StartShake(string cfgPath, float amplitude, float frequency)
	{
		if (noises == null)
		{
			noises = new Dictionary<string, NoiseSettings>();
		}
		if (isInShake)
		{
			StopShake();
		}
		if (!noises.ContainsKey(cfgPath))
		{
			noises.Add(cfgPath, Asset.Load<NoiseSettings>(cfgPath));
		}
		isInShake = true;
		curShakeCamera = QWorldCameraManager.Instance.MainCamera.GetComponent<CinemachineBrain>().ActiveVirtualCamera as CinemachineVirtualCamera;
		if (curShakeCamera != null)
		{
			CinemachineBasicMultiChannelPerlin cinemachineBasicMultiChannelPerlin = curShakeCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
			if (null == cinemachineBasicMultiChannelPerlin)
			{
				cinemachineBasicMultiChannelPerlin = curShakeCamera.AddCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
			}
			cinemachineBasicMultiChannelPerlin.m_NoiseProfile = noises[cfgPath];
			cinemachineBasicMultiChannelPerlin.m_AmplitudeGain = amplitude;
			cinemachineBasicMultiChannelPerlin.m_FrequencyGain = frequency;
		}
	}

	public void StopShake()
	{
		if (noises == null)
		{
			return;
		}
		isInShake = false;
		if (curShakeCamera != null)
		{
			CinemachineBasicMultiChannelPerlin cinemachineComponent = curShakeCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
			if (!(null == cinemachineComponent))
			{
				cinemachineComponent.m_NoiseProfile = null;
				cinemachineComponent.m_AmplitudeGain = 0f;
				cinemachineComponent.m_FrequencyGain = 0f;
			}
		}
	}

	public void Dispose()
	{
		if (noises == null)
		{
			return;
		}
		foreach (KeyValuePair<string, NoiseSettings> noise in noises)
		{
			Asset.Unload(noise.Key);
		}
	}
}
