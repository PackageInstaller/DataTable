using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Core;
using ACT.UI;
using ACT.World.Data.Audios;
using ACT.World.SceneChunks;
using Fundamental;

namespace ACT.World.Modules.SceneAudios;

internal class SceneAudioModule : WorldModuleBase
{
	private enum SoundScopes
	{
		World,
		MapArea,
		SubMapArea,
		Chunk,
		ChunkState,
		Probe
	}

	private enum UpdateType
	{
		BGMSound = 1,
		BGMState,
		EnvSound,
		Reverb,
		StepMaterial
	}

	private const int MaxSoundScopeLevel = 6;

	private readonly string[] _bgmSoundNames = new string[6];

	private readonly string[] _envSoundNames = new string[6];

	private readonly string[] _reverbNames = new string[6];

	private readonly int[] _bgmStates = new int[6];

	private readonly int[] _stepMaterialIds = new int[6];

	private string _lastBgmSoundName;

	private string _lastEnvSoundName;

	private string _lastReverbName;

	private int _lastBgmState;

	private int _lastStepMaterialId;

	private List<SceneAudioProbeEntryControl> _audioProbeEntryControls;

	private readonly HashSet<UpdateType> _lastFrameChangedAudioTypes = new HashSet<UpdateType>();

	private string IgnoredStrValue = string.Empty;

	private int IgnoredIntValue;

	private bool _sceneAudioProbeIsChanged;

	private readonly List<SceneAudioOverrideProbeData> _activeAudioProbesList = new List<SceneAudioOverrideProbeData>();

	internal override bool NeedGotChunkChange => true;

	internal event Action<SceneAudioUpdateInfo> OnSceneAudioChanged;

	protected override void OnEnterWorld(WorldBase world)
	{
		base.OnEnterWorld(world);
		ResetAudioEventMaps();
		if (world is LoungeWorld)
		{
			CheckLoungeAudioProbeChanges();
		}
	}

	protected override void OnLeaveWorld(WorldBase world)
	{
		base.OnLeaveWorld(world);
		ResetAudioEventMaps();
		BoardcastSceneAudioChange();
	}

	protected override void OnClearLastChunk()
	{
		base.OnClearLastChunk();
		ResetAudioEventMaps();
		BoardcastSceneAudioChange();
	}

	private void ResetAudioEventMaps()
	{
		ClearAudioOverrideProbes(resetScopeValue: false);
		Array.Fill(_bgmSoundNames, IgnoredStrValue);
		Array.Fill(_bgmStates, IgnoredIntValue);
		Array.Fill(_envSoundNames, IgnoredStrValue);
		Array.Fill(_reverbNames, IgnoredStrValue);
		Array.Fill(_stepMaterialIds, IgnoredIntValue);
		_lastFrameChangedAudioTypes.Add(UpdateType.BGMSound);
		_lastFrameChangedAudioTypes.Add(UpdateType.BGMState);
		_lastFrameChangedAudioTypes.Add(UpdateType.EnvSound);
		_lastFrameChangedAudioTypes.Add(UpdateType.Reverb);
		_lastFrameChangedAudioTypes.Add(UpdateType.StepMaterial);
	}

	private void LoopCheckAudioProbeChanges()
	{
		if (!_sceneAudioProbeIsChanged)
		{
			return;
		}
		_sceneAudioProbeIsChanged = false;
		ClearScopeSceneSoundInfo(SoundScopes.Probe);
		foreach (SceneAudioOverrideProbeData activeAudioProbes in _activeAudioProbesList)
		{
			OverrideSceneAudioData overrideSceneAudioData = activeAudioProbes.OverrideSceneAudioData;
			UpdateOverrideData(overrideSceneAudioData, SoundScopes.Probe);
		}
	}

	private static T GetCorrectValue<T>(T value, T defaultValue, T emptyValue)
	{
		if (object.Equals(value, defaultValue))
		{
			return emptyValue;
		}
		return value;
	}

	private void UpdateOverrideData(OverrideSceneAudioData overrideData, SoundScopes scope)
	{
		if (overrideData.IsChangeBGM)
		{
			UpdateSceneSoundInfo(GetCorrectValue(overrideData.BgmSoundAddress, "", null), _bgmSoundNames, UpdateType.BGMSound, scope);
		}
		if (overrideData.IsChangeBGMState)
		{
			UpdateSceneSoundInfo(GetCorrectValue(overrideData.BgmState, 0, 0), _bgmStates, UpdateType.BGMState, scope);
		}
		if (overrideData.IsChangeEnv)
		{
			UpdateSceneSoundInfo(GetCorrectValue(overrideData.EnvSoundAddress, "", null), _envSoundNames, UpdateType.EnvSound, scope);
		}
		if (overrideData.IsChangeReverb)
		{
			UpdateSceneSoundInfo(GetCorrectValue(overrideData.ReverbAddress, "", null), _reverbNames, UpdateType.Reverb, scope);
		}
		if (overrideData.IsChangeStepMaterial)
		{
			UpdateSceneSoundInfo(GetCorrectValue(overrideData.StepMaterialId, 0, 0), _stepMaterialIds, UpdateType.StepMaterial, scope);
		}
	}

