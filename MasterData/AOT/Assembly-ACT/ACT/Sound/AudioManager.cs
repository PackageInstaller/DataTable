using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Sound.Core;
using ACT.Sound.Management;
using ACT.Sound.State;
using ACT.World.Modules.SceneAudios;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Sound;

public class AudioManager : GameSubManager
{
	private AudioInstancePool _instancePool;

	private AudioBankManager _bankManager;

	private AudioStateManager _stateManager;

	private AudioPlaybackHandler _playbackHandler;

	private AudioStopHandler _stopHandler;

	private AudioListenerManager _listenerManager;

	private readonly List<PooledAudioInstance> _channelInstances = new List<PooledAudioInstance>();

	private readonly string[] _busPaths = new string[1] { "bus:/SFX/In_UI" };

	private readonly string[] _vcaPaths = new string[4] { "vca:/Main", "vca:/MUS", "vca:/SFX", "vca:/VO" };

	private bool _isGameStateEnabled = true;

	public override ContextType ContextType => ContextType.GAME;

	public bool IsGameStateEnabled => _isGameStateEnabled;

	public UniTask<uint> PlaySoundAsync(AudioEventReference eventRef, AudioPlayOptions options = default(AudioPlayOptions))
	{
		return PlaySoundAsync((IAudioEventReference)eventRef, options);
	}

