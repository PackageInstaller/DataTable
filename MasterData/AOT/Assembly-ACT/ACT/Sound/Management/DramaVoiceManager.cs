using System;
using ACT.Sound.Language;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Sound.Management;

public class DramaVoiceManager : Singleton<DramaVoiceManager>
{
	private uint _currentVoiceInstanceId;

	private string _currentEventPath = string.Empty;

	private string _currentParamName = string.Empty;

	private bool _isPlaying;

	private bool _isPaused;

	private Transform _attachedTransform;

	private Action<string, int, long> _loadULipSyncBakeDataFileEventHandler;

	private Action _stopULipSyncEventHandler;

	public override ContextType ContextType => ContextType.GAME;

	public bool curDisplayHaveVoice { get; private set; }

	public event Action<string, int> OnVoiceStarted;

	public event Action OnVoiceEnded;

	public event Action<bool> OnVoicePausedChanged;

	public event Action<string, int, long> OnloadULipSyncBakeDataFileEventHandler
	{
		add
		{
			_loadULipSyncBakeDataFileEventHandler = (Action<string, int, long>)Delegate.Combine(_loadULipSyncBakeDataFileEventHandler, value);
		}
		remove
		{
			_loadULipSyncBakeDataFileEventHandler = (Action<string, int, long>)Delegate.Remove(_loadULipSyncBakeDataFileEventHandler, value);
		}
	}

	public event Action OnStopULipSyncEventHandler
	{
		add
		{
			_stopULipSyncEventHandler = (Action)Delegate.Combine(_stopULipSyncEventHandler, value);
		}
		remove
		{
			_stopULipSyncEventHandler = (Action)Delegate.Remove(_stopULipSyncEventHandler, value);
		}
	}

	public override void Init()
	{
		_currentVoiceInstanceId = 0u;
		_currentEventPath = string.Empty;
		_currentParamName = string.Empty;
		_isPlaying = false;
		_isPaused = false;
		_attachedTransform = null;
	}

	public override void UnInit()
	{
		StopCurrentVoice();
		OnVoiceStarted = null;
		OnVoiceEnded = null;
		OnVoicePausedChanged = null;
		_loadULipSyncBakeDataFileEventHandler = null;
		_stopULipSyncEventHandler = null;
	}