	private void ClearAudioOverrideProbes(bool resetScopeValue = true)
	{
		if (resetScopeValue)
		{
			ClearScopeSceneSoundInfo(SoundScopes.Probe);
		}
		if (_audioProbeEntryControls == null || _audioProbeEntryControls.Count == 0)
		{
			return;
		}
		foreach (SceneAudioProbeEntryControl audioProbeEntryControl in _audioProbeEntryControls)
		{
			audioProbeEntryControl.Unload();
		}
		_audioProbeEntryControls.Clear();
		_activeAudioProbesList.Clear();
		_sceneAudioProbeIsChanged = false;
	}

	private void ResetAudioOverrideProbes(SceneAudioOverrideProbeData[] activeStateSoundOverrideProbes)
	{
		ClearAudioOverrideProbes();
		if (activeStateSoundOverrideProbes != null && activeStateSoundOverrideProbes.Length != 0)
		{
			if (_audioProbeEntryControls == null)
			{
				_audioProbeEntryControls = new List<SceneAudioProbeEntryControl>();
			}
			foreach (SceneAudioOverrideProbeData data in activeStateSoundOverrideProbes)
			{
				SceneAudioProbeEntryControl sceneAudioProbeEntryControl = new SceneAudioProbeEntryControl(this, data);
				sceneAudioProbeEntryControl.Load();
				_audioProbeEntryControls.Add(sceneAudioProbeEntryControl);
			}
		}
	}

	private void CheckLoungeAudioProbeChanges()
	{
		SceneAudioOverrideProbeData[] activeStateSoundOverrideProbes = Array.Empty<SceneAudioOverrideProbeData>();
		ResetAudioOverrideProbes(activeStateSoundOverrideProbes);
		if (RuntimeConfigs.data.gameWorlds.TryGetValue(6, out var value) && RuntimeConfigs.data.gameWorldAudios.TryGetValue(value.AudioData, out var value2))
		{
			UpdateScopeSceneSoundInfo(value2.bgmSound, 0, value2.envSound, value2.reverb, value2.footStepMat, SoundScopes.World);
		}
	}

	protected override void OnSwitchActiveChunk(int worldId, SceneChunk chunk, SceneBlock activeState)
	{
		ResetAudioOverrideProbes(activeState?.SoundOverrideProbes);
		if (RuntimeConfigs.data.gameWorlds.TryGetValue(worldId, out var value) && RuntimeConfigs.data.gameWorldAudios.TryGetValue(value.AudioData, out var value2))
		{
			UpdateScopeSceneSoundInfo(value2.bgmSound, 0, value2.envSound, value2.reverb, value2.footStepMat, SoundScopes.World);
		}
		else
		{
			ClearScopeSceneSoundInfo(SoundScopes.World);
		}
		int key = chunk?.MapId ?? (-1);
		if (RuntimeConfigs.data.mapAreas.TryGetValue(key, out var value3) && RuntimeConfigs.data.mapAreaAudios.TryGetValue(value3.AudioData, out var value4))
		{
			UpdateScopeSceneSoundInfo(value4.bgmSound, 0, value4.envSound, value4.reverb, value4.footStepMat, SoundScopes.MapArea);
		}
		else
		{
			ClearScopeSceneSoundInfo(SoundScopes.MapArea);
		}
		int key2 = chunk?.AreaId ?? (-1);
		if (RuntimeConfigs.data.subMapAreas.TryGetValue(key2, out var value5) && RuntimeConfigs.data.subMapAreaAudios.TryGetValue(value5.AudioData, out var value6))
		{
			UpdateScopeSceneSoundInfo(value6.bgmSound, 0, value6.envSound, value6.reverb, value6.footStepMat, SoundScopes.SubMapArea);
		}
		else
		{
			ClearScopeSceneSoundInfo(SoundScopes.SubMapArea);
		}
		ResetChunkOverrideSoundInfo(chunk, SoundScopes.Chunk);
		ResetChunkOverrideSoundInfo(activeState, SoundScopes.ChunkState);
	}

