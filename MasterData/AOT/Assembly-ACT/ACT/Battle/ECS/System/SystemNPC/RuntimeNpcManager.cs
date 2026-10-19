using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.NPC;
using ACT.NPC.Conditions;
using ACT.Net;
using ACT.Sound;
using ACT.Utility;
using ACT.World;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using EasyCharacterMovement;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.Battle.ECS.System.SystemNPC;

public class RuntimeNpcManager : Singleton<RuntimeNpcManager>
{
	private bool _forceRefreshCondition;

	private readonly Dictionary<NpcShowEntranceCollection, List<(NpcShowRule rule, UnityAction<bool> handler)>> _entranceRuleConditionHandlers = new Dictionary<NpcShowEntranceCollection, List<(NpcShowRule, UnityAction<bool>)>>();

	private Dictionary<int, NpcShowEntranceCollection> _allNpcDataDic;

	private AssetLoadHandle _switchEffectHandle;

	private int _npcCountRef;

	private bool _dialogueCameraMode;

	private bool _mainRoleMode;

	private CancellationTokenSource _source;

	private Dictionary<int, NpcShowEntranceCollection> _preparedNpc;

	private readonly List<NpcShowEntranceCollection> _preparedNpcPriorityQueue = new List<NpcShowEntranceCollection>();

	private readonly List<Comparison<NpcShowEntranceCollection>> _npcShowPriorityRules = new List<Comparison<NpcShowEntranceCollection>>();

	private readonly Dictionary<int, int> _npcMissionPointPriorityCache = new Dictionary<int, int>();

	private readonly Dictionary<int, bool> _npcTracingMissionPriorityCache = new Dictionary<int, bool>();

	private bool _isNpcShowPriorityQueueDirty;

	private readonly Dictionary<int, NpcExternalShowControlHandle> _externalShowControls = new Dictionary<int, NpcExternalShowControlHandle>();

	private int _nextExternalShowControlOid;

	private const float ForceShowGroundRaycastDistance = 10f;

	private readonly Dictionary<int, NpcShowControlSource> _showControlOverrides = new Dictionary<int, NpcShowControlSource>();

	private readonly HashSet<int> _dialogueVirtualNpcConfigUids = new HashSet<int>();

	private GameObject _mainCharacterModel;

	private AssetLoadHandle _mainCharacterRawModelHandle;

	private AssetLoadHandle _loadedDialogueCharacterHandle;

	private AssetLoadHandle _loadedDialogueCharacterAnimatorHandle;

	private GameObject _loadedDialogueCharacterModel;

	private int _dialogueCharacterLoadVersion;

	private Dictionary<int, List<ReceiveMissionData>> _receiveMissionDatas;

	private Dictionary<int, ReceiveMissionData> _receiveMissionDatasByNpcId;

	private const float MaxNpcLoadWaitSeconds = 15f;

	public AssetStation NpcAssetStation => AssetStationManager.BattleStation;

	public IReadOnlyDictionary<int, NpcShowEntranceCollection> AllNpcDataDic => _allNpcDataDic;

	public InstantiatedNpcDictionaryView InstantiatedNpcDictionary => GameManager.npcSystem.InstantiatedNpcDictionary;

	public Action<int> OnNpcShow { get; set; }

	public Action<int> OnNpcHide { get; set; }

	public Action<int> OnNpcShowConditionChanged { get; set; }

	public Action<int> OnNpcDisplayErrorChanged { get; set; }

	private IReadOnlyList<NpcShowEntranceCollection> NpcEntranceCollectionConfigs => GameLoader.meta?.npcGlobalConfig?.NpcEntranceCollectionConfigs;

