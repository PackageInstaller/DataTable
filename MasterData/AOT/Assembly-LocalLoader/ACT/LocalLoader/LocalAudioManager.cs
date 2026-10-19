using System;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Unity.Collections;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.LocalLoader;

public class LocalAudioManager : MonoBehaviour
{
	[SerializeField]
	[FormerlySerializedAs("persistentEnvironmentSource")]
	private AudioSource _persistentEnvironmentSource;

	[SerializeField]
	[ReadOnly]
	private string _persistentEnvironmentClipAddress;

	[SerializeField]
	[FormerlySerializedAs("persistentBgmSource")]
	private AudioSource _persistentBgmSource;

	[SerializeField]
	[ReadOnly]
	private string _persistentBgmClipAddress;

	[FormerlySerializedAs("persistentClickSource")]
	[SerializeField]
	private AudioSource _persistentClickSource;

	[SerializeField]
	private AudioSource _persistentBtnClickSource;

	[SerializeField]
	private AudioSource _persistentWindowSource;

	[SerializeField]
	[ReadOnly]
	private string _persistentWindowClipAddress;

	[SerializeField]
	private AudioSource _persistentWindowCloseSource;

	[SerializeField]
	[ReadOnly]
	private string _persistentWindowCloseClipAddress;

	[SerializeField]
	[ReadOnly]
	private string _persistentBtnClickClipAddress;

	[SerializeField]
	[ReadOnly]
	private string _persistentClickClipAddress;

	[SerializeField]
	private AudioSource _persistentCommonBtnClickSource;

	[SerializeField]
	[ReadOnly]
	private string _persistentCommonBtnClickClipAddress;

	[SerializeField]
	private AudioSource persistentBoardSource;

	[ReadOnly]
	[SerializeField]
	private string persistentBoardClipAddress;

	private bool _persistentEnvironmentCouldRelease;

	private bool _persistentBgmCouldRelease;

	public bool SoundIsOpen { get; private set; } = true;

	private void OnEnable()
	{
		UnityEngine.Object.DontDestroyOnLoad(gameObject);
		LoadAudioClipAssets();
		InitPersistentAudio();
	}

	private void OnDisable()
	{
		StopSoundSlowly();
	}

	private async void InitPersistentAudio()
	{
		_persistentEnvironmentSource.volume = 0.3f;
		_persistentBgmSource.volume = 0.3f;
		_persistentClickSource.volume = 1f;
		_persistentBtnClickSource.volume = 1f;
		_persistentCommonBtnClickSource.volume = 1f;
		persistentBoardSource.volume = 1f;
		_persistentEnvironmentSource.Play();
		if (!SoundIsOpen)
		{
			_persistentEnvironmentSource.Pause();
		}
		await UniTask.Delay(5000);
		if (_persistentBgmSource != null)
		{
			_persistentBgmSource.Play();
			if (!SoundIsOpen)
			{
				_persistentBgmSource.Pause();
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("背景音乐开始播放");
			}
		}
	}

	public void PlayWindowSound()
	{
		if (_persistentWindowSource != null)
		{
			_persistentWindowSource.Play();
		}
	}

	public void PlayWindowCloseSound()
	{
		if (_persistentWindowCloseSource != null)
		{
			_persistentWindowCloseSource.Play();
		}
	}

	public void PlayOptionBtnClickSound()
	{
		if (_persistentBtnClickSource != null)
		{
			_persistentBtnClickSource.Play();
		}
	}

	public void PlayLoginSound()
	{
		if (_persistentClickSource != null)
		{
			_persistentClickSource.Play();
		}
	}

	public void PlayCommonBtnClickSound()
	{
		if (_persistentCommonBtnClickSource != null)
		{
			_persistentCommonBtnClickSource.Play();
		}
	}

	public void PlayBoardSound()
	{
		persistentBoardSource.Play();
	}

