using System.Collections;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Sound.Core;
using ACT.Sound.Management;
using Fundamental;
using UnityEngine;

namespace ACT.Sound;

public class BGMManager : Singleton<BGMManager>
{
	private sealed class BGMSlot
	{
		public BGMConfig config;

		public uint pausedInstanceId;

		public string pausedEventPath;

		public bool IsEmpty
		{
			get
			{
				if (config == null)
				{
					return pausedInstanceId == 0;
				}
				return false;
			}
		}
	}

	private readonly Dictionary<BGMType, BGMSlot> _bgmSlots = new Dictionary<BGMType, BGMSlot>();

	private string _currentEventPath;

	private BGMType _currentPlayingType;

	private uint _currentBGMInstanceId;

	private bool _isPlaying;

	private float _retryTimer;

	private const float RETRY_INTERVAL = 1f;

	private const int MAX_RETRY_COUNT = 5;

	private int _retryCount;

	private static readonly WaitForSeconds s_CheckBGMStateInterval = new WaitForSeconds(0.5f);

	private Coroutine _checkBGMStateCoroutine;

	private MonoECS _checkBGMStateCoroutineRunner;

	public override ContextType ContextType => ContextType.GAME;

	public override void Init()
	{
		StopCheckBGMState();
		_bgmSlots.Clear();
		_currentPlayingType = BGMType.Scene;
		_currentBGMInstanceId = 0u;
		_isPlaying = false;
		_currentEventPath = null;
		_retryCount = 0;
		_retryTimer = 0f;
		MonoECS monoECS = MonoECS.instance;
		if (monoECS != null)
		{
			_checkBGMStateCoroutineRunner = monoECS;
			_checkBGMStateCoroutine = monoECS.StartCoroutine(CheckBGMState());
		}
	}

	public override void UnInit()
	{
		StopCheckBGMState();
		StopCurrentBGM(fadeOut: false);
		StopAllPausedBGM(fadeOut: false);
		_bgmSlots.Clear();
	}

	private void StopCheckBGMState()
	{
		if (_checkBGMStateCoroutine != null && _checkBGMStateCoroutineRunner != null)
		{
			_checkBGMStateCoroutineRunner.StopCoroutine(_checkBGMStateCoroutine);
		}
		_checkBGMStateCoroutine = null;
		_checkBGMStateCoroutineRunner = null;
	}

	public void SetBGM(BGMType type, string eventPath, float volume = 1f)
	{
		BGMSlot orCreateSlot = GetOrCreateSlot(type);
		if (orCreateSlot.pausedInstanceId != 0 && !string.IsNullOrEmpty(orCreateSlot.pausedEventPath) && orCreateSlot.pausedEventPath != eventPath)
		{
			ClearPausedData(type, orCreateSlot, shouldStop: true, fadeOut: true);
			orCreateSlot = GetOrCreateSlot(type);
		}
		orCreateSlot.config = new BGMConfig(eventPath, volume);
		ResetRetryState();
		UpdateCurrentBGM();
	}

	public void ClearBGM(BGMType type)
	{
		if (_bgmSlots.TryGetValue(type, out var value))
		{
			value.config = null;
			ClearPausedData(type, value, shouldStop: true, fadeOut: false);
		}
		if (type == _currentPlayingType)
		{
			StopCurrentBGMInternal(fadeOut: true);
			UpdateCurrentBGM();
		}
	}

	public void ClearAllBGM()
	{
		StopCurrentBGM();
		StopAllPausedBGM(fadeOut: true);
		_bgmSlots.Clear();
	}

	public BGMType GetHighestPriorityBGMType()
	{
		for (int num = 4; num >= 0; num--)
		{
			BGMType bGMType = (BGMType)num;
			if (TryGetConfig(bGMType, out var _))
			{
				return bGMType;
			}
		}
		return BGMType.Scene;
	}

	public BGMType GetCurrentPlayingType()
	{
		return _currentPlayingType;
	}

	public uint GetCurrentBGMInstanceId()
	{
		return _currentBGMInstanceId;
	}

	public bool IsPlaying()
	{
		return _isPlaying;
	}

	public void StopCurrentBGM(bool fadeOut = true)
	{
		StopCurrentBGMInternal(fadeOut);
	}