	public GameObject CurrentDialogueCharacterModel
	{
		get
		{
			if (_loadedDialogueCharacterModel != null)
			{
				return _loadedDialogueCharacterModel;
			}
			if (_mainRoleMode)
			{
				return _mainCharacterModel;
			}
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity.IsValid)
			{
				return mainEntity.GetModel();
			}
			return _mainCharacterModel;
		}
	}

	public CompNpc CurrentDialogueNpc { get; private set; }

	public int PendingNpcLoadCount => GameManager.npcSystem?.PendingNpcLoadCount ?? 0;

	private void ForceRefreshAllConditions()
	{
		try
		{
			IReadOnlyList<NpcShowEntranceCollection> npcEntranceCollectionConfigs = NpcEntranceCollectionConfigs;
			if (npcEntranceCollectionConfigs == null)
			{
				return;
			}
			foreach (NpcShowEntranceCollection item in npcEntranceCollectionConfigs)
			{
				if (!ShouldListenToNpc(item))
				{
					continue;
				}
				_allNpcDataDic[item.NpcConfigUid] = item;
				if (!TryApplyLatestExternalShowControl(item.NpcConfigUid) && GetNpcShowControlSource(item.NpcConfigUid) == NpcShowControlSource.Condition)
				{
					item.ResetRuntimeState();
					try
					{
						BindEntranceConditionControl(item, refreshCondition: true);
					}
					catch (Exception exception)
					{
						Debug.LogException(exception);
					}
				}
			}
			_forceRefreshCondition = true;
		}
		catch (Exception exception2)
		{
			Debug.LogException(exception2);
		}
	}

	private void OnRefreshEvent(BaseEventContent baseEventContent)
	{
		NotifyNpcShowState();
	}

	private void ResetNpc(BaseEventContent baseEventContent)
	{
		_npcCountRef = 0;
		PopNpcDialogueState();
		_dialogueVirtualNpcConfigUids.Clear();
		_forceRefreshCondition = false;
		if (_allNpcDataDic == null)
		{
			return;
		}
		SystemNpc npcSystem = GameManager.npcSystem;
		NpcShowEntranceCollection[] array = _allNpcDataDic.Values.ToArray();
		NpcShowEntranceCollection[] array2 = array;
		foreach (NpcShowEntranceCollection entrance in array2)
		{
			UnbindEntranceConditionControl(entrance);
		}
		if (npcSystem != null)
		{
			npcSystem.UnloadNpcsImmediately(array);
		}
		else
		{
			array2 = array;
			for (int i = 0; i < array2.Length; i++)
			{
				array2[i].ResetRuntimeState();
			}
		}
		ClearPreparedNpc();
		_allNpcDataDic.Clear();
	}

	private bool ShouldListenToNpc(NpcShowEntranceCollection entrance)
	{
		if (entrance == null)
		{
			return false;
		}
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager == null || !worldManager.HasActiveWorld)
		{
			return false;
		}
		int activeWorldId = worldManager.ActiveWorldId;
		if (MonoECS.instance.sceneStatus == SceneStatus.Main)
		{
			return !entrance.IsGameWorldConfig;
		}
		if (entrance.IsGameWorldConfig)
		{
			return entrance.GameWorldId == activeWorldId;
		}
		return false;
	}

	private void OnChunkChanged(int chunkID, int oldChunkId)
	{
		NotifyNpcShowState();
	}

	private void OnNpcShowPriorityChanged(BaseEventContent baseEventContent)
	{
		MarkPreparedNpcPriorityQueueDirty();
		if (CanApplyNpcShowStates())
		{
			ApplyNpcShowStates();
		}
	}

	private void NotifyNpcShowState()
	{
		if (_preparedNpc != null && CanApplyNpcShowStates())
		{
			if (!_forceRefreshCondition)
			{
				ForceRefreshAllConditions();
			}
			RebuildPreparedNpcPriorityQueue();
			ApplyNpcShowStates();
		}
	}

	private bool CanApplyNpcShowStates()
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager != null && worldManager.HasActiveWorld)
		{
			return worldManager.ActiveChunkId > 0;
		}
		return false;
	}

	private void OnEntranceConditionValueChanged(NpcShowEntranceCollection entrance, bool value)
	{
		if (entrance != null && GetNpcShowControlSource(entrance.NpcConfigUid) == NpcShowControlSource.Condition)
		{
			OnNpcShowConditionChanged?.Invoke(entrance.NpcConfigUid);
			if (value)
			{
				RefreshShowNpc(entrance);
			}
			else
			{
				RefreshShowNpc(entrance, isAdd: false);
			}
		}
	}

	private void BindEntranceConditionControl(NpcShowEntranceCollection entrance, bool refreshCondition)
	{
		if (entrance == null)
		{
			return;
		}
		UnbindEntranceConditionControl(entrance);
		entrance.BindRuntimeContext();
		if (refreshCondition)
		{
			if (entrance.RefreshActiveRuleIndexWithoutCache() >= 0)
			{
				AddPreparedNpc(entrance);
			}
			else
			{
				RemovePreparedNpc(entrance.NpcConfigUid);
			}
			OnNpcShowConditionChanged?.Invoke(entrance.NpcConfigUid);
		}
		SubscribeEntranceRuleConditions(entrance);
	}

	private void UnbindEntranceConditionControl(NpcShowEntranceCollection entrance)
	{
		if (entrance != null)
		{
			UnsubscribeEntranceRuleConditions(entrance);
			entrance.FreeRuntimeContext();
		}
	}

	private void SubscribeEntranceRuleConditions(NpcShowEntranceCollection entrance)
	{
		UnsubscribeEntranceRuleConditions(entrance);
		List<NpcShowRule> showRules = entrance.ShowRules;
		if (showRules == null || showRules.Count == 0)
		{
			return;
		}
		List<(NpcShowRule, UnityAction<bool>)> list = new List<(NpcShowRule, UnityAction<bool>)>(showRules.Count);
		for (int i = 0; i < showRules.Count; i++)
		{
			NpcShowRule npcShowRule = showRules[i];
			if (npcShowRule != null)
			{
				NpcShowEntranceCollection capturedEntrance = entrance;
				UnityAction<bool> unityAction = (bool _) =>
				{
					OnEntranceConditionValueChanged(capturedEntrance, capturedEntrance.RefreshActiveRuleIndexFromCache() >= 0);
				};
				npcShowRule.Conditions.OnValueChanged += unityAction;
				list.Add((npcShowRule, unityAction));
			}
		}
		_entranceRuleConditionHandlers[entrance] = list;
	}

	private void UnsubscribeEntranceRuleConditions(NpcShowEntranceCollection entrance)
	{
		if (!_entranceRuleConditionHandlers.TryGetValue(entrance, out List<(NpcShowRule, UnityAction<bool>)> value))
		{
			return;
		}
		_entranceRuleConditionHandlers.Remove(entrance);
		for (int i = 0; i < value.Count; i++)
		{
			NpcShowRule item = value[i].Item1;
			if (item?.Conditions != null)
			{
				item.Conditions.OnValueChanged -= value[i].Item2;
			}
		}
	}

	public bool IsNpcCanDisplay(int npcConfigUid)
	{
		switch (GetNpcShowControlSource(npcConfigUid))
		{
		case NpcShowControlSource.ForceShow:
			return true;
		case NpcShowControlSource.ForceHide:
			return false;
		default:
		{
			NpcShowEntranceCollection value;
			if (_preparedNpc != null)
			{
				return _preparedNpc.TryGetValue(npcConfigUid, out value);
			}
			return false;
		}
		}
	}

	public NpcShowControlSource GetNpcShowControlSource(int npcConfigUid)
	{
		if (!_showControlOverrides.TryGetValue(npcConfigUid, out var value))
		{
			return NpcShowControlSource.Condition;
		}
		return value;
	}

	public bool TryGetNpcDisplayError(int npcConfigUid, out string message)
	{
		message = null;
		if (GameManager.npcSystem != null)
		{
			return GameManager.npcSystem.TryGetNpcLoadError(npcConfigUid, out message);
		}
		return false;
	}

	public bool TryGetNpcInChunk(int worldId, int chunkId, out List<int> npcUids)
	{
		npcUids = new List<int>();
		if (_allNpcDataDic == null)
		{
			return false;
		}
		try
		{
			foreach (KeyValuePair<int, NpcShowEntranceCollection> item in _allNpcDataDic)
			{
				NpcShowEntranceCollection value = item.Value;
				if (IsNpcBelongToChunk(value, worldId, chunkId))
				{
					npcUids.Add(value.NpcConfigUid);
				}
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		return npcUids.Count > 0;
	}

	private bool TryGetNpcEntrance(int npcConfigUid, out NpcShowEntranceCollection entrance)
	{
		entrance = null;
		if (_allNpcDataDic != null && _allNpcDataDic.TryGetValue(npcConfigUid, out entrance))
		{
			return entrance != null;
		}
		return false;
	}

	public Vector3 GetNpcPosition(int npcConfigUid)
	{
		if (InstantiatedNpcDictionary.TryGetValue(npcConfigUid, out var value) && value.IsValid)
		{
			GameObject model = value.GetModel();
			if ((object)model != null)
			{
				return model.transform.position;
			}
		}
		if (_allNpcDataDic != null && _allNpcDataDic.TryGetValue(npcConfigUid, out var value2))
		{
			return value2?.RuntimeWorldPosition ?? Vector3.zero;
		}
		return Vector3.zero;
	}

	public List<NpcShowEntranceCollection> GetNpcCollectionByMapArea_Mission(ACT.World.MapArea mapArea)
	{
		List<NpcShowEntranceCollection> list = new List<NpcShowEntranceCollection>();
		foreach (KeyValuePair<int, NpcShowEntranceCollection> item in _allNpcDataDic)
		{
			if (!item.Value.IsGameWorldConfig)
			{
				int npcMapAreaID = TableRule.GetNpcMapAreaID(item.Value.NpcConfigUid);
				if (NpcDataConfig.AreaIDMap.TryGetValue(npcMapAreaID, out var value) && value == (int)mapArea)
				{
					list.Add(item.Value);
				}
			}
		}
		return list;
	}

	public List<NpcShowEntranceCollection> GetNpcCollectionByMapArea(ACT.World.MapArea mapArea)
	{
		List<NpcShowEntranceCollection> list = new List<NpcShowEntranceCollection>();
		if (_preparedNpc == null || _allNpcDataDic == null)
		{
			return list;
		}
		HashSet<int> hashSet = HashSetPool<int>.Get();
		try
		{
			ResolveVisibleNpc(hashSet, considerShowArea: false);
			for (int i = 0; i < _preparedNpcPriorityQueue.Count; i++)
			{
				NpcShowEntranceCollection npcShowEntranceCollection = _preparedNpcPriorityQueue[i];
				if (npcShowEntranceCollection != null && !npcShowEntranceCollection.IsGameWorldConfig && hashSet.Contains(npcShowEntranceCollection.NpcConfigUid) && IsNpcShowInMapArea(npcShowEntranceCollection, mapArea))
				{
					list.Add(npcShowEntranceCollection);
				}
			}
			foreach (KeyValuePair<int, NpcShowEntranceCollection> item in _allNpcDataDic)
			{
				NpcShowEntranceCollection value = item.Value;
				if (value != null && !value.IsGameWorldConfig && GetNpcShowControlSource(value.NpcConfigUid) == NpcShowControlSource.ForceShow && IsNpcShowInMapArea(value, mapArea))
				{
					list.Add(value);
				}
			}
			return list;
		}
		finally
		{
			HashSetPool<int>.Release(hashSet);
		}
	}

	private bool IsNpcShowInMapArea(NpcShowEntranceCollection entrance, ACT.World.MapArea mapArea)
	{
		int npcMapAreaID = TableRule.GetNpcMapAreaID(entrance.NpcConfigUid);
		if (!NpcDataConfig.AreaIDMap.TryGetValue(npcMapAreaID, out var value) || value != (int)mapArea)
		{
			return false;
		}
		return CoreUtils.GetData(entrance.NpcConfigUid, RuntimeConfigs.data.npcConfigs)?.type ?? false;
	}

	private int GetNpcWorldId(int npcConfigUid)
	{
		if (TryGetNpcEntranceConfig(npcConfigUid, out var entrance) && entrance.IsGameWorldConfig)
		{
			return entrance.GameWorldId;
		}
		if (!NpcDataConfig.AreaIDMap.TryGetValue(TableRule.GetNpcMapAreaID(npcConfigUid), out var value))
		{
			return 0;
		}
		return CoreUtils.GetData(value, RuntimeConfigs.data.mapAreas)?.worldId ?? 0;
	}

	private bool TryGetNpcEntranceConfig(int npcConfigUid, out NpcShowEntranceCollection entrance)
	{
		entrance = null;
		IReadOnlyList<NpcShowEntranceCollection> npcEntranceCollectionConfigs = NpcEntranceCollectionConfigs;
		if (npcEntranceCollectionConfigs == null)
		{
			return false;
		}
		foreach (NpcShowEntranceCollection item in npcEntranceCollectionConfigs)
		{
			if (item != null && item.NpcConfigUid == npcConfigUid)
			{
				entrance = item;
				return true;
			}
		}
		return false;
	}

	private bool IsActiveChunk(int worldId, int chunkId)
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldId == worldManager.ActiveWorldId)
		{
			return chunkId == worldManager.ActiveChunkId;
		}
		return false;
	}

	private bool IsNpcBelongToChunk(NpcShowEntranceCollection entrance, int worldId, int chunkId)
	{
		if (entrance != null && entrance.ChunkID == chunkId)
		{
			return GetNpcWorldId(entrance.NpcConfigUid) == worldId;
		}
		return false;
	}

	public override void Init()
	{
		base.Init();
		try
		{
			InitializeNpcShowPriorityRules();
			LoadMainCharacterModel((Sex)G.detailUserInfo.Brief.Gender);
			_preparedNpc = DictionaryPool<int, NpcShowEntranceCollection>.Get();
			ClearPreparedNpc();
			_allNpcDataDic = DictionaryPool<int, NpcShowEntranceCollection>.Get();
			RebuildReceiveMissionDatasByArea();
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, OnRefreshEvent);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterLeaveWorld, OnRefreshEvent);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeEnterWorld, ResetNpc);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_TP, OnRefreshEvent);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnSexChange, OnSexChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.TracingPointAdded, OnNpcShowPriorityChanged);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.TracingPointRemoved, OnNpcShowPriorityChanged);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Tracing, OnNpcShowPriorityChanged);
			Singleton<GameManager>.instance.worldManager.RegisterOnChunkChangedCallback(OnChunkChanged);
		}
		catch (Exception arg)
		{
			Debug.LogError($"NpcManager初始化失败:{arg}");
		}
	}

	public void ReloadNpcConfigs(NpcGlobalConfig sourceConfig)
	{
		NpcGlobalConfig npcGlobalConfig = GameLoader.meta?.npcGlobalConfig;
		if (sourceConfig != null && npcGlobalConfig != null && _preparedNpc != null && _allNpcDataDic != null)
		{
			NpcShowEntranceCollection[] array = _allNpcDataDic.Values.ToArray();
			if (_npcCountRef > 0)
			{
				_npcCountRef = 1;
				PopNpcDialogueState();
			}
			GameManager.npcSystem?.UnloadNpcsImmediately(array);
			NpcShowEntranceCollection[] array2 = array;
			foreach (NpcShowEntranceCollection npcShowEntranceCollection in array2)
			{
				UnbindEntranceConditionControl(npcShowEntranceCollection);
				npcShowEntranceCollection.ResetRuntimeState();
			}
			ClearPreparedNpc();
			_allNpcDataDic.Clear();
			_showControlOverrides.Clear();
			_dialogueVirtualNpcConfigUids.Clear();
			_forceRefreshCondition = false;
			npcGlobalConfig.OverwriteRuntimeNpcDataFrom(sourceConfig);
			RebuildReceiveMissionDatasByArea();
			ForceRefreshAllConditions();
			NotifyNpcShowState();
		}
	}

	public override void UnInit()
	{
		base.UnInit();
		try
		{
			_forceRefreshCondition = false;
			_npcCountRef = 0;
			_dialogueCameraMode = false;
			_mainRoleMode = false;
			CurrentDialogueNpc = null;
			_dialogueVirtualNpcConfigUids.Clear();
			ClearExternalShowControls();
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnSexChange, OnSexChange);
			InvalidateAndReleaseLoadedDialogueCharacterModel();
			ReleaseMainCharacterModel();
			ReleaseReceiveMissionDatas();
			IReadOnlyList<NpcShowEntranceCollection> npcEntranceCollectionConfigs = NpcEntranceCollectionConfigs;
			if (npcEntranceCollectionConfigs == null)
			{
				return;
			}
			foreach (NpcShowEntranceCollection item in npcEntranceCollectionConfigs)
			{
				UnbindEntranceConditionControl(item);
			}
			if (_preparedNpc != null)
			{
				SystemNpc npcSystem = GameManager.npcSystem;
				foreach (KeyValuePair<int, NpcShowEntranceCollection> item2 in _preparedNpc)
				{
					npcSystem.HideNpc(item2.Value);
				}
				DictionaryPool<int, NpcShowEntranceCollection>.Release(_preparedNpc);
				_preparedNpc = null;
			}
			_preparedNpcPriorityQueue.Clear();
			_npcMissionPointPriorityCache.Clear();
			_isNpcShowPriorityQueueDirty = false;
			if (_showControlOverrides.Count > 0)
			{
				SystemNpc npcSystem2 = GameManager.npcSystem;
				foreach (NpcShowEntranceCollection item3 in npcEntranceCollectionConfigs)
				{
					if (item3 != null && _showControlOverrides.ContainsKey(item3.NpcConfigUid))
					{
						npcSystem2.HideNpc(item3);
					}
				}
			}
			_showControlOverrides.Clear();
			foreach (NpcShowEntranceCollection item4 in npcEntranceCollectionConfigs)
			{
				item4.ResetRuntimeState();
			}
			if (_allNpcDataDic != null)
			{
				DictionaryPool<int, NpcShowEntranceCollection>.Release(_allNpcDataDic);
				_allNpcDataDic = null;
			}
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, OnRefreshEvent);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterLeaveWorld, OnRefreshEvent);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeEnterWorld, ResetNpc);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_TP, OnRefreshEvent);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingPointAdded, OnNpcShowPriorityChanged);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingPointRemoved, OnNpcShowPriorityChanged);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Tracing, OnNpcShowPriorityChanged);
			_npcShowPriorityRules.Clear();
		}
		catch (Exception arg)
		{
			Debug.LogError($"NpcManager反初始化失败:{arg}");
		}
	}

	public async void PushNpcDialogueState(CompNpc compNpc = null, bool useCamera = false, int characterId = 0)
	{
		if (CurrentDialogueNpc != null && CurrentDialogueNpc != compNpc)
		{
			Debug.LogWarning("当前已有在对话状态中的npc，无法加入新的对话状态Npc");
			return;
		}
		CurrentDialogueNpc = compNpc;
		_npcCountRef++;
		if (_npcCountRef > 1 && _dialogueCameraMode)
		{
			return;
		}
		Singleton<GameState>.instance.SetInInteractState(isInInteractState: true);
		if (!(MonoECS.instance.mainEntity == null) && await WaitMainEntityGrounded() && IsCurrentDialoguePushActive(compNpc))
		{
			_dialogueCameraMode = useCamera;
			if (useCamera)
			{
				await ApplyDialogueCharacterModel(compNpc, characterId);
			}
		}
	}

	public void PopNpcDialogueState()
	{
		_npcCountRef--;
		if (_npcCountRef > 0)
		{
			return;
		}
		_npcCountRef = 0;
		Singleton<GameState>.instance.SetInInteractState(isInInteractState: false);
		if (_source != null)
		{
			_source.Cancel();
			_source.Dispose();
			_source = null;
		}
		if (_dialogueCameraMode)
		{
			CurrentDialogueNpc?.ExitDialogueMode(controlCamera: false);
		}
		if (_mainRoleMode)
		{
			ShowMainBattleEntity();
			DeactivateMainCharacterModel();
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity.IsValid)
			{
				Transform modelTrans = mainEntity.GetModelTrans();
				if ((object)modelTrans != null)
				{
					PlayNpcSwitchEffect(modelTrans.position);
				}
			}
			_mainRoleMode = false;
		}
		InvalidateAndReleaseLoadedDialogueCharacterModel();
		RestoreDialogueVirtualNpcs();
		_dialogueCameraMode = false;
		CurrentDialogueNpc = null;
	}

	private void PlayNpcSwitchEffect(Vector3 position)
	{
		if (!_switchEffectHandle.IsValid)
		{
			_switchEffectHandle = NpcAssetStation.InstantiateAsync(GameLoader.meta.switchRoleEffect, MonoECS.instance.GetRoot(SceneRootType.Effect).transform);
		}
		_switchEffectHandle.Completed += (AssetLoadHandle l) =>
		{
			GameObject gameObject = l.As<GameObject>();
			gameObject.transform.position = position;
			List<ParticleSystem> list = ListPool<ParticleSystem>.Get();
			gameObject.GetComponentsInChildren(list);
			foreach (ParticleSystem item in list)
			{
				item.Play(withChildren: true);
			}
			ListPool<ParticleSystem>.Release(list);
			ObjectSound component = gameObject.GetComponent<ObjectSound>();
			if (!(component == null))
			{
				component.enabled = false;
				component.enabled = true;
			}
		};
	}

	private async UniTask<bool> WaitMainEntityGrounded()
	{
		if (_source != null)
		{
			_source.Cancel();
			_source.Dispose();
		}
		_source = new CancellationTokenSource();
		Entity mainEntity = MonoECS.instance.mainEntity;
		CompPhysics compPhysics = mainEntity.GetCompPhysics();
		CompTransform compTransform = mainEntity.GetCompTransform();
		CharacterMovement ecm2 = compPhysics.characterMovement;
		Vector3 capsuleCenter = ecm2.height * 0.5f * Vector3.up;
		try
		{
			await UniTask.WaitUntil(() =>
			{
				compPhysics.ExternalComputeGroundDistance(ecm2.position, ecm2.height, capsuleCenter, ecm2.radius, compTransform.rotation, 20f, 20f, out var outGroundResult, BattleConsts.enviromentMask);
				return outGroundResult.groundDistance < 0.05f;
			}, PlayerLoopTiming.Update, _source.Token);
			return true;
		}
		catch (Exception)
		{
			return false;
		}
	}

	private void HideMainBattleEntity()
	{
		MPPlayer.local?.SetCharacterVisible(MonoECS.instance.mainEntity, visible: false);
	}

	private void ShowMainBattleEntity()
	{
		MPPlayer.local?.SetCharacterVisible(MonoECS.instance.mainEntity, visible: true);
	}

	private bool IsCurrentDialoguePushActive(CompNpc expectedNpc)
	{
		if (_npcCountRef > 0)
		{
			return CurrentDialogueNpc == expectedNpc;
		}
		return false;
	}

	private CancellationToken GetDialogueCancellationToken()
	{
		if (_source == null)
		{
			return CancellationToken.None;
		}
		return _source.Token;
	}

	private int GetCurrentBattleCharacterId()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!mainEntity.IsValid || !mainEntity.TryGetCompCharacter(out CompCharacter component))
		{
			return 0;
		}
		return component.characterSource?.Id() ?? 0;
	}

	private async UniTask ApplyDialogueCharacterModel(CompNpc compNpc, int characterId)
	{
		int currentBattleCharacterId = GetCurrentBattleCharacterId();
		if ((characterId > 0) ? (characterId == currentBattleCharacterId) : Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			compNpc?.EnterDialogueMode(controlCamera: false, rotateDialogueCharacter: false);
			return;
		}
		CancellationToken dialogueCancellationToken = GetDialogueCancellationToken();
		GameObject gameObject = ((characterId <= 0) ? (await AwaitMainCharacterModelAsync(dialogueCancellationToken)) : (await LoadDialogueCharacterModelAsync(characterId, dialogueCancellationToken)));
		if (!IsCurrentDialoguePushActive(compNpc))
		{
			return;
		}
		if (gameObject == null)
		{
			Debug.LogWarning((characterId > 0) ? $"对话角色模型加载失败: characterId={characterId}，沿用出战角色模型" : "对话主角模型加载失败，沿用出战角色模型");
			compNpc?.EnterDialogueMode(controlCamera: false, rotateDialogueCharacter: false);
			return;
		}
		_mainRoleMode = true;
		HideMainBattleEntity();
		if (characterId > 0)
		{
			ActivateLoadedDialogueCharacterModel();
		}
		else
		{
			ActivateMainCharacterModel();
		}
		PlayNpcSwitchEffect(gameObject.transform.position);
		compNpc?.EnterDialogueMode(controlCamera: false);
	}

	private void AddPreparedNpc(NpcShowEntranceCollection entrance)
	{
		if (entrance != null && _preparedNpc != null)
		{
			RemovePreparedNpcFromQueue(entrance.NpcConfigUid);
			_preparedNpc[entrance.NpcConfigUid] = entrance;
			_preparedNpcPriorityQueue.Insert(FindPreparedNpcInsertIndex(entrance), entrance);
		}
	}

	private void RemovePreparedNpc(int npcConfigUid)
	{
		if (_preparedNpc != null)
		{
			_preparedNpc.Remove(npcConfigUid);
			RemovePreparedNpcFromQueue(npcConfigUid);
		}
	}

	private void ClearPreparedNpc()
	{
		_preparedNpc?.Clear();
		_preparedNpcPriorityQueue.Clear();
		_npcMissionPointPriorityCache.Clear();
		_npcTracingMissionPriorityCache.Clear();
		_isNpcShowPriorityQueueDirty = false;
	}

	private void RebuildPreparedNpcPriorityQueue()
	{
		_preparedNpcPriorityQueue.Clear();
		_isNpcShowPriorityQueueDirty = false;
		if (_preparedNpc == null)
		{
			return;
		}
		foreach (KeyValuePair<int, NpcShowEntranceCollection> item in _preparedNpc)
		{
			if (item.Value != null)
			{
				_preparedNpcPriorityQueue.Add(item.Value);
			}
		}
		RefreshMissionPointPriorityCache();
		RefreshTracingMissionPriorityCache();
		_preparedNpcPriorityQueue.Sort(CompareNpcShowPriority);
	}

	private void MarkPreparedNpcPriorityQueueDirty()
	{
		_isNpcShowPriorityQueueDirty = true;
	}

	private void EnsurePreparedNpcPriorityQueueSorted()
	{
		if (_isNpcShowPriorityQueueDirty)
		{
			RebuildPreparedNpcPriorityQueue();
		}
	}

	private int FindPreparedNpcInsertIndex(NpcShowEntranceCollection entrance)
	{
		int num = 0;
		int num2 = _preparedNpcPriorityQueue.Count;
		while (num < num2)
		{
			int num3 = (num + num2) / 2;
			if (CompareNpcShowPriority(_preparedNpcPriorityQueue[num3], entrance) <= 0)
			{
				num = num3 + 1;
			}
			else
			{
				num2 = num3;
			}
		}
		return num;
	}

	private void RemovePreparedNpcFromQueue(int npcConfigUid)
	{
		for (int num = _preparedNpcPriorityQueue.Count - 1; num >= 0; num--)
		{
			NpcShowEntranceCollection npcShowEntranceCollection = _preparedNpcPriorityQueue[num];
			if (npcShowEntranceCollection != null && npcShowEntranceCollection.NpcConfigUid == npcConfigUid)
			{
				_preparedNpcPriorityQueue.RemoveAt(num);
			}
		}
	}

	private void InitializeNpcShowPriorityRules()
	{
		_npcShowPriorityRules.Clear();
		_npcShowPriorityRules.Add(CompareByMissionPointPriority);
		_npcShowPriorityRules.Add(CompareByTracingMission);
		_npcShowPriorityRules.Add(CompareByNpcType);
		_npcShowPriorityRules.Add(CompareNpcUid);
	}

	private int CompareNpcShowPriority(NpcShowEntranceCollection x, NpcShowEntranceCollection y)
	{
		if (x == y)
		{
			return 0;
		}
		if (x == null)
		{
			return 1;
		}
		if (y == null)
		{
			return -1;
		}
		for (int i = 0; i < _npcShowPriorityRules.Count; i++)
		{
			int num = _npcShowPriorityRules[i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	private int CompareNpcUid(NpcShowEntranceCollection x, NpcShowEntranceCollection y)
	{
		return x.NpcConfigUid.CompareTo(y.NpcConfigUid);
	}

	private static int CompareByNpcType(NpcShowEntranceCollection x, NpcShowEntranceCollection y)
	{
		return y.NpcType - x.NpcType;
	}

	private int CompareByMissionPointPriority(NpcShowEntranceCollection x, NpcShowEntranceCollection y)
	{
		return GetMissionPointPriority(y.NpcConfigUid) - GetMissionPointPriority(x.NpcConfigUid);
	}

	private int CompareByTracingMission(NpcShowEntranceCollection x, NpcShowEntranceCollection y)
	{
		int num = (IsEntranceMatchTracingMission(x.NpcConfigUid) ? 1 : 0);
		return (IsEntranceMatchTracingMission(y.NpcConfigUid) ? 1 : 0) - num;
	}

	private bool IsEntranceMatchTracingMission(int npcConfigUid)
	{
		if (_npcTracingMissionPriorityCache.TryGetValue(npcConfigUid, out var value))
		{
			return value;
		}
		value = CalcTracingMissionMatch(npcConfigUid);
		_npcTracingMissionPriorityCache[npcConfigUid] = value;
		return value;
	}

	private bool CalcTracingMissionMatch(int npcConfigUid)
	{
		int tracingMissionId = GetTracingMissionId();
		if (tracingMissionId == 0)
		{
			return false;
		}
		if (_preparedNpc == null || !_preparedNpc.TryGetValue(npcConfigUid, out var value) || value == null)
		{
			return false;
		}
		return EntranceContainsMission(value, tracingMissionId);
	}

	private void RefreshTracingMissionPriorityCache()
	{
		_npcTracingMissionPriorityCache.Clear();
		if (_preparedNpc == null)
		{
			return;
		}
		int tracingMissionId = GetTracingMissionId();
		if (tracingMissionId == 0)
		{
			return;
		}
		foreach (KeyValuePair<int, NpcShowEntranceCollection> item in _preparedNpc)
		{
			NpcShowEntranceCollection value = item.Value;
			_npcTracingMissionPriorityCache[item.Key] = value != null && EntranceContainsMission(value, tracingMissionId);
		}
	}

	private static bool EntranceContainsMission(NpcShowEntranceCollection entrance, int missionId)
	{
		List<NpcShowRule> showRules = entrance.ShowRules;
		if (showRules == null)
		{
			return false;
		}
		for (int i = 0; i < showRules.Count; i++)
		{
			List<NpcConditionGroup> list = showRules[i]?.Conditions?.groups;
			if (list == null)
			{
				continue;
			}
			for (int j = 0; j < list.Count; j++)
			{
				NpcConditionGroup npcConditionGroup = list[j];
				if (npcConditionGroup == null)
				{
					continue;
				}
				for (int k = 0; k < npcConditionGroup.ConditionCount; k++)
				{
					if (TryGetConditionMissionId(npcConditionGroup.GetCondition(k), out var missionId2) && missionId2 == missionId)
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	private static bool TryGetConditionMissionId(NpcConditionUnit condition, out int missionId)
	{
		if (!(condition is MissionDurationCondition missionDurationCondition))
		{
			if (!(condition is MissionReceiveCondition missionReceiveCondition))
			{
				if (!(condition is MissionCompleteCondition missionCompleteCondition))
				{
					if (condition is MissionConditionActiveCondition missionConditionActiveCondition)
					{
						missionId = missionConditionActiveCondition.missionID;
						return true;
					}
					missionId = 0;
					return false;
				}
				missionId = missionCompleteCondition.missionID;
				return true;
			}
			missionId = missionReceiveCondition.missionID;
			return true;
		}
		missionId = missionDurationCondition.missionID;
		return true;
	}

	private static int GetTracingMissionId()
	{
		if (!Singleton<MissionManager>.HasInstance())
		{
			return 0;
		}
		return Singleton<MissionManager>.instance.GetTracingMission();
	}

	private int GetMissionPointPriority(int npcConfigUid)
	{
		if (_npcMissionPointPriorityCache.TryGetValue(npcConfigUid, out var value))
		{
			return value;
		}
		value = CalcMissionPointPriority(npcConfigUid);
		_npcMissionPointPriorityCache[npcConfigUid] = value;
		return value;
	}

	private void RefreshMissionPointPriorityCache()
	{
		_npcMissionPointPriorityCache.Clear();
		IReadOnlyList<MissionPointData> readOnlyList = Model<BattleMainMarkModelV2>.Interface?.Points;
		if (readOnlyList == null)
		{
			return;
		}
		for (int i = 0; i < readOnlyList.Count; i++)
		{
			if (readOnlyList[i] is NPCMissionPoint nPCMissionPoint && TryGetMissionPointPriority(nPCMissionPoint, out var priority) && (!_npcMissionPointPriorityCache.TryGetValue(nPCMissionPoint.NpcUid, out var value) || priority > value))
			{
				_npcMissionPointPriorityCache[nPCMissionPoint.NpcUid] = priority;
			}
		}
	}

	private int CalcMissionPointPriority(int npcConfigUid)
	{
		IReadOnlyList<MissionPointData> readOnlyList = Model<BattleMainMarkModelV2>.Interface?.Points;
		if (readOnlyList == null)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < readOnlyList.Count; i++)
		{
			if (readOnlyList[i] is NPCMissionPoint nPCMissionPoint && nPCMissionPoint.NpcUid == npcConfigUid && TryGetMissionPointPriority(nPCMissionPoint, out var priority) && priority > num)
			{
				num = priority;
			}
		}
		return num;
	}

	private static bool TryGetMissionPointPriority(NPCMissionPoint npcMissionPoint, out int priority)
	{
		priority = 0;
		MissionManager missionManager = Singleton<MissionManager>.instance;
		if (missionManager == null)
		{
			return false;
		}
		MissionConfig missionConfig = missionManager.GetMissionConfig(npcMissionPoint.MissionId);
		if (!missionConfig.IsValid)
		{
			return false;
		}
		priority = GetMissionTypePriority(missionConfig.MissionTypeEnum);
		return true;
	}

	private static int GetMissionTypePriority(MissionType missionType)
	{
		switch (missionType)
		{
		case MissionType.Main:
		case MissionType.MainActivity:
			return 3;
		case MissionType.Side:
		case MissionType.SideActivity:
		case MissionType.Legend:
			return 2;
		case MissionType.Daily:
		case MissionType.DailyActivity:
			return 1;
		default:
			return 0;
		}
	}

	public NpcExternalShowControlHandle SetNpcExternalShow(int npcConfigUid, bool visible)
	{
		return SetNpcExternalShow(npcConfigUid, visible, hasWorldPosition: false, default, hasWorldRotation: false, default);
	}

	public NpcExternalShowControlHandle SetNpcExternalShow(int npcConfigUid, bool visible, Vector3 worldPosition)
	{
		return SetNpcExternalShow(npcConfigUid, visible, hasWorldPosition: true, worldPosition, hasWorldRotation: false, default);
	}

	public NpcExternalShowControlHandle SetNpcExternalShow(int npcConfigUid, bool visible, Vector3 worldPosition, Vector3 worldRotation)
	{
		return SetNpcExternalShow(npcConfigUid, visible, hasWorldPosition: true, worldPosition, hasWorldRotation: true, worldRotation);
	}

	public bool TryGetNpcExternalShowControl(int oid, out NpcExternalShowControlHandle handle)
	{
		foreach (KeyValuePair<int, NpcExternalShowControlHandle> externalShowControl in _externalShowControls)
		{
			if (externalShowControl.Value.Oid == oid && externalShowControl.Value.IsValid)
			{
				handle = externalShowControl.Value;
				return true;
			}
		}
		handle = default;
		return false;
	}

	public bool ReleaseNpcExternalShowControl(NpcExternalShowControlHandle handle)
	{
		if (handle.Oid <= 0 || !_externalShowControls.TryGetValue(handle.NpcConfigUid, out var value) || value.Oid != handle.Oid || !_externalShowControls.Remove(handle.NpcConfigUid))
		{
			return false;
		}
		UseNpcConditionControl(handle.NpcConfigUid);
		return true;
	}

	private NpcExternalShowControlHandle SetNpcExternalShow(int npcConfigUid, bool visible, bool hasWorldPosition, Vector3 worldPosition, bool hasWorldRotation, Vector3 worldRotation)
	{
		if (_externalShowControls.TryGetValue(npcConfigUid, out var value) && value.Oid > 0)
		{
			Debug.LogError($"NPC[{npcConfigUid}] 已被外部控制占用，oid={value.Oid}，新的外部显隐请求已回退。请先 Release 再接管。");
			return default;
		}
		NpcExternalShowControlHandle handle = new NpcExternalShowControlHandle(++_nextExternalShowControlOid, npcConfigUid, visible, hasWorldPosition, worldPosition, hasWorldRotation, worldRotation);
		_externalShowControls[npcConfigUid] = handle;
		ApplyExternalShowControl(ref handle);
		return handle;
	}

	private bool TryApplyLatestExternalShowControl(int npcConfigUid)
	{
		if (!_externalShowControls.TryGetValue(npcConfigUid, out var value) || !value.IsValid)
		{
			return false;
		}
		ApplyExternalShowControl(ref value);
		return value.Applied;
	}

	private void ApplyExternalShowControl(ref NpcExternalShowControlHandle handle)
	{
		if (handle.Oid <= 0 || !handle.IsValid)
		{
			return;
		}
		if (!TryResolveEntranceForExternalControl(handle.NpcConfigUid, out var entrance))
		{
			handle.Applied = false;
			_externalShowControls[handle.NpcConfigUid] = handle;
			return;
		}
		if (handle.Visible)
		{
			if (handle.HasWorldPosition && handle.HasWorldRotation)
			{
				ForceShowNpc(entrance, handle.WorldPosition, handle.WorldRotation);
			}
			else if (handle.HasWorldPosition)
			{
				ForceShowNpc(entrance, handle.WorldPosition);
			}
			else
			{
				ForceShowNpc(entrance);
			}
		}
		else
		{
			ForceHideNpc(entrance);
		}
		handle.Applied = true;
		handle.ControlSource = GetNpcShowControlSource(handle.NpcConfigUid);
		_externalShowControls[handle.NpcConfigUid] = handle;
		NotifyExternalShowControlApplied(handle.NpcConfigUid, handle.Visible);
	}

	private void NotifyExternalShowControlApplied(int npcConfigUid, bool visible)
	{
		if (visible)
		{
			OnNpcShow?.Invoke(npcConfigUid);
		}
		else
		{
			OnNpcHide?.Invoke(npcConfigUid);
		}
	}

	private bool TryResolveEntranceForExternalControl(int npcConfigUid, out NpcShowEntranceCollection entrance)
	{
		if (TryGetNpcEntrance(npcConfigUid, out entrance))
		{
			return true;
		}
		if (!TryGetNpcEntranceConfig(npcConfigUid, out entrance) || entrance == null)
		{
			return false;
		}
		if (_allNpcDataDic != null)
		{
			_allNpcDataDic[npcConfigUid] = entrance;
		}
		return true;
	}

	private void ClearExternalShowControls()
	{
		_externalShowControls.Clear();
		_nextExternalShowControlOid = 0;
	}

	public void ForceShowNpc(int npcConfigUid)
	{
		if (TryGetNpcEntrance(npcConfigUid, out var entrance))
		{
			ForceShowNpc(entrance);
		}
	}

	public void ForceShowNpc(int npcConfigUid, Vector3 worldPosition)
	{
		if (TryGetNpcEntrance(npcConfigUid, out var entrance))
		{
			ForceShowNpc(entrance, worldPosition);
		}
	}

	public void ForceShowNpc(int npcConfigUid, Vector3 worldPosition, Vector3 worldRotation)
	{
		if (TryGetNpcEntrance(npcConfigUid, out var entrance))
		{
			ForceShowNpc(entrance, worldPosition, worldRotation);
		}
	}

	public void ForceShowDialogueVirtualNpc(int npcConfigUid, Vector3 worldPosition, Vector3 worldRotation)
	{
		if (TryGetNpcEntrance(npcConfigUid, out var entrance))
		{
			_dialogueVirtualNpcConfigUids.Add(npcConfigUid);
			ForceShowNpc(entrance, worldPosition, worldRotation);
		}
	}

	public void ForceShowNpc(NpcShowEntranceCollection entrance)
	{
		if (entrance != null)
		{
			entrance.RuntimeWorldPositionOverride = null;
			entrance.RuntimeWorldRotationOverride = null;
			ForceShowNpcInternal(entrance);
		}
	}

	public void ForceShowNpc(NpcShowEntranceCollection entrance, Vector3 worldPosition)
	{
		if (entrance != null)
		{
			entrance.RuntimeWorldPositionOverride = SnapForceShowPositionToGround(worldPosition);
			entrance.RuntimeWorldRotationOverride = null;
			ForceShowNpcInternal(entrance);
		}
	}

	public void ForceShowNpc(NpcShowEntranceCollection entrance, Vector3 worldPosition, Vector3 worldRotation)
	{
		if (entrance != null)
		{
			entrance.RuntimeWorldPositionOverride = SnapForceShowPositionToGround(worldPosition);
			entrance.RuntimeWorldRotationOverride = worldRotation;
			ForceShowNpcInternal(entrance);
		}
	}

	private static Vector3 SnapForceShowPositionToGround(Vector3 worldPosition)
	{
		if (!Physics.Raycast(worldPosition, Vector3.down, out var hitInfo, 10f, BattleConsts.enviromentMask, QueryTriggerInteraction.Ignore))
		{
			return worldPosition;
		}
		return hitInfo.point;
	}

	private void ForceShowNpcInternal(NpcShowEntranceCollection entrance)
	{
		UnbindEntranceConditionControl(entrance);
		RemovePreparedNpc(entrance.NpcConfigUid);
		_showControlOverrides[entrance.NpcConfigUid] = NpcShowControlSource.ForceShow;
		ApplyNpcShowState(entrance, show: true);
	}

	public void ForceHideNpc(int npcConfigUid)
	{
		if (TryGetNpcEntrance(npcConfigUid, out var entrance))
		{
			ForceHideNpc(entrance);
		}
	}

	public void ForceHideNpc(NpcShowEntranceCollection entrance)
	{
		if (entrance != null)
		{
			entrance.RuntimeWorldPositionOverride = null;
			entrance.RuntimeWorldRotationOverride = null;
			UnbindEntranceConditionControl(entrance);
			RemovePreparedNpc(entrance.NpcConfigUid);
			_showControlOverrides[entrance.NpcConfigUid] = NpcShowControlSource.ForceHide;
			ApplyNpcShowState(entrance, show: false);
		}
	}

	public void UseNpcConditionControl(int npcConfigUid)
	{
		if (TryGetNpcEntrance(npcConfigUid, out var entrance))
		{
			UseNpcConditionControl(entrance);
		}
	}

	public void UseNpcConditionControl(NpcShowEntranceCollection entrance)
	{
		if (entrance != null)
		{
			entrance.RuntimeWorldPositionOverride = null;
			entrance.RuntimeWorldRotationOverride = null;
			_showControlOverrides.Remove(entrance.NpcConfigUid);
			BindEntranceConditionControl(entrance, refreshCondition: true);
			if (IsNpcCanDisplay(entrance.NpcConfigUid))
			{
				ApplyNpcShowStates();
			}
			else
			{
				ApplyNpcShowState(entrance, show: false);
			}
		}
	}

	public void RestoreDialogueVirtualNpcs()
	{
		foreach (int dialogueVirtualNpcConfigUid in _dialogueVirtualNpcConfigUids)
		{
			UseNpcConditionControl(dialogueVirtualNpcConfigUid);
		}
		_dialogueVirtualNpcConfigUids.Clear();
	}

	public void AddSupportShowChunkId(int worldId, int chunkId)
	{
		SetChunkNpcForceControl(worldId, chunkId, NpcShowControlSource.ForceShow);
	}

	public void RemoveSupportShowChunkId(int worldId, int chunkId)
	{
		SetChunkNpcForceControl(worldId, chunkId, NpcShowControlSource.ForceHide);
	}

	private void SetChunkNpcForceControl(int worldId, int chunkId, NpcShowControlSource controlSource)
	{
		IReadOnlyList<NpcShowEntranceCollection> npcEntranceCollectionConfigs = NpcEntranceCollectionConfigs;
		if (npcEntranceCollectionConfigs == null)
		{
			return;
		}
		foreach (NpcShowEntranceCollection item in npcEntranceCollectionConfigs)
		{
			if (item != null && item.ChunkID == chunkId && GetNpcWorldId(item.NpcConfigUid) == worldId)
			{
				if (_allNpcDataDic != null)
				{
					_allNpcDataDic[item.NpcConfigUid] = item;
				}
				switch (controlSource)
				{
				case NpcShowControlSource.ForceShow:
					ForceShowNpc(item);
					break;
				case NpcShowControlSource.ForceHide:
					ForceHideNpc(item);
					break;
				default:
					UseNpcConditionControl(item);
					break;
				}
			}
		}
	}

	public bool ForceReleaseNpcModelResource(int npcConfigUid)
	{
		return GameManager.npcSystem?.ForceReleaseNpcModelResource(npcConfigUid) ?? false;
	}

	public bool RegenerateNpcModelResource(int npcConfigUid)
	{
		return GameManager.npcSystem?.RegenerateNpcModelResource(npcConfigUid) ?? false;
	}

	private void LoadMainCharacterModel(Sex sex)
	{
		YooAssetReference assetID = ((sex == Sex.MALE) ? GameLoader.meta.maleMainCharacterModel : GameLoader.meta.femaleMainCharacterModel);
		_mainCharacterRawModelHandle = NpcAssetStation.InstantiateAsync(assetID, MonoECS.instance.GetRoot(SceneRootType.Npc).transform);
		_mainCharacterRawModelHandle.Completed += OnMainCharacterModelLoaded;
	}

	private void OnMainCharacterModelLoaded(AssetLoadHandle handle)
	{
		if (handle != _mainCharacterRawModelHandle)
		{
			return;
		}
		_mainCharacterModel = handle.AsGameObject();
		if (!(_mainCharacterModel == null))
		{
			_mainCharacterModel.SetActive(value: false);
			if (_mainRoleMode && _loadedDialogueCharacterModel == null)
			{
				ActivateMainCharacterModel();
			}
		}
	}

	private void ReleaseMainCharacterModel()
	{
		if (_mainCharacterRawModelHandle.IsValid)
		{
			NpcAssetStation.ReleaseInstance(_mainCharacterRawModelHandle);
		}
		_mainCharacterRawModelHandle = default;
		_mainCharacterModel = null;
	}

	private void OnSexChange(BaseEventContent content)
	{
		if (content is SexChange sexChange)
		{
			ReleaseMainCharacterModel();
			LoadMainCharacterModel(sexChange.Sex);
		}
	}

	private async UniTask<GameObject> AwaitMainCharacterModelAsync(CancellationToken cancellationToken)
	{
		while (_mainCharacterModel == null)
		{
			AssetLoadHandle handle = _mainCharacterRawModelHandle;
			if (!handle.IsValid)
			{
				return null;
			}
			try
			{
				if (!cancellationToken.CanBeCanceled)
				{
					await handle;
				}
				else
				{
					await handle.ToUniTask(PlayerLoopTiming.Update, cancellationToken);
				}
			}
			catch (OperationCanceledException)
			{
				return null;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				return null;
			}
			if (handle == _mainCharacterRawModelHandle)
			{
				break;
			}
		}
		return _mainCharacterModel;
	}

	private void ActivateMainCharacterModel()
	{
		if (!(_mainCharacterModel == null))
		{
			_mainCharacterModel.SetActive(value: true);
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity.IsValid)
			{
				Transform rootTransform = mainEntity.GetRootTransform();
				_mainCharacterModel.transform.SetPositionAndRotation(rootTransform.position, rootTransform.rotation);
			}
		}
	}

	private void DeactivateMainCharacterModel()
	{
		if (!(_mainCharacterModel == null))
		{
			_mainCharacterModel.SetActive(value: false);
		}
	}

	private async UniTask<GameObject> LoadDialogueCharacterModelAsync(int characterId, CancellationToken cancellationToken)
	{
		int version = ++_dialogueCharacterLoadVersion;
		ReleaseLoadedDialogueCharacterModel();
		CharacterSkinRuntimeUtility.TryResolveBattleThenBagCharacterSource(characterId, out var source);
		int skinId = CharacterSkinRuntimeUtility.ResolveSkinId(characterId, source);
		string modelPath = CharacterSkinRuntimeUtility.GetModelPath(characterId, skinId, CharacterModelUsage.Npc);
		if (string.IsNullOrEmpty(modelPath))
		{
			return null;
		}
		AssetLoadHandle handle = (_loadedDialogueCharacterHandle = NpcAssetStation.InstantiateAsync(modelPath, MonoECS.instance.GetRoot(SceneRootType.Npc).transform));
		if (!handle.IsValid)
		{
			return null;
		}
		try
		{
			if (!cancellationToken.CanBeCanceled)
			{
				await handle;
			}
			else
			{
				await handle.ToUniTask(PlayerLoopTiming.Update, cancellationToken);
			}
		}
		catch (OperationCanceledException)
		{
			if (version == _dialogueCharacterLoadVersion)
			{
				ReleaseLoadedDialogueCharacterModel();
			}
			return null;
		}
		if (version != _dialogueCharacterLoadVersion)
		{
			return null;
		}
		if (!handle.IsValid)
		{
			ReleaseLoadedDialogueCharacterModel();
			return null;
		}
		GameObject model = handle.AsGameObject();
		if (model == null)
		{
			ReleaseLoadedDialogueCharacterModel();
			return null;
		}
		model.SetActive(value: false);
		await TryApplyDialogueCharacterAvgAnimator(model, characterId, skinId, version, cancellationToken);
		DisableDialogueCharacterRootMotion(model);
		if (version != _dialogueCharacterLoadVersion)
		{
			return null;
		}
		if (cancellationToken.IsCancellationRequested)
		{
			ReleaseLoadedDialogueCharacterModel();
			return null;
		}
		_loadedDialogueCharacterModel = model;
		return model;
	}

	private async UniTask TryApplyDialogueCharacterAvgAnimator(GameObject model, int characterId, int skinId, int version, CancellationToken cancellationToken)
	{
		int skinId2 = ((skinId > 0) ? skinId : characterId);
		string animatorAssetId = CharacterSkinRuntimeUtility.GetAnimatorAssetId(skinId2, CharacterModelUsage.Avg);
		if (string.IsNullOrEmpty(animatorAssetId))
		{
			return;
		}
		AssetLoadHandle animatorHandle;
		try
		{
			animatorHandle = (_loadedDialogueCharacterAnimatorHandle = NpcAssetStation.LoadAsync<RuntimeAnimatorController>(animatorAssetId));
			if (!animatorHandle.IsValid)
			{
				LogDialogueCharacterAvgAnimatorLoadFailed(characterId, animatorAssetId);
				ReleaseLoadedDialogueCharacterAnimator();
				return;
			}
			if (!cancellationToken.CanBeCanceled)
			{
				await animatorHandle;
			}
			else
			{
				await animatorHandle.ToUniTask(PlayerLoopTiming.Update, cancellationToken);
			}
		}
		catch (OperationCanceledException)
		{
			if (version == _dialogueCharacterLoadVersion)
			{
				ReleaseLoadedDialogueCharacterAnimator();
			}
			return;
		}
		catch (Exception e)
		{
			LogDialogueCharacterAvgAnimatorLoadFailed(characterId, animatorAssetId, e);
			if (version == _dialogueCharacterLoadVersion)
			{
				ReleaseLoadedDialogueCharacterAnimator();
			}
			return;
		}
		if (version == _dialogueCharacterLoadVersion)
		{
			RuntimeAnimatorController runtimeAnimatorController = (animatorHandle.IsValid ? animatorHandle.As<RuntimeAnimatorController>() : null);
			if (runtimeAnimatorController == null)
			{
				LogDialogueCharacterAvgAnimatorLoadFailed(characterId, animatorAssetId);
				ReleaseLoadedDialogueCharacterAnimator();
			}
			else
			{
				CharacterSkinRuntimeUtility.ApplyAnimatorOverride(model, runtimeAnimatorController);
			}
		}
	}

	private void LogDialogueCharacterAvgAnimatorLoadFailed(int characterId, string animatorAssetId, Exception e = null)
	{
		if (e == null)
		{
			Debug.LogWarning($"对话角色AVG状态机加载失败: characterId={characterId}, assetId={animatorAssetId}");
		}
		else
		{
			Debug.LogWarning($"对话角色AVG状态机加载失败: characterId={characterId}, assetId={animatorAssetId}\n{e}");
		}
	}

	private void DisableDialogueCharacterRootMotion(GameObject model)
	{
		if (model == null)
		{
			return;
		}
		Animator[] componentsInChildren = model.GetComponentsInChildren<Animator>(includeInactive: true);
		foreach (Animator animator in componentsInChildren)
		{
			if (animator != null)
			{
				animator.applyRootMotion = false;
			}
		}
	}

	private void ActivateLoadedDialogueCharacterModel()
	{
		if (!(_loadedDialogueCharacterModel == null))
		{
			_loadedDialogueCharacterModel.SetActive(value: true);
			DisableDialogueCharacterRootMotion(_loadedDialogueCharacterModel);
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity.IsValid)
			{
				Transform rootTransform = mainEntity.GetRootTransform();
				_loadedDialogueCharacterModel.transform.SetPositionAndRotation(rootTransform.position, rootTransform.rotation);
			}
		}
	}

	private void ReleaseLoadedDialogueCharacterAnimator()
	{
		if (_loadedDialogueCharacterAnimatorHandle.IsValid)
		{
			NpcAssetStation.Release(_loadedDialogueCharacterAnimatorHandle);
		}
		_loadedDialogueCharacterAnimatorHandle = default;
	}

	private void ReleaseLoadedDialogueCharacterModel()
	{
		ReleaseLoadedDialogueCharacterAnimator();
		if (_loadedDialogueCharacterHandle.IsValid)
		{
			NpcAssetStation.ReleaseInstance(_loadedDialogueCharacterHandle);
		}
		_loadedDialogueCharacterHandle = default;
		_loadedDialogueCharacterModel = null;
	}

	private void InvalidateAndReleaseLoadedDialogueCharacterModel()
	{
		_dialogueCharacterLoadVersion++;
		ReleaseLoadedDialogueCharacterModel();
	}

	public bool TryGetReceiveMissionData(int npcUid, out ReceiveMissionData receiveMissionData)
	{
		if (_receiveMissionDatasByNpcId == null)
		{
			receiveMissionData = default;
			return false;
		}
		return _receiveMissionDatasByNpcId.TryGetValue(npcUid, out receiveMissionData);
	}

	public List<ReceiveMissionData> GetReceiveMissionDatas(int areaId)
	{
		List<ReceiveMissionData> list = new List<ReceiveMissionData>();
		if (_receiveMissionDatas == null || !_receiveMissionDatas.TryGetValue(areaId, out var value))
		{
			return list;
		}
		foreach (ReceiveMissionData item in value)
		{
			if (IsNpcCanDisplay(item.npcUid) && Singleton<MissionManager>.instance.IsMissionValid(item.missionId))
			{
				item.npcCondition.BindRuntimeContext();
				bool flag = item.npcCondition.IsPassWithoutCache();
				bool flag2 = !Singleton<MissionManager>.instance.IsAccepted(item.missionId);
				if (flag & flag2)
				{
					list.Add(new ReceiveMissionData
					{
						npcCondition = null,
						npcUid = item.npcUid,
						missionId = item.missionId,
						optionIndex = item.optionIndex
					});
				}
				item.npcCondition.FreeRuntimeContext();
			}
		}
		return list;
	}

	public List<ReceiveMissionData> GetReceiveMissionDatas_Full(int areaId)
	{
		List<ReceiveMissionData> list = new List<ReceiveMissionData>();
		if (_receiveMissionDatas == null || !_receiveMissionDatas.TryGetValue(areaId, out var value))
		{
			return list;
		}
		foreach (ReceiveMissionData item in value)
		{
			if (Singleton<MissionManager>.instance.IsMissionValid(item.missionId))
			{
				item.npcCondition.BindRuntimeContext();
				list.Add(new ReceiveMissionData
				{
					npcCondition = null,
					npcUid = item.npcUid,
					missionId = item.missionId,
					optionIndex = item.optionIndex
				});
				item.npcCondition.FreeRuntimeContext();
			}
		}
		return list;
	}

	private void RebuildReceiveMissionDatasByArea()
	{
		ReleaseReceiveMissionDatas();
		_receiveMissionDatas = DictionaryPool<int, List<ReceiveMissionData>>.Get();
		_receiveMissionDatasByNpcId = DictionaryPool<int, ReceiveMissionData>.Get();
		List<ReceiveMissionData> list = GameLoader.meta?.npcGlobalConfig?.receiveMissionDatas;
		if (list == null)
		{
			return;
		}
		foreach (ReceiveMissionData item in list)
		{
			if (item.npcUid <= 0 || (TryGetNpcEntranceConfig(item.npcUid, out var entrance) && entrance.IsGameWorldConfig))
			{
				continue;
			}
			int npcMapAreaID = TableRule.GetNpcMapAreaID(item.npcUid);
			if (NpcDataConfig.AreaIDMap.TryGetValue(npcMapAreaID, out var value))
			{
				if (!_receiveMissionDatas.TryGetValue(value, out var value2))
				{
					value2 = ListPool<ReceiveMissionData>.Get();
					_receiveMissionDatas[value] = value2;
				}
				value2.Add(item);
				_receiveMissionDatasByNpcId[item.npcUid] = item;
			}
		}
	}

	private void ReleaseReceiveMissionDatas()
	{
		if (_receiveMissionDatas == null)
		{
			return;
		}
		foreach (List<ReceiveMissionData> value in _receiveMissionDatas.Values)
		{
			ListPool<ReceiveMissionData>.Release(value);
		}
		DictionaryPool<int, List<ReceiveMissionData>>.Release(_receiveMissionDatas);
		_receiveMissionDatas = null;
	}

	private void RefreshShowNpc(NpcShowEntranceCollection newEntrance, bool isAdd = true)
	{
		UpdateShouldShowNpc(newEntrance, isAdd);
		if (CanApplyNpcShowStates())
		{
			ApplyNpcShowStates();
		}
	}

	private void UpdateShouldShowNpc(NpcShowEntranceCollection entrance, bool isAdd)
	{
		if (isAdd)
		{
			entrance.RefreshActiveRuleIndexFromCache();
			AddPreparedNpc(entrance);
			return;
		}
		RemovePreparedNpc(entrance.NpcConfigUid);
		if (CanApplyNpcShowStates())
		{
			ApplyNpcShowState(entrance, show: false);
		}
	}

	private void ApplyNpcShowStates()
	{
		HashSet<int> hashSet = HashSetPool<int>.Get();
		try
		{
			ResolveVisibleNpc(hashSet, considerShowArea: true);
			for (int i = 0; i < _preparedNpcPriorityQueue.Count; i++)
			{
				NpcShowEntranceCollection npcShowEntranceCollection = _preparedNpcPriorityQueue[i];
				if (npcShowEntranceCollection != null)
				{
					ApplyNpcShowState(npcShowEntranceCollection, hashSet.Contains(npcShowEntranceCollection.NpcConfigUid));
				}
			}
		}
		finally
		{
			HashSetPool<int>.Release(hashSet);
		}
	}

	private void ApplyNpcShowState(NpcShowEntranceCollection entrance, bool show)
	{
		if (entrance == null)
		{
			return;
		}
		switch (GetNpcShowControlSource(entrance.NpcConfigUid))
		{
		case NpcShowControlSource.ForceShow:
			show = true;
			break;
		case NpcShowControlSource.ForceHide:
			show = false;
			break;
		}
		SystemNpc npcSystem = GameManager.npcSystem;
		if (show)
		{
			if (npcSystem.IsNpcShowRequested(entrance))
			{
				npcSystem.RefreshNpcPosition(entrance);
			}
			else
			{
				npcSystem.ShowNpc(entrance);
			}
		}
		else if (!npcSystem.IsNpcHideRequested(entrance))
		{
			npcSystem.HideNpc(entrance);
		}
	}

	private void ResolveVisibleNpc(HashSet<int> visibleNpcConfigUids, bool considerShowArea)
	{
		visibleNpcConfigUids.Clear();
		EnsurePreparedNpcPriorityQueueSorted();
		HashSet<int> hashSet = HashSetPool<int>.Get();
		try
		{
			for (int i = 0; i < _preparedNpcPriorityQueue.Count; i++)
			{
				NpcShowEntranceCollection npcShowEntranceCollection = _preparedNpcPriorityQueue[i];
				if (npcShowEntranceCollection != null)
				{
					hashSet.Add(npcShowEntranceCollection.NpcConfigUid);
				}
			}
			for (int num = _preparedNpcPriorityQueue.Count - 1; num >= 0; num--)
			{
				NpcShowEntranceCollection npcShowEntranceCollection2 = _preparedNpcPriorityQueue[num];
				if (npcShowEntranceCollection2 != null)
				{
					hashSet.Remove(npcShowEntranceCollection2.NpcConfigUid);
					if (!IsNpcExcludedByRules(npcShowEntranceCollection2, hashSet, considerShowArea))
					{
						visibleNpcConfigUids.Add(npcShowEntranceCollection2.NpcConfigUid);
					}
				}
			}
		}
		finally
		{
			HashSetPool<int>.Release(hashSet);
		}
	}

	private bool IsNpcExcludedByRules(NpcShowEntranceCollection entrance, HashSet<int> higherPriorityNpcConfigUids, bool considerShowArea)
	{
		if (!IsExcludedByMutualExclusionNpc(entrance, higherPriorityNpcConfigUids))
		{
			if (considerShowArea)
			{
				return !IsNpcInShowArea(entrance);
			}
			return false;
		}
		return true;
	}

	private static bool IsExcludedByMutualExclusionNpc(NpcShowEntranceCollection entrance, HashSet<int> higherPriorityNpcConfigUids)
	{
		List<int> mutualExclusionNpcTableUid = entrance.MutualExclusionNpcTableUid;
		if (mutualExclusionNpcTableUid == null || mutualExclusionNpcTableUid.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < mutualExclusionNpcTableUid.Count; i++)
		{
			if (higherPriorityNpcConfigUids.Contains(mutualExclusionNpcTableUid[i]))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsNpcInShowArea(NpcShowEntranceCollection entrance)
	{
		if (Singleton<GameManager>.instance.worldManager == null)
		{
			return true;
		}
		int npcWorldId = GetNpcWorldId(entrance.NpcConfigUid);
		return IsActiveChunk(npcWorldId, entrance.ChunkID);
	}

	public async UniTask WaitAllNpcLoadCompleteAsync(Action<float> onProgress = null)
	{
		NotifyNpcShowState();
		SystemNpc npcSystem = GameManager.npcSystem;
		if (npcSystem == null)
		{
			onProgress?.Invoke(1f);
			return;
		}
		await UniTask.NextFrame();
		int pendingCount = npcSystem.PendingNpcLoadCount;
		int completedCount = 0;
		int totalCount = pendingCount;
		float deadline = Time.realtimeSinceStartup + 15f;
		while (pendingCount > 0)
		{
			if (Time.realtimeSinceStartup >= deadline)
			{
				Debug.LogWarning($"[NPC加载] 等待 NPC 加载完成超时，仍有 {pendingCount} 个 NPC 未加载完成，加载流程继续。");
				break;
			}
			onProgress?.Invoke((totalCount > 0) ? ((float)completedCount / (float)totalCount) : 0f);
			await UniTask.NextFrame();
			int pendingNpcLoadCount = npcSystem.PendingNpcLoadCount;
			if (pendingNpcLoadCount < pendingCount)
			{
				completedCount += pendingCount - pendingNpcLoadCount;
			}
			pendingCount = pendingNpcLoadCount;
			if (completedCount + pendingCount > totalCount)
			{
				totalCount = completedCount + pendingCount;
			}
		}
		onProgress?.Invoke(1f);
	}
}