	private void LoadAudioClipAssets()
	{
		_persistentEnvironmentCouldRelease = (_persistentBgmCouldRelease = false);
		LoadAudioClipAssets(_persistentEnvironmentSource, in _persistentEnvironmentClipAddress);
		LoadAudioClipAssets(_persistentBgmSource, in _persistentBgmClipAddress);
		LoadAudioClipAssets(_persistentClickSource, in _persistentClickClipAddress);
		LoadAudioClipAssets(_persistentBtnClickSource, in _persistentBtnClickClipAddress);
		LoadAudioClipAssets(_persistentWindowSource, in _persistentWindowClipAddress);
		LoadAudioClipAssets(_persistentWindowCloseSource, in _persistentWindowCloseClipAddress);
		LoadAudioClipAssets(_persistentCommonBtnClickSource, in _persistentCommonBtnClickClipAddress);
		LoadAudioClipAssets(persistentBoardSource, in persistentBoardClipAddress);
	}

	private void LoadAudioClipAssets(AudioSource source, in string resourcePath)
	{
		if (!(source == null) && !(source.clip != null) && resourcePath != null)
		{
			AudioClip clip = Resources.Load<AudioClip>(resourcePath);
			source.clip = clip;
		}
	}

	public void SoundBtnClick(bool isPause)
	{
		if (!(_persistentEnvironmentSource != null))
		{
			return;
		}
		if (isPause)
		{
			_persistentEnvironmentSource.Pause();
			if (_persistentBgmSource != null && _persistentBgmSource.isPlaying)
			{
				_persistentBgmSource.Pause();
			}
			SoundIsOpen = false;
		}
		else
		{
			_persistentEnvironmentSource.UnPause();
			if (_persistentBgmSource != null && _persistentBgmSource.clip != null && !_persistentBgmSource.isPlaying)
			{
				_persistentBgmSource.UnPause();
			}
			SoundIsOpen = true;
		}
	}

	private void StopSoundSlowly()
	{
		FadeoutSound(_persistentEnvironmentSource, () =>
		{
			_persistentEnvironmentCouldRelease = true;
			TryReleaseAudioClipAssets();
		});
		FadeoutSound(_persistentBgmSource, () =>
		{
			_persistentBgmCouldRelease = true;
			TryReleaseAudioClipAssets();
		});
	}

	private void FadeoutSound(AudioSource source, Action onCompleteCallback = null)
	{
		if (source != null && source.isPlaying)
		{
			DOTween.To(() => source.volume, (float x) =>
			{
				source.volume = x;
			}, 0f, 1f).SetEase(Ease.OutQuad).SetUpdate(isIndependentUpdate: true)
				.OnComplete(() =>
				{
					if (!(source == null))
					{
						source.Stop();
						onCompleteCallback?.Invoke();
					}
				});
		}
		else
		{
			onCompleteCallback?.Invoke();
		}
	}

	private void TryReleaseAudioClipAssets()
	{
		if (_persistentBgmCouldRelease && _persistentEnvironmentCouldRelease)
		{
			ReleaseAudioClipAsset(_persistentEnvironmentSource);
			ReleaseAudioClipAsset(_persistentBgmSource);
			ReleaseAudioClipAsset(_persistentClickSource);
			ReleaseAudioClipAsset(_persistentBtnClickSource);
			ReleaseAudioClipAsset(_persistentWindowSource);
			ReleaseAudioClipAsset(_persistentWindowCloseSource);
			ReleaseAudioClipAsset(_persistentCommonBtnClickSource);
			ReleaseAudioClipAsset(persistentBoardSource);
			Resources.UnloadUnusedAssets();
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("持久化音频资源已释放");
			}
		}
	}

	private void ReleaseAudioClipAsset(AudioSource source)
	{
		if (!(source == null) && !(source.clip == null))
		{
			AudioClip clip = source.clip;
			source.Stop();
			source.clip = null;
			Resources.UnloadAsset(clip);
		}
	}
}