	private void ResetChunkOverrideSoundInfo(SceneOverrideAudioData data, SoundScopes scope)
	{
		ClearScopeSceneSoundInfo(scope);
		if (data != null && data.EnableOverrideAudio)
		{
			UpdateOverrideData(data.OverrideSceneAudioData, scope);
		}
	}

	private void ClearScopeSceneSoundInfo(SoundScopes scope)
	{
		UpdateScopeSceneSoundInfo(IgnoredStrValue, IgnoredIntValue, IgnoredStrValue, IgnoredStrValue, IgnoredIntValue, scope);
	}

	private void UpdateScopeSceneSoundInfo(string bgmSound, int bgmState, string envSound, string reverb, int footStepMat, SoundScopes scope)
	{
		UpdateSceneSoundInfo(bgmSound, _bgmSoundNames, UpdateType.BGMSound, scope);
		UpdateSceneSoundInfo(bgmState, _bgmStates, UpdateType.BGMState, scope);
		UpdateSceneSoundInfo(envSound, _envSoundNames, UpdateType.EnvSound, scope);
		UpdateSceneSoundInfo(reverb, _reverbNames, UpdateType.Reverb, scope);
		UpdateSceneSoundInfo(footStepMat, _stepMaterialIds, UpdateType.StepMaterial, scope);
	}

	private void UpdateSceneSoundInfo<T>(T value, T[] storeArray, UpdateType type, SoundScopes scope) where T : IEquatable<T>, IComparable<T>
	{
		if (!object.Equals(value, storeArray[(int)scope]))
		{
			storeArray[(int)scope] = value;
			_lastFrameChangedAudioTypes.Add(type);
		}
	}

	protected override void OnUpdate()
	{
		if (CanAudioUpdate())
		{
			LoopCheckAudioProbeChanges();
			BoardcastSceneAudioChange();
		}
	}

	private bool CanAudioUpdate()
	{
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (Singleton<GameState>.instance.RunningState != GameRunningState.Playing || Singleton<NewUIManager>.instance.BlackScreen.enable || topActiveUI == null || (topActiveUI.UIType != UI_TYPE.UI_BATTLEMAIN && topActiveUI.UIType != UI_TYPE.UI_LOUNGEMAIN))
		{
			return false;
		}
		return true;
	}

	private void BoardcastSceneAudioChange()
	{
		if (_lastFrameChangedAudioTypes.Count == 0)
		{
			return;
		}
		SceneAudioUpdateInfo obj = default;
		UpdateType[] array = _lastFrameChangedAudioTypes.ToArray();
		for (int i = 0; i < array.Length; i++)
		{
			switch (array[i])
			{
			case UpdateType.BGMSound:
				obj.UpdateBgmSound(FetchEventFromArrays(_bgmSoundNames, in IgnoredStrValue), ref _lastBgmSoundName);
				break;
			case UpdateType.BGMState:
				obj.UpdateBgmState(FetchEventFromArrays(_bgmStates, in IgnoredIntValue), ref _lastBgmState);
				break;
			case UpdateType.EnvSound:
				obj.UpdateEnvSound(FetchEventFromArrays(_envSoundNames, in IgnoredStrValue), ref _lastEnvSoundName);
				break;
			case UpdateType.Reverb:
				obj.UpdateReverb(FetchEventFromArrays(_reverbNames, in IgnoredStrValue), ref _lastReverbName);
				break;
			case UpdateType.StepMaterial:
				obj.UpdateStepMaterialId(FetchEventFromArrays(_stepMaterialIds, in IgnoredIntValue), ref _lastStepMaterialId);
				break;
			}
		}
		_lastFrameChangedAudioTypes.Clear();
		OnSceneAudioChanged?.Invoke(obj);
	}

	protected T FetchEventFromArrays<T>(T[] array, in T ignoreValue)
	{
		for (int num = array.Length - 1; num >= 0; num--)
		{
			if (!object.Equals(ignoreValue, array[num]))
			{
				return array[num];
			}
		}
		return ignoreValue;
	}

	internal void RemoveAudioProbeData(SceneAudioOverrideProbeData data)
	{
		if (_activeAudioProbesList.Remove(data))
		{
			_sceneAudioProbeIsChanged = true;
		}
	}

	internal void AppendAudioProbeData(SceneAudioOverrideProbeData data)
	{
		if (!_activeAudioProbesList.Contains(data))
		{
			_activeAudioProbesList.Add(data);
			_sceneAudioProbeIsChanged = true;
		}
	}
}