	public void ForcePlayBGM(BGMType type, bool fadeOut = true)
	{
		if (TryGetConfig(type, out var config))
		{
			PlayBGMInternal(type, config, fadeOut);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"[BGMManager] Cannot force play BGM of type {type}: No config set");
		}
	}

	private void StopCurrentBGMInternal(bool fadeOut)
	{
		if (_currentBGMInstanceId != 0)
		{
			Singleton<GameManager>.instance.audioManager?.Stop(_currentBGMInstanceId, fadeOut);
			_currentBGMInstanceId = 0u;
		}
		_isPlaying = false;
		_currentEventPath = null;
	}

	private void UpdateCurrentBGM()
	{
		BGMType highestPriorityBGMType = GetHighestPriorityBGMType();
		if (!TryGetConfig(highestPriorityBGMType, out var config))
		{
			StopCurrentBGMInternal(fadeOut: true);
		}
		else if (highestPriorityBGMType != _currentPlayingType || !_isPlaying || _currentEventPath != config.eventPath)
		{
			PlayBGMInternal(highestPriorityBGMType, config, fadeOutCurrent: true);
		}
	}

	private void PlayBGMInternal(BGMType type, BGMConfig config, bool fadeOutCurrent)
	{
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		if (audioManager == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[BGMManager] AudioManager is null, cannot play BGM");
			}
			_isPlaying = false;
			return;
		}
		if (_currentBGMInstanceId != 0)
		{
			PauseOrReplaceCurrentBGM(type, config, fadeOutCurrent);
		}
		audioManager.SetGlobalParameter("Scene_Music_Change", 0);
		if (TryReplayPausedBGM(type, config))
		{
			ResetRetryState();
		}
		else
		{
			PlayNewBGM(type, config);
		}
	}

	private void PauseOrReplaceCurrentBGM(BGMType type, BGMConfig newConfig, bool fadeOut)
	{
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		if (audioManager == null)
		{
			_currentBGMInstanceId = 0u;
			_isPlaying = false;
			return;
		}
		BGMType currentPlayingType = _currentPlayingType;
		string currentEventPath = _currentEventPath;
		if (currentPlayingType == type && !string.IsNullOrEmpty(currentEventPath) && currentEventPath != newConfig.eventPath)
		{
			audioManager.Stop(_currentBGMInstanceId, fadeOut);
			if (_bgmSlots.TryGetValue(currentPlayingType, out var value))
			{
				value.pausedInstanceId = 0u;
				value.pausedEventPath = null;
				TryRemoveSlot(currentPlayingType, value);
			}
		}
		else
		{
			BGMSlot orCreateSlot = GetOrCreateSlot(currentPlayingType);
			if (orCreateSlot.pausedInstanceId != 0 && orCreateSlot.pausedInstanceId != _currentBGMInstanceId)
			{
				audioManager.Stop(orCreateSlot.pausedInstanceId, fadeOut);
			}
			PooledAudioInstance instanceById = audioManager.GetInstanceById(_currentBGMInstanceId);
			if (instanceById?.Instance != null && instanceById.Instance.IsValid)
			{
				audioManager.SetPause(_currentBGMInstanceId, pause: true);
				orCreateSlot.pausedInstanceId = _currentBGMInstanceId;
				orCreateSlot.pausedEventPath = currentEventPath;
			}
			else
			{
				orCreateSlot.pausedInstanceId = 0u;
				orCreateSlot.pausedEventPath = null;
				TryRemoveSlot(currentPlayingType, orCreateSlot);
			}
		}
		_currentBGMInstanceId = 0u;
		_isPlaying = false;
	}

	private bool TryReplayPausedBGM(BGMType type, BGMConfig config)
	{
		if (!_bgmSlots.TryGetValue(type, out var value) || value.pausedInstanceId == 0)
		{
			return false;
		}
		if (string.IsNullOrEmpty(value.pausedEventPath))
		{
			ClearPausedData(type, value, shouldStop: true, fadeOut: false);
			return false;
		}
		if (value.pausedEventPath != config.eventPath)
		{
			ClearPausedData(type, value, shouldStop: true, fadeOut: true);
			return false;
		}
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		IAudioInstance audioInstance = (audioManager?.GetInstanceById(value.pausedInstanceId))?.Instance;
		if (audioInstance == null || !audioInstance.IsValid)
		{
			ClearPausedData(type, value, shouldStop: false, fadeOut: false);
			return false;
		}
		audioManager.SetPlaybackTime(value.pausedInstanceId, 0f);
		audioManager.SetPause(value.pausedInstanceId, pause: false);
		_currentBGMInstanceId = value.pausedInstanceId;
		_currentPlayingType = type;
		_currentEventPath = config.eventPath;
		_isPlaying = true;
		value.pausedInstanceId = 0u;
		value.pausedEventPath = null;
		TryRemoveSlot(type, value);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[BGMManager] Resumed BGM from beginning: Type={type}, Path={config.eventPath}");
		}
		return true;
	}

	private void PlayNewBGM(BGMType type, BGMConfig config)
	{
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		if (audioManager == null)
		{
			_currentPlayingType = type;
			_currentEventPath = config.eventPath;
			_isPlaying = false;
			_currentBGMInstanceId = 0u;
			return;
		}
		AudioPlayOptions options = new AudioPlayOptions
		{
			volume = config.volume
		};
		_currentBGMInstanceId = audioManager.PlaySound(config.eventPath, options);
		_currentPlayingType = type;
		_currentEventPath = config.eventPath;
		_isPlaying = _currentBGMInstanceId != 0;
		if (_isPlaying)
		{
			ResetRetryState();
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[BGMManager] Playing BGM: Type={type}, Path={config.eventPath}, Volume={config.volume}");
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"[BGMManager] Failed to play BGM: Type={type}, Path={config.eventPath}, will retry");
		}
	}

	private void ResetRetryState()
	{
		_retryCount = 0;
		_retryTimer = 0f;
	}

	private bool TryGetConfig(BGMType type, out BGMConfig config)
	{
		config = null;
		if (!_bgmSlots.TryGetValue(type, out var value) || value.config == null || string.IsNullOrEmpty(value.config.eventPath))
		{
			return false;
		}
		config = value.config;
		return true;
	}

	private BGMSlot GetOrCreateSlot(BGMType type)
	{
		if (!_bgmSlots.TryGetValue(type, out var value))
		{
			value = new BGMSlot();
			_bgmSlots[type] = value;
		}
		return value;
	}

	private void ClearPausedData(BGMType type, BGMSlot slot, bool shouldStop, bool fadeOut)
	{
		if ((slot.pausedInstanceId != 0) & shouldStop)
		{
			Singleton<GameManager>.instance.audioManager?.Stop(slot.pausedInstanceId, fadeOut);
		}
		slot.pausedInstanceId = 0u;
		slot.pausedEventPath = null;
		TryRemoveSlot(type, slot);
	}

	private void TryRemoveSlot(BGMType type, BGMSlot slot)
	{
		if (slot.IsEmpty)
		{
			_bgmSlots.Remove(type);
		}
	}

	private void StopAllPausedBGM(bool fadeOut)
	{
		List<BGMType> list = null;
		foreach (KeyValuePair<BGMType, BGMSlot> bgmSlot in _bgmSlots)
		{
			BGMSlot value = bgmSlot.Value;
			if (value.pausedInstanceId != 0)
			{
				Singleton<GameManager>.instance.audioManager?.Stop(value.pausedInstanceId, fadeOut);
				value.pausedInstanceId = 0u;
				value.pausedEventPath = null;
			}
			if (value.IsEmpty)
			{
				if (list == null)
				{
					list = new List<BGMType>();
				}
				list.Add(bgmSlot.Key);
			}
		}
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				_bgmSlots.Remove(list[i]);
			}
		}
	}

	private IEnumerator CheckBGMState()
	{
		while (true)
		{
			yield return s_CheckBGMStateInterval;
			if (!_isPlaying || _currentBGMInstanceId == 0)
			{
				TryRetryFailedPlayback();
			}
			else if (!IsCurrentBGMStillPlaying())
			{
				BGMType currentPlayingType = _currentPlayingType;
				if (LuminApplication.LogEnabled)
				{
					Debug.Log($"[BGMManager] BGM ended, auto clearing type: {currentPlayingType}");
				}
				_isPlaying = false;
				ClearBGM(currentPlayingType);
			}
		}
	}

	private void TryRetryFailedPlayback()
	{
		BGMType highestPriorityBGMType = GetHighestPriorityBGMType();
		if (!TryGetConfig(highestPriorityBGMType, out var config))
		{
			return;
		}
		if (_retryCount >= 5)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"[BGMManager] BGM playback failed after {5} retries, clearing type: {highestPriorityBGMType}, Path={config.eventPath}");
			}
			if (_bgmSlots.TryGetValue(highestPriorityBGMType, out var value))
			{
				value.config = null;
				ClearPausedData(highestPriorityBGMType, value, shouldStop: true, fadeOut: false);
			}
			ResetRetryState();
			UpdateCurrentBGM();
			return;
		}
		_retryTimer += 0.5f;
		if (!(_retryTimer < 1f))
		{
			_retryTimer = 0f;
			_retryCount++;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[BGMManager] Retrying BGM playback (attempt {_retryCount}/{5}): Type={highestPriorityBGMType}, Path={config.eventPath}");
			}
			PlayBGMInternal(highestPriorityBGMType, config, fadeOutCurrent: false);
		}
	}

	private bool IsCurrentBGMStillPlaying()
	{
		IAudioInstance audioInstance = (Singleton<GameManager>.instance.audioManager?.GetInstanceById(_currentBGMInstanceId))?.Instance;
		if (audioInstance == null || !audioInstance.IsValid)
		{
			return false;
		}
		audioInstance.GetPlaybackState(out var state);
		return state != AudioPlaybackState.Stopped;
	}
}
