using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using ACT.World.Asset;
using ACT.World.Modules;
using ACT.World.Modules.SceneAudios;
using ACT.World.Modules.SceneRouters;
using ACT.World.SceneChunks;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.World.SceneChunks;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;

namespace ACT;

public class WorldManager : GameSubManager
{
	internal interface IWorldStateAssetHolder
	{
		Dictionary<int, StateWorldAssetData> StateWorldAssetDataDict { get; }

		int ChunkId { get; }

		bool TryGetStateWorldAssetData(int swid, out StateWorldAssetData findData)
		{
			return StateWorldAssetDataDict.TryGetValue(swid, out findData);
		}
	}

	private SceneChunkModule _chunkModule;

	private SceneAudioModule _audioModule;

	private SceneRouterModule _routerModule;

	private SceneEnvironmentModule _environmentModule;

	private SceneNodeModule _nodeModule;

	private SafeAreaModule _safeAreaModule;

	private SceneParticleGradeModule _particleGradeModule;

	private WorldBase _currentWorld;

	private int _currentAreaId;

	private int _currentMapId;

	private int _subWorldId;

	private int _currentChunkId;

	private Dictionary<SceneStatus, WorldBase> _worlds = new Dictionary<SceneStatus, WorldBase>();

	private List<WorldModuleBase> _subModules;

	private Func<SceneStatus, WorldBase> _spawnWorldBaseAlternativeCallback;

	private object _spawnWorldBaseAlternativeCallbackRefs;

	private bool _chunkTableIsDirty;

	private Dictionary<int, StateWorldAssetData> _activeWorldStateAssetTable = new Dictionary<int, StateWorldAssetData>();

	private Dictionary<int, int> _stateWorldAssetToChunkIdTable = new Dictionary<int, int>();

	private HashSet<IWorldStateAssetHolder> _activeWorldStateAssetHolders = new HashSet<IWorldStateAssetHolder>();

	private const int INVALID_STATE_ID = -32768;

	private const int MAX_MAIN_LINE_WORLD_CONFIG_ID_RANGE = 100;

	private static readonly TableReference ShortCommonTable = "shortcommon";

	private static readonly TableReference CommonTable = "Common";

	private const int SubAreaTipLocalizeId = 2300;

	private int _lastChunkId;

	private int _lastMapId;

	private int _lastAreaId;

	internal SceneChunkModule ChunkModule => _chunkModule;

	internal SceneNodeModule SceneNodeModule => _nodeModule;

	internal SceneRouterModule RouterModule => _routerModule;

	internal SceneEnvironmentModule EnvironmentModule => _environmentModule;

	internal SceneParticleGradeModule ParticleGradeModule => _particleGradeModule;

	public override ContextType ContextType => ContextType.GAME;

	internal IWorld ActiveWorld => _currentWorld;

	internal int LastWorldId { get; private set; }

	internal int ActiveWorldId => _currentWorld?.WorldId ?? 0;

	internal int ActiveWorldConfigId => ActiveChunk?.WorldConfigId ?? 0;

	internal int ActiveMapId => ActiveChunk?.MapId ?? 0;

	internal int ActiveAreaId => ActiveChunk?.AreaId ?? 0;

	internal int ActiveChunkId => ActiveChunk?.ChunkId ?? 0;

	internal SceneStatus ActiveSceneStatus => _currentWorld?.SceneStatus ?? SceneStatus.Main;

	internal WorldChallengeState ActiveWorldChallengeState => _currentWorld?.WorldChallengeState ?? WorldChallengeState.None;

	internal ISceneChunkControl ActiveChunk => _chunkModule.GetActiveChunk();

	public bool HasActiveWorld => _currentWorld != null;

	public IReadOnlyDictionary<int, StateWorldAssetData> ActiveWorldStateAssetTable => _activeWorldStateAssetTable;

	public List<SceneRouterTriggerEntryControl> ActiveRouterEntries => _routerModule.GetActiveSceneRouterEntries();

	private event Action<int, int> m_OnChunkChanged;

	private event Action<int, int> m_OnMapChanged;

	private event Action<int, int> m_OnAreaChanged;

	private event Action<IConfigWorldPartition> m_OnWorldChanged;