	public void SetVoice(string eventPath, Transform attachTransform = null)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			curDisplayHaveVoice = false;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[DramaVoiceManager] Event path is null or empty");
			}
			return;
		}
		StopCurrentVoice();
		_currentEventPath = eventPath;
		curDisplayHaveVoice = true;
		_attachedTransform = attachTransform;
		string[] array = eventPath.Split('/');
		_currentParamName = array[array.Length - 1];
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[DramaVoiceManager] Voice set: Path=" + eventPath + ", Param=" + _currentParamName);
		}
	}

	public async UniTask SetVoiceState(int state)
	{
		if (string.IsNullOrEmpty(_currentEventPath))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[DramaVoiceManager] Cannot play voice: No voice set");
			}
			return;
		}
		if (_currentVoiceInstanceId != 0)
		{
			StopCurrentVoice();
		}
		if (state == 0)
		{
			return;
		}
		try
		{
			if (Singleton<GameManager>.instance.audioManager == null)
			{
				Debug.LogError("[DramaVoiceManager] AudioManager instance is null");
				return;
			}
			AudioPlayOptions options = new AudioPlayOptions
			{
				attachTarget = _attachedTransform
			};
			string eventPath = AudioVoiceManager.ResolveLanguagePath(_currentEventPath);
			_currentVoiceInstanceId = Singleton<GameManager>.instance.audioManager.PlaySound(eventPath, options);
			if (_currentVoiceInstanceId != 0)
			{
				_isPlaying = true;
				_isPaused = false;
				_loadULipSyncBakeDataFileEventHandler?.Invoke(_currentParamName, state, 0L);
				if (!string.IsNullOrEmpty(_currentParamName))
				{
					Singleton<GameManager>.instance.audioManager.SetParameter(_currentVoiceInstanceId, _currentParamName, state);
				}
				OnVoiceStarted?.Invoke(_currentEventPath, state);
				if (LuminApplication.LogEnabled)
				{
					Debug.Log($"[DramaVoiceManager] Voice playing: Path={_currentEventPath}, Param={_currentParamName}, Value={state}, InstanceId={_currentVoiceInstanceId}");
				}
				await WaitForVoicePaused();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[DramaVoiceManager] Failed to play voice: " + _currentEventPath);
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("[DramaVoiceManager] Error playing voice: " + ex.Message);
		}
	}

	public async UniTask PlayVoiceAsync(int paramValue = 0)
	{
		await SetVoiceState((paramValue == 0) ? 1 : paramValue);
	}

	public void PlayVoice()
	{
		SetVoiceState(1).Forget();
	}

	public void PauseVoice(bool pause)
	{
		if (_currentVoiceInstanceId == 0 || !_isPlaying)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[DramaVoiceManager] Cannot pause/resume: No voice is playing");
			}
			return;
		}
		try
		{
			Singleton<GameManager>.instance.audioManager?.SetPause(_currentVoiceInstanceId, pause);
			_isPaused = pause;
			OnVoicePausedChanged?.Invoke(pause);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("[DramaVoiceManager] Voice " + (pause ? "paused" : "resumed"));
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("[DramaVoiceManager] Error pausing/resuming voice: " + ex.Message);
		}
	}

	public void StopCurrentVoice(bool fadeOut = true)
	{
		if (_currentVoiceInstanceId == 0)
		{
			return;
		}
		try
		{
			Singleton<GameManager>.instance.audioManager?.Stop(_currentVoiceInstanceId, fadeOut);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[DramaVoiceManager] Voice stopped: InstanceId={_currentVoiceInstanceId}, FadeOut={fadeOut}");
			}
			_isPlaying = false;
			_isPaused = false;
		}
		catch (Exception ex)
		{
			Debug.LogError("[DramaVoiceManager] Error stopping voice: " + ex.Message);
		}
		_stopULipSyncEventHandler?.Invoke();
	}

	public void Release()
	{
		if (_currentVoiceInstanceId == 0)
		{
			return;
		}
		try
		{
			Singleton<GameManager>.instance.audioManager?.Stop(_currentVoiceInstanceId, fadeOut: false);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[DramaVoiceManager] Voice released: InstanceId={_currentVoiceInstanceId}");
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("[DramaVoiceManager] Error releasing voice: " + ex.Message);
		}
		ResetState();
	}

	public bool IsPlaying()
	{
		if (_isPlaying && _currentVoiceInstanceId != 0)
		{
			return Singleton<GameManager>.instance.audioManager.IsPlaying(_currentVoiceInstanceId);
		}
		return false;
	}

	public bool IsPaused()
	{
		return _isPaused;
	}

	public uint GetCurrentInstanceId()
	{
		return _currentVoiceInstanceId;
	}

	public string GetCurrentEventPath()
	{
		return _currentEventPath;
	}

	public string GetCurrentParamName()
	{
		return _currentParamName;
	}

	private async UniTask WaitForVoicePaused()
	{
		if (_currentVoiceInstanceId == 0)
		{
			return;
		}
		while (_isPlaying && _currentVoiceInstanceId != 0)
		{
			if (Singleton<GameManager>.instance.audioManager != null && !Singleton<GameManager>.instance.audioManager.IsPlaying(_currentVoiceInstanceId))
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.Log("[DramaVoiceManager] Voice reached paused state");
				}
				_isPaused = true;
				_isPlaying = false;
				OnVoiceEnded?.Invoke();
				break;
			}
			await UniTask.Yield();
		}
	}

	private async UniTask WaitForVoiceComplete()
	{
		if (_currentVoiceInstanceId == 0)
		{
			return;
		}
		while (_isPlaying && _currentVoiceInstanceId != 0)
		{
			if (Singleton<GameManager>.instance.audioManager != null && !Singleton<GameManager>.instance.audioManager.IsPlaying(_currentVoiceInstanceId))
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.Log("[DramaVoiceManager] Voice playback completed");
				}
				OnVoiceEnded?.Invoke();
				ResetState();
				break;
			}
			await UniTask.Yield();
		}
	}

	private void ResetState()
	{
		_currentVoiceInstanceId = 0u;
		_currentEventPath = string.Empty;
		_currentParamName = string.Empty;
		_isPlaying = false;
		_isPaused = false;
		_attachedTransform = null;
	}

	public bool HaveVoice(string eventPath)
	{
		string text = AudioVoiceManager.ResolveLanguagePath(eventPath);
		if (string.IsNullOrEmpty(text))
		{
			return false;
		}
		AudioConfig audioConfig = AudioConfig.Instance;
		if (audioConfig == null)
		{
			return false;
		}
		return !string.IsNullOrEmpty(audioConfig.GetBankGuidForEvent(text));
	}

	public async UniTask PlayVoiceEventAsync(string eventPath, Transform attachTransform = null, string lipSyncEventParamName = null, int lipSyncIndex = 0)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[DramaVoiceManager] Event path is null or empty");
			}
			return;
		}
		if (_currentVoiceInstanceId != 0)
		{
			StopCurrentVoice();
		}
		try
		{
			if (Singleton<GameManager>.instance.audioManager == null)
			{
				Debug.LogError("[DramaVoiceManager] AudioManager instance is null");
				return;
			}
			_currentEventPath = eventPath;
			_attachedTransform = attachTransform;
			_currentParamName = GetEventName(eventPath);
			AudioPlayOptions options = new AudioPlayOptions
			{
				attachTarget = _attachedTransform
			};
			string eventPath2 = AudioVoiceManager.ResolveLanguagePath(_currentEventPath);
			_currentVoiceInstanceId = Singleton<GameManager>.instance.audioManager.PlaySound(eventPath2, options);
			if (_currentVoiceInstanceId == 0)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("[DramaVoiceManager] Failed to play voice event: " + _currentEventPath);
				}
				return;
			}
			_isPlaying = true;
			_isPaused = false;
			if (!string.IsNullOrEmpty(lipSyncEventParamName) && lipSyncIndex != 0)
			{
				_loadULipSyncBakeDataFileEventHandler?.Invoke(lipSyncEventParamName, lipSyncIndex, ParseVoiceId(_currentParamName));
			}
			OnVoiceStarted?.Invoke(_currentEventPath, lipSyncIndex);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[DramaVoiceManager] Voice event playing: Path={_currentEventPath}, LipSyncIndex={lipSyncIndex}, InstanceId={_currentVoiceInstanceId}");
			}
			await WaitForVoiceComplete();
		}
		catch (Exception ex)
		{
			Debug.LogError("[DramaVoiceManager] Error playing voice event: " + ex.Message);
		}
	}

	public void PlayVoiceEvent(string eventPath, Transform attachTransform = null, string lipSyncEventParamName = null, int lipSyncIndex = 0)
	{
		PlayVoiceEventAsync(eventPath, attachTransform, lipSyncEventParamName, lipSyncIndex).Forget();
	}

	private static long ParseVoiceId(string eventName)
	{
		if (!long.TryParse(eventName, out var result))
		{
			return 0L;
		}
		return result;
	}

	private static string GetEventName(string eventPath)
	{
		int num = eventPath.LastIndexOf('/');
		if (num < 0 || num == eventPath.Length - 1)
		{
			return eventPath;
		}
		return eventPath.Substring(num + 1);
	}
}