	public uint PlaySound(AudioEventReference eventRef, AudioPlayOptions options = default(AudioPlayOptions))
	{
		if (!options.forcePlay && !_isGameStateEnabled)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[AudioManager] Cannot play sound: Game state is disabled");
			}
			return 0u;
		}
		return _playbackHandler?.Play((IAudioEventReference)eventRef, options) ?? 0;
	}

	public void SetGameState(bool enabled)
	{
		_isGameStateEnabled = enabled;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[AudioManager] Game state changed to: " + (enabled ? "Enabled" : "Disabled"));
		}
	}

	protected override void Init()
	{
		if (_instancePool == null)
		{
			_instancePool = new AudioInstancePool();
		}
		if (_bankManager == null)
		{
			_bankManager = new AudioBankManager();
		}
		if (_stateManager == null)
		{
			_stateManager = new AudioStateManager();
		}
		if (_listenerManager == null)
		{
			_listenerManager = new AudioListenerManager();
		}
		if (_playbackHandler == null)
		{
			_playbackHandler = new AudioPlaybackHandler(_instancePool, _channelInstances, _bankManager);
		}
		if (_stopHandler == null)
		{
			_stopHandler = new AudioStopHandler(_instancePool, _channelInstances);
		}
		_listenerManager.Initialize();
		Singleton<EventManager>.instance?.AddEventListener(ClientEvent.BattleCharacterChange, OnCharacterChanged);
		Singleton<EventManager>.instance?.AddEventListener(ClientEvent.OnSpawnCharacterBattlePart, OnCharacterSpawned);
		Singleton<EventManager>.instance?.AddEventListener(ClientEvent.BattleStateChange, OnBattleStateChange);
		Singleton<GameManager>.instance.worldManager.RegisterOnSceneSoundChangeCallback(OnSceneSoundChanged);
	}

	protected override void UnInit()
	{
		StopAll();
		Singleton<EventManager>.instance?.RemoveEventListener(ClientEvent.BattleCharacterChange, OnCharacterChanged);
		Singleton<EventManager>.instance?.RemoveEventListener(ClientEvent.OnSpawnCharacterBattlePart, OnCharacterSpawned);
		Singleton<EventManager>.instance?.RemoveEventListener(ClientEvent.BattleStateChange, OnBattleStateChange);
	}

	protected override void Update()
	{
		_instancePool?.Update();
		_bankManager?.Update(Time.deltaTime);
	}

	public void LoadSceneBank(YooAssetReference bankAsset, Action onComplete = null)
	{
		_bankManager?.LoadBank(bankAsset, onComplete);
	}

	public void UnloadSceneBank(YooAssetReference bankAsset)
	{
		_bankManager?.UnloadBank(bankAsset);
	}

	public void LoadBank(YooAssetReference bankAsset, Action onComplete = null)
	{
		_bankManager?.LoadBank(bankAsset, onComplete);
	}

	public void LoadBankAsync(YooAssetReference bankAsset, Action<bool> onComplete = null)
	{
		if (bankAsset == null || _bankManager == null)
		{
			onComplete?.Invoke(obj: false);
		}
		else
		{
			_bankManager.LoadBankByGuidAsync(bankAsset.GUID, onComplete);
		}
	}

	public void LoadBanks(List<YooAssetReference> banks, Action onComplete = null)
	{
		_bankManager?.LoadBanks(banks, onComplete);
	}

	public void UnloadBank(YooAssetReference bankAsset)
	{
		_bankManager?.UnloadBank(bankAsset);
	}

	public bool IsBankLoaded(string bankGuid)
	{
		return _bankManager?.IsBankLoaded(bankGuid) ?? false;
	}

	public bool AreBanksLoaded(List<YooAssetReference> banks)
	{
		return _bankManager?.AreBanksLoaded(banks) ?? false;
	}

	public void Stop(uint id, bool fadeOut = true)
	{
		_stopHandler?.Stop(id, fadeOut);
	}

	public void StopAll()
	{
		_stopHandler?.StopAll();
	}

	public void StopBus(AudioBusType busType, bool fadeOut = true)
	{
		AudioCore.GetBus(_busPaths[(int)busType])?.StopAllEvents(fadeOut);
	}

	public void PauseBus(AudioBusType busType, bool pause)
	{
		AudioCore.GetBus(_busPaths[(int)busType])?.PauseAllEvents(pause);
	}

	public void SetVCAVolume(AudioVCAType vcaType, float volume)
	{
		AudioCore.GetVCA(_vcaPaths[(int)vcaType])?.SetVolume(volume);
	}

	public float GetVCAVolume(AudioVCAType vcaType)
	{
		return AudioCore.GetVCA(_vcaPaths[(int)vcaType])?.GetVolume() ?? 0f;
	}

	public void SetParameter(uint id, string parameterName, float value)
	{
		(_instancePool?.GetInstance(id))?.Instance?.SetParameter(parameterName, value);
	}

	public void SetParameter(uint id, string parameterName, int value)
	{
		(_instancePool?.GetInstance(id))?.Instance?.SetParameter(parameterName, value);
	}

	public void SetSpatialMode(uint id, AudioSpatialMode spatialMode)
	{
		PooledAudioInstance pooledAudioInstance = _instancePool?.GetInstance(id);
		if (pooledAudioInstance?.Instance != null)
		{
			int num;
			switch (spatialMode)
			{
			case AudioSpatialMode.Default:
				return;
			default:
				num = 0;
				break;
			case AudioSpatialMode.Spatial2D:
				num = 1;
				break;
			}
			int value = num;
			pooledAudioInstance?.Instance.SetParameter("Interact_2D_3D", value);
		}
	}

	public void SetGlobalParameter(string parameterName, int value)
	{
		_stateManager.SetParameter(parameterName, value);
	}

	public void SetGlobalParameter<TEnum>(TEnum enumValue) where TEnum : Enum
	{
		_stateManager.SetParameter(enumValue);
	}

	public void SetPlaybackTime(uint id, float timeInSeconds)
	{
		PooledAudioInstance pooledAudioInstance = _instancePool?.GetInstance(id);
		if (pooledAudioInstance?.Instance != null)
		{
			pooledAudioInstance.Instance.PlaybackTime = timeInSeconds;
		}
	}

	public float GetPlaybackTime(uint id)
	{
		return ((_instancePool?.GetInstance(id))?.Instance?.PlaybackTime).GetValueOrDefault();
	}

	public bool IsPlaying(uint id)
	{
		return (_instancePool?.GetInstance(id))?.Instance?.IsPlaying == true;
	}

	public PooledAudioInstance GetInstanceById(uint id)
	{
		return _instancePool?.GetInstance(id);
	}

	private void OnCharacterChanged(BaseEventContent obj)
	{
		if (obj is BattleCharacterChangeEvt battleCharacterChangeEvt)
		{
			SetListener(battleCharacterChangeEvt.newEb.GetModel(), 0);
		}
	}

	private void OnCharacterSpawned(BaseEventContent obj)
	{
		if (obj is SpawnCharacterBattlePartEvt spawnCharacterBattlePartEvt && spawnCharacterBattlePartEvt.entityBehave.IsCharacter() && spawnCharacterBattlePartEvt.entityBehave == MonoECS.instance.mainEntity)
		{
			SetListener(spawnCharacterBattlePartEvt.entityBehave.GetModel(), 0);
		}
	}

	public void SetListener(GameObject obj, int state)
	{
		if (_listenerManager != null && obj != null)
		{
			_listenerManager.SetAttenuationObject(obj);
		}
	}

	public void PauseAll()
	{
		_instancePool?.PauseAll(paused: true);
	}

	public void ResumeAll()
	{
		_instancePool?.PauseAll(paused: false);
	}

	public void SetPause(uint id, bool pause)
	{
		if (pause)
		{
			_instancePool?.Pause(id);
		}
		else
		{
			_instancePool?.Resume(id);
		}
	}

	private void OnSceneSoundChanged(SceneAudioUpdateInfo info)
	{
		if (info.IsBGMChanged)
		{
			Singleton<BGMManager>.instance.SetBGM(BGMType.Scene, info.BgmSoundAddress);
		}
		if (info.IsBGMStateChanged)
		{
			SetGlobalParameter("Scene_Music_Change", info.BgmState);
		}
		if (info.IsEnvChanged)
		{
			Singleton<EnvironmentAudioManager>.instance.PlayEnvironment(info.EnvSoundAddress);
		}
		if (info.IsReverbChanged)
		{
			Singleton<SnapshotReverbManager>.instance.SetSnapshotReverb(info.Reverb);
		}
		if (info.IsStepMatChanged)
		{
			Singleton<RoadMaterialManager>.instance.SetGlobalRoadMaterial(info.StepMaterialId, MaterialType.Road);
		}
	}

	private void OnBattleStateChange(BaseEventContent evt)
	{
		BattleStateChange battleStateChange = evt as BattleStateChange;
		BattleState to = battleStateChange.to;
		switch (to)
		{
		case BattleState.None:
			if (BattleState.Boss == battleStateChange.from)
			{
				Singleton<BGMManager>.instance.ClearBGM(BGMType.Boss);
			}
			SetGlobalParameter("Music_Change", 0);
			break;
		case BattleState.Normal:
			if (Singleton<GameState>.instance.BattleFormState == BattleFormState.Seal)
			{
				SetGlobalParameter("Music_Change", 2);
			}
			else
			{
				SetGlobalParameter("Music_Change", 1);
			}
			break;
		case BattleState.Elite:
			if (Singleton<GameState>.instance.BattleFormState == BattleFormState.Seal)
			{
				SetGlobalParameter("Music_Change", 2);
			}
			else
			{
				SetGlobalParameter("Music_Change", 1);
			}
			break;
		case BattleState.Boss:
			if (!MonoECS.instance.audioBattleMusic.IsNull())
			{
				SetGlobalParameter("Boss_Music_Change", 0);
				Singleton<BGMManager>.instance.SetBGM(BGMType.Boss, MonoECS.instance.audioBattleMusic);
			}
			break;
		default:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"[BGMManager] Unknown battle state: {to}");
			}
			break;
		}
	}

	public UniTask<uint> PlaySoundAsync(IAudioEventReference eventRef, AudioPlayOptions options = default(AudioPlayOptions))
	{
		if (eventRef == null || eventRef.IsNull())
		{
			return UniTask.FromResult(0u);
		}
		if (!options.forcePlay && !_isGameStateEnabled)
		{
			return UniTask.FromResult(0u);
		}
		return _playbackHandler?.PlayAsync(eventRef, options) ?? UniTask.FromResult(0u);
	}

	public uint PlaySound(IAudioEventReference eventRef, AudioPlayOptions options = default(AudioPlayOptions))
	{
		if (!options.forcePlay && !_isGameStateEnabled)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[AudioManager] Cannot play sound: Game state is disabled");
			}
			return 0u;
		}
		return _playbackHandler?.Play(eventRef, options) ?? 0;
	}

	public UniTask<uint> PlaySoundAsync(string eventPath, AudioPlayOptions options = default(AudioPlayOptions))
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return UniTask.FromResult(0u);
		}
		if (!options.forcePlay && !_isGameStateEnabled)
		{
			return UniTask.FromResult(0u);
		}
		return _playbackHandler?.PlayAsync(eventPath, options) ?? UniTask.FromResult(0u);
	}

	public uint PlaySound(string eventPath, AudioPlayOptions options = default(AudioPlayOptions))
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return 0u;
		}
		if (!options.forcePlay && !_isGameStateEnabled)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[AudioManager] Cannot play sound '" + eventPath + "': Game state is disabled");
			}
			return 0u;
		}
		return _playbackHandler?.Play(eventPath, options) ?? 0;
	}
}
