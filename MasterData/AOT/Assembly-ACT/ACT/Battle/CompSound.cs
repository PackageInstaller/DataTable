using System;
using System.Collections.Generic;
using ACT.Sound;
using ACT.Sound.Management;
using Fundamental;

namespace ACT.Battle;

public class CompSound : EcsComponent
{
	public List<uint> soundInstance;

	public List<YooAssetReference> banks;

	public Dictionary<int, string> voiceMap;

	private uint _curVoiceId;

	private bool _curSoundPausedByFixedSpeed;

	public List<uint> allSoundInstance;

	private readonly Action<uint> _onSoundReleased;

	private AudioManager _soundAudioManager;

	public CompSound()
	{
		soundInstance = new List<uint>();
		allSoundInstance = new List<uint>();
		_onSoundReleased = OnSoundReleased;
	}

	protected override void OnGet()
	{
		soundInstance.Clear();
		allSoundInstance.Clear();
		_soundAudioManager = null;
		_curSoundPausedByFixedSpeed = false;
	}

	protected override void OnRelease()
	{
		UnregisterSoundCallbacks();
		StopAllSoundOnRelease();
		soundInstance.Clear();
		allSoundInstance.Clear();
		_soundAudioManager = null;
		_curSoundPausedByFixedSpeed = false;
		StopVoice();
		ReleaseBanks();
		voiceMap = null;
	}

	public void Init(Dictionary<int, string> voices)
	{
		voiceMap = voices;
	}

	public void LoadBank(YooAssetReference bank)
	{
		if (banks == null)
		{
			banks = ListPool<YooAssetReference>.Get();
		}
		banks.Add(bank);
		Singleton<GameManager>.instance.audioManager.LoadBank(bank);
	}

	public void SetCurSound(uint instance)
	{
		if (instance != 0)
		{
			soundInstance.Add(instance);
			if (_curSoundPausedByFixedSpeed)
			{
				Singleton<GameManager>.instance.audioManager.SetPause(instance, pause: true);
			}
		}
	}

	public void SetCurSoundPausedByFixedSpeed(bool paused)
	{
		if (_curSoundPausedByFixedSpeed != paused)
		{
			_curSoundPausedByFixedSpeed = paused;
			if (paused)
			{
				PauseCurSound();
			}
			else
			{
				ResumeCurSound();
			}
		}
	}

	public void StopCurSound()
	{
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		for (int i = 0; i < soundInstance.Count; i++)
		{
			uint num = soundInstance[i];
			if (num != 0)
			{
				UnregisterSoundCallback(audioManager, num);
				RemoveSoundInstance(allSoundInstance, num);
				audioManager.Stop(num);
			}
		}
		soundInstance.Clear();
	}

	private void StopAllSoundOnRelease()
	{
	}

	public void ReleaseBanks()
	{
		if (banks == null)
		{
			return;
		}
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		foreach (YooAssetReference bank in banks)
		{
			audioManager.UnloadBank(bank);
		}
		ListPool<YooAssetReference>.Release(banks);
		banks = null;
	}

	public uint PlayVoice(int voiceId, AudioPlayOptions options = default(AudioPlayOptions))
	{
		if (voiceMap == null || !voiceMap.TryGetValue(voiceId, out var value))
		{
			return 0u;
		}
		StopVoice();
		_curVoiceId = Singleton<AudioVoiceManager>.instance.Play(value, options);
		return _curVoiceId;
	}

	public bool IsCurrentVoice(uint voiceId)
	{
		if (voiceId != 0)
		{
			return _curVoiceId == voiceId;
		}
		return false;
	}

	public void StopVoice(bool fadeOut = true)
	{
		if (_curVoiceId != 0)
		{
			Singleton<AudioVoiceManager>.instance.Stop(_curVoiceId, fadeOut);
			_curVoiceId = 0u;
		}
	}

	public void SetSoundInstance(uint instance)
	{
		if (instance == 0)
		{
			return;
		}
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		PooledAudioInstance instanceById = audioManager.GetInstanceById(instance);
		if (instanceById != null)
		{
			_soundAudioManager = audioManager;
			instanceById.OnRegistrationReleased = _onSoundReleased;
			allSoundInstance.Add(instance);
			if (_curSoundPausedByFixedSpeed)
			{
				audioManager.SetPause(instance, pause: true);
			}
		}
	}

	private void OnSoundReleased(uint instance)
	{
		RemoveSoundInstance(allSoundInstance, instance);
		RemoveSoundInstance(soundInstance, instance);
	}

	private static void RemoveSoundInstance(List<uint> instances, uint instance)
	{
		int num = instances.IndexOf(instance);
		if (num >= 0)
		{
			int index = instances.Count - 1;
			instances[num] = instances[index];
			instances.RemoveAt(index);
		}
	}

	private void UnregisterSoundCallback(AudioManager audioMgr, uint instance)
	{
		PooledAudioInstance instanceById = audioMgr.GetInstanceById(instance);
		if (instanceById != null && instanceById.OnRegistrationReleased == _onSoundReleased)
		{
			instanceById.OnRegistrationReleased = null;
		}
	}

	private void UnregisterSoundCallbacks()
	{
		AudioManager soundAudioManager = _soundAudioManager;
		if (allSoundInstance.Count != 0 && soundAudioManager != null)
		{
			for (int i = 0; i < allSoundInstance.Count; i++)
			{
				UnregisterSoundCallback(soundAudioManager, allSoundInstance[i]);
			}
		}
	}

	public void PauseCurSound()
	{
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		for (int i = 0; i < allSoundInstance.Count; i++)
		{
			if (allSoundInstance[i] != 0)
			{
				audioManager.SetPause(allSoundInstance[i], pause: true);
			}
		}
	}

	public void ResumeCurSound()
	{
		AudioManager audioManager = Singleton<GameManager>.instance.audioManager;
		for (int i = 0; i < allSoundInstance.Count; i++)
		{
			if (allSoundInstance[i] != 0)
			{
				audioManager.SetPause(allSoundInstance[i], pause: false);
			}
		}
	}
}
