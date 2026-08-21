using System.Collections;
using UnityEngine;
using UnityEngine.Audio;

namespace GameFramework.Runtime;

public class DefaultSoundAgentHelper : SoundAgentHelperBase
{
	private Transform m_CachedTransform = null;

	private AudioSource m_AudioSource = null;

	private float m_VolumeWhenPause = 0f;

	public override bool IsPlaying => m_AudioSource.isPlaying;

	public override float Length => ((Object)(object)m_AudioSource.clip != null) ? m_AudioSource.clip.length : 0f;

	public override float Time
	{
		get
		{
			return m_AudioSource.time;
		}
		set
		{
			m_AudioSource.time = value;
		}
	}

	public override bool Mute
	{
		get
		{
			return m_AudioSource.mute;
		}
		set
		{
			m_AudioSource.mute = value;
		}
	}

	public override bool Loop
	{
		get
		{
			return m_AudioSource.loop;
		}
		set
		{
			m_AudioSource.loop = value;
		}
	}

	public override int Priority
	{
		get
		{
			return 128 - m_AudioSource.priority;
		}
		set
		{
			m_AudioSource.priority = 128 - value;
		}
	}

	public override float Volume
	{
		get
		{
			return m_AudioSource.volume;
		}
		set
		{
			m_AudioSource.volume = value;
		}
	}

	public override float Pitch
	{
		get
		{
			return m_AudioSource.pitch;
		}
		set
		{
			m_AudioSource.pitch = value;
		}
	}

	public override float PanStereo
	{
		get
		{
			return m_AudioSource.panStereo;
		}
		set
		{
			m_AudioSource.panStereo = value;
		}
	}

	public override float SpatialBlend
	{
		get
		{
			return m_AudioSource.spatialBlend;
		}
		set
		{
			m_AudioSource.spatialBlend = value;
		}
	}

	public override float MaxDistance
	{
		get
		{
			return m_AudioSource.maxDistance;
		}
		set
		{
			m_AudioSource.maxDistance = value;
		}
	}

	public override float DopplerLevel
	{
		get
		{
			return m_AudioSource.dopplerLevel;
		}
		set
		{
			m_AudioSource.dopplerLevel = value;
		}
	}

	public override AudioMixerGroup AudioMixerGroup
	{
		get
		{
			return m_AudioSource.outputAudioMixerGroup;
		}
		set
		{
			m_AudioSource.outputAudioMixerGroup = value;
		}
	}

	public override void Play(float fadeInSeconds)
	{
		StopAllCoroutines();
		m_AudioSource.Play();
		if (fadeInSeconds > 0f)
		{
			float volume = m_AudioSource.volume;
			m_AudioSource.volume = 0f;
			StartCoroutine(FadeToVolume(m_AudioSource, volume, fadeInSeconds));
		}
	}

	public override void Stop(float fadeOutSeconds)
	{
		StopAllCoroutines();
		if (fadeOutSeconds > 0f && base.gameObject.activeInHierarchy)
		{
			StartCoroutine(StopCo(fadeOutSeconds));
		}
		else
		{
			m_AudioSource.Stop();
		}
	}

	public override void Pause(float fadeOutSeconds)
	{
		StopAllCoroutines();
		m_VolumeWhenPause = m_AudioSource.volume;
		if (fadeOutSeconds > 0f && base.gameObject.activeInHierarchy)
		{
			StartCoroutine(PauseCo(fadeOutSeconds));
		}
		else
		{
			m_AudioSource.Pause();
		}
	}

	public override void Resume(float fadeInSeconds)
	{
		StopAllCoroutines();
		m_AudioSource.UnPause();
		if (fadeInSeconds > 0f)
		{
			StartCoroutine(FadeToVolume(m_AudioSource, m_VolumeWhenPause, fadeInSeconds));
		}
		else
		{
			m_AudioSource.volume = m_VolumeWhenPause;
		}
	}

	public override void Reset()
	{
		m_CachedTransform.localPosition = Vector3.zero;
		m_AudioSource.clip = null;
		m_VolumeWhenPause = 0f;
	}

	public override bool SetSoundAsset(object soundAsset)
	{
		AudioClip val = (AudioClip)((soundAsset is AudioClip) ? soundAsset : null);
		if ((Object)(object)val == null)
		{
			return false;
		}
		m_AudioSource.clip = val;
		return true;
	}

	public override void SetWorldPosition(Vector3 worldPosition)
	{
		m_CachedTransform.position = worldPosition;
	}

	private void Awake()
	{
		m_CachedTransform = base.transform;
		m_AudioSource = base.gameObject.GetOrAddComponent<AudioSource>();
		m_AudioSource.playOnAwake = false;
		m_AudioSource.rolloffMode = (AudioRolloffMode)2;
	}

	private IEnumerator StopCo(float fadeOutSeconds)
	{
		yield return FadeToVolume(m_AudioSource, 0f, fadeOutSeconds);
		m_AudioSource.Stop();
	}

	private IEnumerator PauseCo(float fadeOutSeconds)
	{
		yield return FadeToVolume(m_AudioSource, 0f, fadeOutSeconds);
		m_AudioSource.Pause();
	}

	private IEnumerator FadeToVolume(AudioSource audioSource, float volume, float duration)
	{
		float time = 0f;
		float originalVolume = audioSource.volume;
		while (time < duration)
		{
			time += UnityEngine.Time.deltaTime;
			audioSource.volume = Mathf.Lerp(originalVolume, volume, time / duration);
			yield return new WaitForEndOfFrame();
		}
		audioSource.volume = volume;
	}
}