	private event Action<IConfigWorldPartition> m_OnWorldRelease;

	public event Action OnLoadEnd;

	public WorldManager()
	{
		_subModules = new List<WorldModuleBase>();
		InitSubModule(ref _chunkModule);
		InitSubModule(ref _routerModule);
		InitSubModule(ref _audioModule);
		InitSubModule(ref _environmentModule);
		InitSubModule(ref _nodeModule);
		InitSubModule(ref _particleGradeModule);
		InitSubModule(ref _safeAreaModule);
	}

	protected override GizmosDrawType GetGizmosDrawType()
	{
		return GizmosDrawType.ChunkBounds;
	}

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
		ChunkModule.ReleaseAllTempChunks();
	}

	private void InitSubModule<T>(ref T module) where T : WorldModuleBase, new()
	{
		if (!_subModules.Contains(module))
		{
			module = new T();
			_subModules.Add(module);
		}
	}

	public bool IsChunkInCurrentWorldPartition(int chunkId)
	{
		SceneChunk chunkData;
		return _chunkModule.FindCurrentWorldChunk(chunkId, out chunkData);
	}

	public bool TryGetActiveWorldChunkInfo(out int worldId, out int worldConfigId, out int chunkId)
	{
		ISceneChunkControl activeChunk = ActiveChunk;
		if (_currentWorld == null || activeChunk == null)
		{
			worldId = 0;
			worldConfigId = 0;
			chunkId = 0;
			return false;
		}
		worldId = _currentWorld.WorldId;
		worldConfigId = activeChunk.WorldConfigId;
		chunkId = activeChunk.ChunkId;
		return true;
	}

	public async UniTask Release()
	{
		await _chunkModule.ReleaseActivePartition();
		_currentWorld = null;
	}

	public async UniTask EnterWorld(SceneStatus sceneStatus, WorldData data = null)
	{
		MonoECS.instance.PushPause();
		SceneLoadProgressHandle progressHandle = Singleton<LoadManager>.instance.ActiveHandle as SceneLoadProgressHandle;
		if (progressHandle == null || _currentWorld == null)
		{
			await LeaveCurrentWorld();
		}
		else
		{
			progressHandle.AddStep(LeaveCurrentWorld, 1.5f);
			await progressHandle.ExecuteAll(markDone: false);
		}
		ContextManager.ResetAll(ContextType.WORLD);
		MonoECS.instance.sceneStatus = sceneStatus;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.BeforeEnterWorld, null);
		WorldBase targetWorld = GetWorldBySceneStatus(sceneStatus);
		if (targetWorld == null)
		{
			Debug.LogError($"未找到场景状态 {sceneStatus} 对应的世界实现");
			progressHandle?.MarkCouldDispose();
			return;
		}
		if (data == null)
		{
			data = new WorldData();
		}
		targetWorld.WorldChallengeState = WorldChallengeState.Normal;
		targetWorld.InitWorldData(data);
		LastWorldId = ((_currentWorld != null) ? _currentWorld.WorldId : (-1));
		_currentWorld = targetWorld;
		if (targetWorld.WorldId == 3 && MapUtility.ConfigWorldMapGraph == null)
		{
			ILoadPartitionResult<ConfigWorldMapGraphData> loadPartitionResult = await WorldPartitionSetting.Data.TryLoadGraphData(3);
			if (loadPartitionResult.Success)
			{
				MapUtility.ConfigWorldMapGraph = loadPartitionResult.Data;
			}
		}
		foreach (WorldModuleBase subModule in _subModules)
		{
			subModule.EnterWorld(targetWorld);
		}
		await targetWorld.EnterWorld(progressHandle);
		if (progressHandle != null && !progressHandle.IsDone)
		{
			progressHandle.MarkCouldDispose();
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.AfterEnterWorld, null);
		MonoECS.instance.PopPause();
	}

	public async UniTask LeaveWorld(Action complete = null)
	{
		MonoECS.instance.PushPause();
		Singleton<NewUIManager>.instance.CloseAllUIImmediately();
		_lastChunkId = (_lastMapId = (_lastAreaId = -1));
		foreach (WorldModuleBase subModule in _subModules)
		{
			subModule.LeaveWorld(_currentWorld);
		}
		await LeaveCurrentWorld();
		MonoECS.instance.PopPause();
		complete?.Invoke();
	}

	public async UniTask EnterWorldWithLoading(SceneStatus sceneStatus, WorldData data = null)
	{
		Singleton<GameState>.instance.SetGameRunningState(GameRunningState.Loading);
		await OpenLoadView();
		await EnterWorld(sceneStatus, data);
		await CloseLoaderView();
		Singleton<GameState>.instance.SetGameRunningState(GameRunningState.Playing);
	}

	public async UniTask ReopenCurrentWorld()
	{
		if (_currentWorld == null)
		{
			throw new Exception("当前没有世界可重开");
		}
		Singleton<GameState>.instance.SetWorldLoadState(WorldLoadState.Reopening);
		await EnterWorldWithLoading(_currentWorld.SceneStatus);
		Singleton<GameState>.instance.RemoveWorldLoadState(WorldLoadState.Reopening);
	}

	public async UniTask LastCheckPointRecovery(float hpPercent = 1f)
	{
		if (_currentWorld == null)
		{
			throw new Exception("当前没有世界");
		}
		_currentWorld.WorldChallengeState = WorldChallengeState.Normal;
		await _currentWorld.LastCheckPointRecovery(hpPercent);
	}

	private async UniTask LeaveCurrentWorld()
	{
		if (_currentWorld != null)
		{
			MonoECS.instance?.RemovePlayerTag(MonoECS.PlayerTag.CameraMoving);
			GameManager.comboCountSystem.ClearComboCount();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.BeforeLeaveWorld, null);
			WorldBase world = _currentWorld;
			await world.LeaveWorld();
			MonoECS.instance?.triggerManager?.ClearWorldTriggers();
			world.UninitWorldData();
			_currentWorld = null;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.AfterLeaveWorld, null);
		}
	}

	public ACT.World.MapArea GetCurrentWorldMapAreaByChunkId(int chunkId)
	{
		return _chunkModule.GetMapAreaByChunkId(chunkId);
	}

	private WorldBase GetWorldBySceneStatus(SceneStatus sceneStatus)
	{
		if (!_worlds.ContainsKey(sceneStatus))
		{
			_worlds.Add(sceneStatus, SpawnWorldBase(sceneStatus));
		}
		return _worlds[sceneStatus];
	}

	internal void SetSpawnWorldBaseAlternativeCallback(Func<SceneStatus, WorldBase> callback, object refs = null)
	{
		if (callback == null)
		{
			if (_spawnWorldBaseAlternativeCallbackRefs == refs)
			{
				_spawnWorldBaseAlternativeCallback = null;
				_spawnWorldBaseAlternativeCallbackRefs = null;
			}
		}
		else if (_spawnWorldBaseAlternativeCallbackRefs == null || _spawnWorldBaseAlternativeCallbackRefs == refs)
		{
			_spawnWorldBaseAlternativeCallbackRefs = refs;
			_spawnWorldBaseAlternativeCallback = callback;
		}
	}

	private WorldBase SpawnWorldBase(SceneStatus sceneStatus)
	{
		WorldBase worldBase = _spawnWorldBaseAlternativeCallback?.Invoke(sceneStatus);
		if (worldBase != null)
		{
			return worldBase;
		}
		switch (sceneStatus)
		{
		case SceneStatus.Main:
			return new MainWorld();
		case SceneStatus.Raid:
			return new RaidWorld();
		case SceneStatus.Temple:
			return new TempleWorld();
		case SceneStatus.Abyss:
			return new AbyssWorld();
		case SceneStatus.Rogue:
			return new RogueWorld();
		case SceneStatus.Trainingground:
			return new TrainingGroundWorld();
		case SceneStatus.Lounge:
			return new LoungeWorld();
		default:
			Debug.LogError($"未支持的场景状态: {sceneStatus}");
			return null;
		}
	}

	internal WorldBase GetCurrentWorld()
	{
		return _currentWorld;
	}

	public Character GetCharacter(int characterId)
	{
		if (_currentWorld == null)
		{
			Debug.LogError("当前没有世界实例");
			return null;
		}
		return _currentWorld.GetCharacter(characterId);
	}

	public void OnCharacterDie(Entity behave)
	{
		_currentWorld?.OnCharacterDie(behave);
	}

	public void ResetTeamCharacters(List<int> characterIds, int battleCharacterIdx = -1)
	{
		if (_currentWorld == null)
		{
			Debug.LogError("当前没有世界实例");
		}
		else
		{
			_currentWorld.ResetTeamCharacters(characterIds, battleCharacterIdx);
		}
	}

	public void ResetTeamPotion(int potionId)
	{
		if (_currentWorld == null)
		{
			Debug.LogError("当前没有世界实例");
		}
		else
		{
			_currentWorld.ResetTeamPotion(potionId);
		}
	}

	public async UniTask RemoveTeamCharacter(Character character)
	{
		if (_currentWorld == null)
		{
			Debug.LogError("当前没有世界实例");
		}
		else
		{
			await _currentWorld.RemoveTeamCharacter(character);
		}
	}

	public async UniTask ReleaseCharacterBattleEntity(SceneStatus sceneStatus, Character character)
	{
		WorldBase worldBySceneStatus = GetWorldBySceneStatus(sceneStatus);
		if (worldBySceneStatus != null)
		{
			await worldBySceneStatus.ReleaseCharacterBattleEntity(character);
		}
	}

	public async UniTask SpawnTeamCharacter(Character character, int index, int battleIndex, bool isLeft = false, Vector3 position = default(Vector3), bool isLoadSave = false)
	{
		if (_currentWorld == null)
		{
			Debug.LogError("当前没有世界实例");
		}
		else
		{
			await _currentWorld.SpawnTeamCharacter(character, index, battleIndex, isLeft, position, isLoadSave);
		}
	}

	protected override void Update()
	{
		_currentWorld?.Update();
		foreach (WorldModuleBase subModule in _subModules)
		{
			subModule.Update();
		}
	}

	protected override void FixedUpdate()
	{
		_currentWorld?.FixedUpdate();
		foreach (WorldModuleBase subModule in _subModules)
		{
			subModule.FixedUpdate();
		}
	}

	protected override void LateUpdate()
	{
		foreach (WorldModuleBase subModule in _subModules)
		{
			subModule.LateUpdate();
		}
	}

	protected override void DrawGizmos()
	{
		foreach (WorldModuleBase subModule in _subModules)
		{
			subModule.DrawGizmos();
		}
	}

	private async UniTask OpenLoadView()
	{
		MonoECS.instance.IsLoadSubScene = true;
		MonoECS.instance.playState = PlayState.UnBattle;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ClearHatred, null);
		Singleton<LoadManager>.instance.StartLoading(new LoaderViewData
		{
			TargetSceneStatus = MonoECS.instance.sceneStatus,
			TargetMapArea = GameUtility.GetMainMapArea()
		});
		Singleton<NewUIManager>.instance.CloseAllUIImmediately();
		await UniTask.CompletedTask;
	}

	private async UniTask CloseLoaderView()
	{
		await UniTask.WaitUntil(() => Singleton<LoadManager>.instance.IsComplete);
		Model<LoadingDoneModel>.Interface.OnLoadingDone();
		if (Model<FacePushModel>.HasInstance())
		{
			Model<FacePushModel>.Interface.OnLoadingDone();
		}
	}

	public float GetCurrentWorldRuntime()
	{
		if (_currentWorld == null)
		{
			return 0f;
		}
		return _currentWorld.GetRuntime();
	}

	private void UpdateActiveWorldStateAssetTable()
	{
		if (!_chunkTableIsDirty)
		{
			return;
		}
		_stateWorldAssetToChunkIdTable?.Clear();
		_activeWorldStateAssetTable?.Clear();
		foreach (IWorldStateAssetHolder activeWorldStateAssetHolder in _activeWorldStateAssetHolders)
		{
			if (activeWorldStateAssetHolder == null)
			{
				continue;
			}
			int chunkId = activeWorldStateAssetHolder.ChunkId;
			Dictionary<int, StateWorldAssetData> stateWorldAssetDataDict = activeWorldStateAssetHolder.StateWorldAssetDataDict;
			if (stateWorldAssetDataDict == null)
			{
				continue;
			}
			foreach (KeyValuePair<int, StateWorldAssetData> item in stateWorldAssetDataDict)
			{
				_activeWorldStateAssetTable[item.Key] = item.Value;
				_stateWorldAssetToChunkIdTable[item.Key] = chunkId;
			}
		}
		_chunkTableIsDirty = false;
	}

	internal bool AppendWorldStateAssetTable(IWorldStateAssetHolder holder)
	{
		if (holder == null)
		{
			return false;
		}
		bool flag = _activeWorldStateAssetHolders.Add(holder);
		_chunkTableIsDirty |= flag;
		return flag;
	}

	internal bool RemoveWorldStateAssetTable(IWorldStateAssetHolder holder)
	{
		if (holder == null)
		{
			return false;
		}
		bool flag = _activeWorldStateAssetHolders.Remove(holder);
		_chunkTableIsDirty |= flag;
		return flag;
	}

	public int GetChunkIdBySGOID(int swid)
	{
		UpdateActiveWorldStateAssetTable();
		if (_stateWorldAssetToChunkIdTable.TryGetValue(swid, out var value))
		{
			return value;
		}
		return 0;
	}

	public StateWorldAssetData GetWorldStateAssetDataBySGOID(int swid)
	{
		UpdateActiveWorldStateAssetTable();
		if (_activeWorldStateAssetTable.TryGetValue(swid, out var value))
		{
			return value;
		}
		return null;
	}

	public int GetStateWorldAssetNumberByTag(ServiceSaveTag tag, int stateId = -32768)
	{
		int num = 0;
		foreach (StateWorldAssetData item in FetchActiveWorldStateAssetDatas())
		{
			if (item.serviceSaveTag.Equals(tag) && ((-32768).Equals(stateId) || item.stateId.Equals(stateId)))
			{
				num++;
			}
		}
		return num;
	}

	public int GetStateWorldAssetNumberByStateObjectType(int stateObjectType, int stateId = -32768)
	{
		int num = 0;
		foreach (StateWorldAssetData item in FetchActiveWorldStateAssetDatas())
		{
			if (item.stateObjectType.Equals(stateObjectType) && ((-32768).Equals(stateId) || item.stateId.Equals(stateId)))
			{
				num++;
			}
		}
		return num;
	}

	public List<StateWorldAssetData> GetStateWorldAssetListByStateObjectType(int stateObjectType, List<StateWorldAssetData> output = null)
	{
		if (output == null)
		{
			output = new List<StateWorldAssetData>();
		}
		output.Clear();
		foreach (StateWorldAssetData item in FetchActiveWorldStateAssetDatas())
		{
			if (item.stateObjectType.Equals(stateObjectType))
			{
				output.Add(item);
			}
		}
		return output;
	}

	public Dictionary<int, T> FetchActiveWorldStateAssetDatas<T>(Dictionary<int, T> output = null) where T : StateWorldAssetData
	{
		if (output == null)
		{
			output = new Dictionary<int, T>();
		}
		output.Clear();
		foreach (IWorldStateAssetHolder activeWorldStateAssetHolder in _activeWorldStateAssetHolders)
		{
			Dictionary<int, StateWorldAssetData> dictionary = activeWorldStateAssetHolder?.StateWorldAssetDataDict;
			if (dictionary == null)
			{
				continue;
			}
			foreach (KeyValuePair<int, StateWorldAssetData> item in dictionary)
			{
				if (item.Value is T value)
				{
					output[item.Key] = value;
				}
			}
		}
		return output;
	}

	public IEnumerable<StateWorldAssetData> FetchActiveWorldStateAssetDatas()
	{
		foreach (IWorldStateAssetHolder activeWorldStateAssetHolder in _activeWorldStateAssetHolders)
		{
			if (activeWorldStateAssetHolder == null)
			{
				continue;
			}
			Dictionary<int, StateWorldAssetData> stateWorldAssetDataDict = activeWorldStateAssetHolder.StateWorldAssetDataDict;
			if (stateWorldAssetDataDict == null)
			{
				continue;
			}
			foreach (KeyValuePair<int, StateWorldAssetData> item in stateWorldAssetDataDict)
			{
				yield return item.Value;
			}
		}
	}

	public void RegisterOnChunkChangedCallback(Action<int, int> callback)
	{
		m_OnChunkChanged -= callback;
		m_OnChunkChanged += callback;
	}

	public void UnregisterOnChunkChangedCallback(Action<int, int> callback)
	{
		m_OnChunkChanged -= callback;
	}

	public void RegisterOnMapChangedCallback(Action<int, int> callback)
	{
		m_OnMapChanged -= callback;
		m_OnMapChanged += callback;
	}

	public void RegisterOnAreaChangedCallback(Action<int, int> callback)
	{
		m_OnAreaChanged -= callback;
		m_OnAreaChanged += callback;
	}

	public void RegisterOnSceneSoundChangeCallback(Action<SceneAudioUpdateInfo> callback)
	{
		_audioModule.OnSceneAudioChanged -= callback;
		_audioModule.OnSceneAudioChanged += callback;
	}

	public void RegisterOnWorldChangedCallback(Action<IConfigWorldPartition> callback)
	{
		m_OnWorldChanged -= callback;
		m_OnWorldChanged += callback;
	}

	public void RegisterOnWorldReleaseCallback(Action<IConfigWorldPartition> callback)
	{
		m_OnWorldRelease -= callback;
		m_OnWorldRelease += callback;
	}

	public void NotifyWorldChanged(IConfigWorldPartition configWorld)
	{
		m_OnWorldChanged?.Invoke(configWorld);
	}

	private void NotifyActiveChunkChange(SceneChunkRuntimeControlBase chunk)
	{
		SceneChunk data = chunk.Data;
		foreach (WorldModuleBase subModule in _subModules)
		{
			if (subModule.NeedGotChunkChange)
			{
				subModule.SwitchActiveChunk(ActiveWorldId, data, chunk.ActiveStateData);
			}
		}
	}

	internal void NotifyChunkChanged(SceneChunkRuntimeControlBase chunk)
	{
		SceneChunk sceneChunk = chunk?.Data;
		if (sceneChunk != null)
		{
			NotifyActiveChunkChange(chunk);
			int worldConfigId = sceneChunk.WorldConfigId;
			int num = sceneChunk?.MapId ?? 0;
			int num2 = sceneChunk?.AreaId ?? 0;
			int num3 = sceneChunk?.ChunkId ?? 0;
			if (UpdateAndNotifyChange(num3, num, num2))
			{
				ProcessRegionNameTipUpdate(worldConfigId, num3, num, num2);
			}
		}
	}

	private void ProcessRegionNameTipUpdate(int wid, int cid, int mId, int aId)
	{
		if (!RuntimeConfigs.data.mapAreas.TryGetValue(mId, out var value) || !RuntimeConfigs.data.subMapAreas.TryGetValue(aId, out var value2))
		{
			if (wid < 100 && LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"【区域提示】找不到地图区域数据：地图[{mId}]区域[{aId}， 请检查配置");
			}
			return;
		}
		LocalizedStringDatabase stringDatabase = LocalizationSettings.StringDatabase;
		Locale projectLocale = LocalizationSettings.ProjectLocale;
		string localizedString = stringDatabase.GetLocalizedString(ShortCommonTable, value.name, projectLocale, FallbackBehavior.DontUseFallback);
		string localizedString2 = stringDatabase.GetLocalizedString(ShortCommonTable, value2.name, projectLocale, FallbackBehavior.DontUseFallback);
		string localizedString3 = stringDatabase.GetLocalizedString(ShortCommonTable, value2.affiliatedName, projectLocale, FallbackBehavior.DontUseFallback);
		string localizedString4 = stringDatabase.GetLocalizedString(CommonTable, 2300L, projectLocale, FallbackBehavior.DontUseFallback, (float)value2.subTip * 0.01f);
		int areaFont = value2.areaFont;
		OnHudForceClose evt = Singleton<EventManager>.instance.GetEvt<OnHudForceClose>();
		evt.position = UIPosition.UpperMiddle;
		evt.type = HudComponentType.RegionNameTip;
		string areaName = ((value2.affiliatedName == 0) ? localizedString2 : $"{localizedString3} {localizedString2}");
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HUDUIForceClose, evt);
		OnHudCpEnqueue evt2 = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
		evt2.position = UIPosition.UpperMiddle;
		evt2.type = HudComponentType.RegionNameTip;
		evt2.priorityInQueue = 3;
		evt2.uiData = new RegionNameTipData(localizedString, areaName, localizedString4, default, areaFont);
		evt2.clearQueueByCpItemType = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
	}

	private bool UpdateAndNotifyChange(int chunkId, int mapId, int areaId)
	{
		int lastChunkId = _lastChunkId;
		bool isInit = _lastChunkId >= 0;
		bool flag = UpdateAndNotifyChange(chunkId, ref _lastChunkId, isInit, in m_OnChunkChanged);
		if (flag)
		{
			LuminApplication.RuntimeInfo.SetChunkId(chunkId);
		}
		Debug.LogWarning("[PF2D][ChunkNotify] lastChunkId=" + lastChunkId + " isInit=" + isInit + " newChunkId=" + chunkId + " notified=" + flag + " worldConfigId=" + ActiveWorldConfigId + " worldId=" + ActiveWorldId);
		bool flag2 = UpdateAndNotifyChange(mapId, ref _lastMapId, _lastMapId >= 0, in m_OnMapChanged);
		bool flag3 = UpdateAndNotifyChange(areaId, ref _lastAreaId, _lastAreaId >= 0, in m_OnAreaChanged);
		return flag2 | flag3;
	}

	private static bool UpdateAndNotifyChange<T>(T value, ref T lastValue, bool isInit, in Action<T, T> notifyEvent) where T : IComparable, IFormattable, IConvertible, IComparable<int>, IEquatable<int>
	{
		if (isInit && lastValue.Equals(value))
		{
			return false;
		}
		notifyEvent?.Invoke(value, lastValue);
		lastValue = value;
		return true;
	}

	public void NotifyWorldReleased(IConfigWorldPartition configWorld)
	{
		m_OnWorldRelease?.Invoke(configWorld);
	}

	public async UniTask CreateWorldBlueprint()
	{
		await _chunkModule.CreateWorldBlueprint();
	}

	public void ReleaseWorldBlueprint()
	{
		_chunkModule.ReleaseWorldBlueprint();
	}

	public async UniTask<IPreparePosResult> PreparePos(int chunkId, Vector3 pos, Func<UniTask> afterPreparePosCallback = null, bool clearLastChunk = true)
	{
		if (_currentWorld == null)
		{
			return null;
		}
		IPreparePosResult result = await _chunkModule.PreparePos(chunkId, pos, clearLastChunk);
		if (afterPreparePosCallback != null)
		{
			await afterPreparePosCallback();
		}
		OnLoadEnd?.Invoke();
		return result;
	}

	public ACT.World.MapArea GetMapAreaByChunkId(int chunkId, SceneStatus sceneType)
	{
		return _chunkModule.GetMapAreaByChunkId(chunkId, sceneType);
	}

	public Dictionary<int, MaterialTrackTransferData> GetTransferRangeByEnemyType(int enemyType)
	{
		return MapUtility.ConfigWorldMapGraph.GetTransferRangeByEnemyType(enemyType);
	}

	public async Task<ILoadPartitionResult<ConfigWorldPartition_v2>> ResetWorld(int partitionConfigId, SceneStatus worldType)
	{
		ILoadPartitionResult<ConfigWorldPartition_v2> loadPartitionResult = await _chunkModule.SetupWorldPartition(partitionConfigId, worldType);
		if (loadPartitionResult.Success)
		{
			ConfigWorldPartition_v2 data = loadPartitionResult.Data;
			_routerModule.SetupWorldPartition(data);
			_safeAreaModule.SetupWorldPartition(data);
		}
		return loadPartitionResult;
	}

	public Vector3 GetActiveWorldSpawnPosition()
	{
		return _chunkModule.GetWorldSpawnPosition();
	}

	internal void ClearLastChunk()
	{
		foreach (WorldModuleBase subModule in _subModules)
		{
			if (subModule.NeedGotChunkChange)
			{
				subModule.ClearLastChunk();
			}
		}
	}
}
