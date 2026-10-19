using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Drama;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Rendering;
using ACT.UI;
using ACT.World;
using ACT.World.Asset;
using ACT.World.SceneChunks;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;

namespace ACT.Model;

public class TreasureModel : Model<TreasureModel>
{
	private Dictionary<TreasureType, List<Treasure>> _typeToTreasures = new Dictionary<TreasureType, List<Treasure>>();

	private Dictionary<int, Treasure> _idToTreasure = new Dictionary<int, Treasure>();

	private readonly List<Treasure> _allTreasures = new List<Treasure>();

	private readonly List<TreasureDisk> _allDisks = new List<TreasureDisk>();

	private readonly Dictionary<int, TreasureDisk> _diskByTreasureId = new Dictionary<int, TreasureDisk>();

	private bool _diskCollectionStateInitialized;

	private readonly List<Treasure> _allSpecialTreasures = new List<Treasure>();

	private bool _initialized;

	private Dictionary<int, (ACT.World.MapArea, MapSubArea)> _collectionMap = new Dictionary<int, (ACT.World.MapArea, MapSubArea)>();

	private bool _collectionMapLoaded;

	private UniTaskCompletionSource _collectionMapLoadCompletionSource;

	private readonly Queue<Treasure> _treasureTutorialQueue = new Queue<Treasure>();

	private readonly Queue<Treasure> _treasureHudTipsQueue = new Queue<Treasure>();

	private bool _isProcessingTreasureNoticeQueue;

	private int _lifecycleVersion;

	private const float GuideImageVideoOpenTimeout = 5f;

	private const float GuideImageVideoRequestTimeout = 30f;

	private const float GuideImageVideoPopupRetryTimeout = 30f;

	public List<Treasure> allTreasures => _allTreasures;

	public Dictionary<int, Dictionary<int, float>> _treasureGlobalProperty { get; private set; } = new Dictionary<int, Dictionary<int, float>>();

	public Dictionary<int, Dictionary<int, float>> _treasureCharacterProperty { get; private set; } = new Dictionary<int, Dictionary<int, float>>();

	public List<int> _treasureCharacterList { get; private set; } = new List<int>();

	public bool Initialized => _initialized;

	public Dictionary<int, (ACT.World.MapArea, MapSubArea)> CollectionMap => _collectionMap;

	public UniTask RefreshCollectionMap()
	{
		if (_collectionMapLoaded)
		{
			return UniTask.CompletedTask;
		}
		if (_collectionMapLoadCompletionSource != null)
		{
			return _collectionMapLoadCompletionSource.Task;
		}
		int lifecycleVersion = _lifecycleVersion;
		UniTaskCompletionSource uniTaskCompletionSource = (_collectionMapLoadCompletionSource = new UniTaskCompletionSource());
		LoadCollectionMapAsync(lifecycleVersion, uniTaskCompletionSource).Forget();
		return uniTaskCompletionSource.Task;
	}

	private async UniTaskVoid LoadCollectionMapAsync(int lifecycleVersion, UniTaskCompletionSource completionSource)
	{
		try
		{
			ILoadPartitionResult<ConfigWorldPartition_v2> loadPartitionResult = await WorldPartitionSetting.Data.TryLoadPartition(3, isMainWorld: true);
			if (lifecycleVersion != _lifecycleVersion)
			{
				completionSource.TrySetResult();
				return;
			}
			if (!loadPartitionResult.Success || loadPartitionResult.Data == null)
			{
				completionSource.TrySetResult();
				return;
			}
			Dictionary<int, (ACT.World.MapArea, MapSubArea)> dictionary = new Dictionary<int, (ACT.World.MapArea, MapSubArea)>();
			SceneChunk[] sceneChunks = loadPartitionResult.Data.SceneChunks;
			foreach (SceneChunk sceneChunk in sceneChunks)
			{
				LoopAndFillCollectionMap(sceneChunk.StateWorldAssetDatas, (ACT.World.MapArea)sceneChunk.MapId, (MapSubArea)sceneChunk.AreaId, dictionary);
				SceneBlock[] subScenes = sceneChunk.SubScenes;
				foreach (SceneBlock sceneBlock in subScenes)
				{
					LoopAndFillCollectionMap(sceneBlock.StateWorldAssetDatas, (ACT.World.MapArea)sceneChunk.MapId, (MapSubArea)sceneChunk.AreaId, dictionary);
				}
			}
			_collectionMap = dictionary;
			_collectionMapLoaded = true;
			completionSource.TrySetResult();
		}
		catch (Exception exception)
		{
			completionSource.TrySetException(exception);
		}
		finally
		{
			if (_collectionMapLoadCompletionSource == completionSource)
			{
				_collectionMapLoadCompletionSource = null;
			}
		}
	}

	private void LoopAndFillCollectionMap(StateWorldAssetData[] assetDatas, ACT.World.MapArea mapArea, MapSubArea subArea, Dictionary<int, (ACT.World.MapArea, MapSubArea)> toDict)
	{
		for (int i = 0; i < assetDatas.Length; i++)
		{
			if (assetDatas[i] is CollectionPointData collectionPointData)
			{
				toDict.TryAdd(collectionPointData.collectionPointId, (mapArea, subArea));
			}
		}
	}

	protected override void Init()
	{
		_allTreasures.Clear();
		_allDisks.Clear();
		_diskByTreasureId.Clear();
		_allSpecialTreasures.Clear();
		_diskCollectionStateInitialized = false;
		foreach (KeyValuePair<int, ItemTreasureData> itemTreasureData in RuntimeConfigs.data.itemTreasureDatas)
		{
			if (itemTreasureData.Value.type == 2)
			{
				TreasureDisk treasureDisk = new TreasureDisk(itemTreasureData.Key, itemTreasureData.Value.itemId);
				_allDisks.Add(treasureDisk);
				_diskByTreasureId[itemTreasureData.Key] = treasureDisk;
				continue;
			}
			Treasure treasure = new Treasure();
			treasure.TreasureId = itemTreasureData.Key;
			treasure.GainTime = 0;
			treasure.Type = (TreasureType)itemTreasureData.Value.type;
			_allTreasures.Add(treasure);
			if (itemTreasureData.Value.functionId > 0)
			{
				_allSpecialTreasures.Add(treasure);
			}
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TreasureAdd, AddTreasureAttrToCharacter);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, AddTreasureAttrToCharacter);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_Add, AddTreasureAttrToSubWorldCharacter);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnBagItemChange);
	}

	protected override void UnInit()
	{
		_lifecycleVersion++;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TreasureAdd, AddTreasureAttrToCharacter);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, AddTreasureAttrToCharacter);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_Add, AddTreasureAttrToSubWorldCharacter);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnBagItemChange);
		_treasureGlobalProperty.Clear();
		_allTreasures.Clear();
		_allDisks.Clear();
		_diskByTreasureId.Clear();
		_allSpecialTreasures.Clear();
		_diskCollectionStateInitialized = false;
		_idToTreasure.Clear();
		_typeToTreasures.Clear();
		_treasureTutorialQueue.Clear();
		_treasureHudTipsQueue.Clear();
		_collectionMap.Clear();
		_collectionMapLoaded = false;
		_collectionMapLoadCompletionSource = null;
		_isProcessingTreasureNoticeQueue = false;
		_initialized = false;
	}

	private void OnBagItemChange(BaseEventContent obj)
	{
		if (obj is ItemChangeEvt itemChangeEvt && ContainsGemChange(itemChangeEvt))
		{
			if (!_diskCollectionStateInitialized)
			{
				RefreshDiskCollectionState();
			}
			else
			{
				RefreshDiskCollectionState(markNewCollection: true);
			}
		}
	}

	private static bool ContainsGemChange(ItemChangeEvt itemChangeEvt)
	{
		if (itemChangeEvt?.ItemProxies == null)
		{
			return false;
		}
		for (int i = 0; i < itemChangeEvt.ItemProxies.Count; i++)
		{
			if (itemChangeEvt.ItemProxies[i]?.Source is Gem)
			{
				return true;
			}
		}
		return false;
	}

	private static bool TryGetMainWorldGemSnapshot(out MapField<int, Gem> gemSnapshot)
	{
		gemSnapshot = null;
		if (G.localPlayer == null || G.localPlayer.characterRepository == null || !G.localPlayer.characterRepository.TryGetValue(0, out var value))
		{
			return false;
		}
		if (G.localPlayer.teamInfo?.CharacterRepository == null || !G.localPlayer.teamInfo.CharacterRepository.ContainsKey(0))
		{
			return false;
		}
		gemSnapshot = value?.CharacterDependSnapshot?.GemSnapshot;
		return gemSnapshot != null;
	}

	protected override void OnDestroy()
	{
	}

	public void OnReceiveTreasureInfoNtf(TreasureInfo treasureInfo)
	{
		foreach (var (num2, treasure2) in treasureInfo.Treasures)
		{
			ItemTreasureData data = CoreUtils.GetData(num2, RuntimeConfigs.data.itemTreasureDatas);
			if (data != null && data.type != 2)
			{
				Treasure treasure3 = new Treasure();
				treasure3.TreasureId = num2;
				treasure3.GainTime = treasure2.GainTime;
				treasure3.Type = (TreasureType)data.type;
				AddTreasure(treasure3);
			}
		}
		_initialized = true;
		RefreshDiskCollectionState();
	}

	public void OnReceiveNewTreasureInfoNtf(TreasureInfo treasureInfo)
	{
		foreach (var (num2, treasure2) in treasureInfo.Treasures)
		{
			ItemTreasureData data = CoreUtils.GetData(num2, RuntimeConfigs.data.itemTreasureDatas);
			if (data == null || data.type == 2)
			{
				continue;
			}
			Treasure treasure3 = new Treasure();
			treasure3.TreasureId = num2;
			treasure3.GainTime = treasure2.GainTime;
			treasure3.Type = (TreasureType)data.type;
			bool flag = !_idToTreasure.ContainsKey(num2);
			string text = string.Empty;
			switch (treasure3.Type)
			{
			case TreasureType.Precious:
				text = RedDotPathDefine.Treasure_Precious + $"|{treasure3.TreasureId}";
				break;
			case TreasureType.Fragmented:
				text = RedDotPathDefine.Treasure_Fragmented + $"|{treasure3.TreasureId}";
				break;
			case TreasureType.WaterfallSeal:
				text = RedDotPathDefine.Treasure_WaterfallSeal + $"|{treasure3.TreasureId}";
				break;
			case TreasureType.Relic:
				text = RedDotPathDefine.Treasure_Relic + $"|{treasure3.TreasureId}";
				break;
			case TreasureType.BygoneOldObject:
				text = RedDotPathDefine.Treasure_BygoneOldObject + $"|{treasure3.TreasureId}";
				break;
			case TreasureType.LeftOver:
				text = RedDotPathDefine.Treasure_LeftOver + $"|{treasure3.TreasureId}";
				break;
			case TreasureType.EnergyControl:
				text = RedDotPathDefine.Treasure_EnergyControl + $"|{treasure3.TreasureId}";
				break;
			}
			if ((text != string.Empty) & flag)
			{
				if (!Singleton<RedDotManager>.instance.IsPathRegistered(text))
				{
					Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(text, active: true, 1031);
				}
				else
				{
					Singleton<RedDotManager>.instance.SetLeafNodeActive(text, active: true);
				}
			}
			if (flag)
			{
				AddTreasure(treasure3);
				EnqueueTreasureNotice(treasure3);
			}
		}
		StartProcessTreasureNoticeQueue();
	}

	private void EnqueueTreasureNotice(Treasure newTreasure)
	{
		if (newTreasure != null)
		{
			_treasureTutorialQueue.Enqueue(newTreasure);
			_treasureHudTipsQueue.Enqueue(newTreasure);
		}
	}

	private void StartProcessTreasureNoticeQueue()
	{
		if (!_isProcessingTreasureNoticeQueue && (_treasureTutorialQueue.Count != 0 || _treasureHudTipsQueue.Count != 0))
		{
			_isProcessingTreasureNoticeQueue = true;
			ProcessTreasureNoticeQueueAsync(_lifecycleVersion).Forget();
		}
	}

	private async UniTaskVoid ProcessTreasureNoticeQueueAsync(int lifecycleVersion)
	{
		_ = 2;
		try
		{
			while (lifecycleVersion == _lifecycleVersion && _treasureTutorialQueue.Count > 0)
			{
				Treasure newTreasure = _treasureTutorialQueue.Dequeue();
				if (await TryShowTreasureTutorialViewAsync(newTreasure, lifecycleVersion))
				{
					await WaitGuideImageVideoClosed(lifecycleVersion);
				}
			}
			while (lifecycleVersion == _lifecycleVersion && _treasureHudTipsQueue.Count > 0)
			{
				Treasure treasure = _treasureHudTipsQueue.Dequeue();
				ShowTreasureHudTips(treasure);
				await WaitTreasureHudTipFinished(treasure?.TreasureId ?? 0, lifecycleVersion);
			}
		}
		finally
		{
			if (lifecycleVersion == _lifecycleVersion)
			{
				_isProcessingTreasureNoticeQueue = false;
				if (_treasureTutorialQueue.Count > 0 || _treasureHudTipsQueue.Count > 0)
				{
					StartProcessTreasureNoticeQueue();
				}
			}
		}
	}

	private async UniTask WaitGuideImageVideoClosed(int lifecycleVersion)
	{
		if (Singleton<NewUIManager>.instance == null)
		{
			return;
		}
		float timeoutAt = Time.realtimeSinceStartup + 5f;
		while (lifecycleVersion == _lifecycleVersion && Time.realtimeSinceStartup < timeoutAt)
		{
			if (Singleton<NewUIManager>.instance == null)
			{
				return;
			}
			UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_GUIDEIMAGEVIDEO);
			if (firstUIState == UIState.Opening || firstUIState == UIState.Opened)
			{
				break;
			}
			await UniTask.Yield(PlayerLoopTiming.Update);
		}
		if (lifecycleVersion != _lifecycleVersion || Singleton<NewUIManager>.instance == null)
		{
			return;
		}
		UIState firstUIState2 = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_GUIDEIMAGEVIDEO);
		if (firstUIState2 != UIState.Opening && firstUIState2 != UIState.Opened)
		{
			return;
		}
		await UniTask.WaitUntil(() =>
		{
			if (lifecycleVersion != _lifecycleVersion)
			{
				return true;
			}
			if (Singleton<NewUIManager>.instance == null)
			{
				return true;
			}
			UIState firstUIState3 = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_GUIDEIMAGEVIDEO);
			return firstUIState3 == UIState.Closed || firstUIState3 == UIState.None;
		});
	}

	private static bool IsTreasureTutorialBlockedByAvg()
	{
		if (IsTimelineStoryPlaying())
		{
			return true;
		}
		GameRenderScene.Scene current = GameRenderScene.Current;
		if (current == GameRenderScene.Scene.AVG || current == GameRenderScene.Scene.TimelineConversation)
		{
			return true;
		}
		if (!Singleton<ConversationManager>.HasInstance())
		{
			return false;
		}
		ConversationManager instance = Singleton<ConversationManager>.instance;
		IDialogueWrapper playingDialogue = instance.PlayingDialogue;
		if (playingDialogue is IAVGDialogue || playingDialogue is TimelineDialogue)
		{
			return true;
		}
		if (!instance.IsPlaying || instance.PlayingDialogue != null)
		{
			return false;
		}
		MonoConversationView conversationView = instance.conversationView;
		if (conversationView != null && conversationView.UIController != null)
		{
			UIState state = conversationView.UIController.State;
			if (state != UIState.Closed && state != UIState.None)
			{
				return true;
			}
		}
		if (Singleton<NewUIManager>.instance == null)
		{
			return false;
		}
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_CONVERSATION);
		if (firstUIState != UIState.Closed)
		{
			return firstUIState != UIState.None;
		}
		return false;
	}

	private static bool IsTimelineStoryPlaying()
	{
		if (!Singleton<TimelineConversationManager>.HasInstance())
		{
			return false;
		}
		TimelineConversationManager instance = Singleton<TimelineConversationManager>.instance;
		if (!instance.Playing)
		{
			return instance.DialogPlaying;
		}
		return true;
	}

	private async UniTask<bool> WaitUntilAvgAllowsTreasureTutorial(int lifecycleVersion)
	{
		while (lifecycleVersion == _lifecycleVersion && IsTreasureTutorialBlockedByAvg())
		{
			await UniTask.Yield(PlayerLoopTiming.Update);
		}
		return lifecycleVersion == _lifecycleVersion;
	}

	private async UniTask<bool> TryShowTreasureTutorialViewAsync(Treasure newTreasure, int lifecycleVersion)
	{
		if (newTreasure == null || !Model<TutorialModel>.HasInstance())
		{
			return false;
		}
		int treasureId = newTreasure.TreasureId;
		ItemTreasureData data = CoreUtils.GetData(treasureId, RuntimeConfigs.data.itemTreasureDatas);
		if (data == null || data.guideId <= 0)
		{
			return false;
		}
		int tutorialID = data.guideId;
		if (!Model<TutorialModel>.Interface.CanTriggerTutorial(tutorialID))
		{
			return false;
		}
		bool triggerCompleted = false;
		bool triggerSucceeded = false;
		G.service.TriggerTutorial(tutorialID, (bool success) =>
		{
			triggerSucceeded = success;
			triggerCompleted = true;
		});
		float requestTimeoutAt = Time.realtimeSinceStartup + 30f;
		while (lifecycleVersion == _lifecycleVersion && !triggerCompleted && Time.realtimeSinceStartup < requestTimeoutAt)
		{
			await UniTask.Yield(PlayerLoopTiming.Update);
		}
		if (lifecycleVersion != _lifecycleVersion || !triggerCompleted || !triggerSucceeded)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"Guide tutorial trigger failed or timed out. treasureId={treasureId}, tutorialId={tutorialID}");
			}
			return false;
		}
		if (!(await WaitUntilAvgAllowsTreasureTutorial(lifecycleVersion)))
		{
			return false;
		}
		float popupTimeoutAt = Time.realtimeSinceStartup + 30f;
		while (lifecycleVersion == _lifecycleVersion && Time.realtimeSinceStartup < popupTimeoutAt)
		{
			if (IsTreasureTutorialBlockedByAvg())
			{
				if (!(await WaitUntilAvgAllowsTreasureTutorial(lifecycleVersion)))
				{
					return false;
				}
				popupTimeoutAt = Time.realtimeSinceStartup + 30f;
			}
			else
			{
				if (Singleton<NewUIManager>.instance != null && Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GUIDEIMAGEVIDEO, new GuideImageVideoViewData
				{
					tutorialId = tutorialID
				}).IsValid)
				{
					return true;
				}
				await UniTask.Yield(PlayerLoopTiming.Update);
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"Guide image video popup was not accepted before timeout. treasureId={treasureId}, tutorialId={tutorialID}");
		}
		return false;
	}

	private async UniTask WaitTreasureHudTipFinished(int treasureId, int lifecycleVersion)
	{
		if (Singleton<NewUIManager>.instance == null || treasureId <= 0)
		{
			return;
		}
		TreasureGetHudTips hudTip = ((Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BATTLEMAIN) is MonoBattleMainBaseView monoBattleMainBaseView) ? monoBattleMainBaseView.treasureGetHudTips : null);
		if (hudTip == null)
		{
			await UniTask.Yield(PlayerLoopTiming.Update);
			return;
		}
		float timeoutAt = Time.realtimeSinceStartup + 25f;
		while (lifecycleVersion == _lifecycleVersion && Time.realtimeSinceStartup < timeoutAt && (!hudTip.IsShowing || hudTip.CurrentTreasureId != treasureId))
		{
			await UniTask.Yield(PlayerLoopTiming.Update);
		}
		while (lifecycleVersion == _lifecycleVersion && Time.realtimeSinceStartup < timeoutAt && hudTip.IsShowing)
		{
			await UniTask.Yield(PlayerLoopTiming.Update);
		}
	}

	private void ShowTreasureHudTips(Treasure newTreasure)
	{
		if (newTreasure != null)
		{
			TreasureGetHudTipsData uiData = new TreasureGetHudTipsData
			{
				Id = newTreasure.TreasureId
			};
			OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
			evt.position = UIPosition.LeftBottom;
			evt.type = HudComponentType.TreasureGetTip;
			evt.uiData = uiData;
			evt.timeOutDuration = 15f;
			evt.priorityInQueue = 2;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void AddTreasure(Treasure newTreasure)
	{
		if (newTreasure == null)
		{
			return;
		}
		if (_idToTreasure.ContainsKey(newTreasure.TreasureId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"收集品ID重复：{newTreasure.TreasureId}");
			}
			return;
		}
		if (!_typeToTreasures.ContainsKey(newTreasure.Type))
		{
			_typeToTreasures[newTreasure.Type] = new List<Treasure>();
		}
		_typeToTreasures[newTreasure.Type].Add(newTreasure);
		_idToTreasure[newTreasure.TreasureId] = newTreasure;
	}

	private void AddTreasureAttrToSubWorldCharacter(BaseEventContent obj)
	{
		if (obj is CharacterRefresh characterRefresh)
		{
			if (characterRefresh.character == null && LuminApplication.LogEnabled)
			{
				Debug.LogError("要修改藏品属性的子世界角色为空");
			}
			AddTreasureAttr(characterRefresh.character);
		}
	}

	private void AddTreasureAttrToCharacter(BaseEventContent et)
	{
		List<Character> curAllCharacters = CharacterDataHelper.GetCurAllCharacters();
		if (curAllCharacters == null || curAllCharacters.Count == 0)
		{
			return;
		}
		foreach (Character item in curAllCharacters)
		{
			AddTreasureAttr(item);
		}
	}

	private void AddTreasureAttr(Character character)
	{
		if (character == null || _treasureGlobalProperty == null || (_treasureGlobalProperty.Count == 0 && (_treasureCharacterProperty == null || _treasureCharacterProperty.Count == 0)))
		{
			return;
		}
		Dictionary<int, float> dictionary = DictionaryPool<int, float>.Get();
		foreach (KeyValuePair<int, Dictionary<int, float>> item in _treasureGlobalProperty)
		{
			foreach (KeyValuePair<int, float> item2 in item.Value)
			{
				if (dictionary.ContainsKey(item2.Key))
				{
					dictionary[item2.Key] += item2.Value;
				}
				else
				{
					dictionary[item2.Key] = item2.Value;
				}
			}
		}
		if (dictionary != null && dictionary.Count > 0)
		{
			ChangeSystemProperties evt = Singleton<EventManager>.instance.GetEvt<ChangeSystemProperties>();
			SyncSystemPropertiesToBattle evt2 = Singleton<EventManager>.instance.GetEvt<SyncSystemPropertiesToBattle>();
			evt.properties = dictionary;
			evt.traget = character;
			evt.isReplace = true;
			evt.systemSource = 6;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChangeSystemProperties, evt);
			evt2.traget = character;
			evt2.properties = dictionary;
			evt2.isRemove = false;
			evt2.propertySourceUid = 6;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SyncSystemPropertiesChangeToBattle, evt2);
			if (_treasureCharacterProperty.ContainsKey(character.Id))
			{
				evt.properties = _treasureCharacterProperty[character.Id];
				evt.traget = character;
				evt.isRemove = false;
				evt.systemSource = 6;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChangeSystemProperties, evt);
				evt2.traget = character;
				evt2.properties = _treasureCharacterProperty[character.Id];
				evt2.isRemove = false;
				evt2.propertySourceUid = 6;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.SyncSystemPropertiesChangeToBattle, evt2);
			}
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
		}
		DictionaryPool<int, float>.Release(dictionary);
	}

	public void CalculateTreasuresAttrBonus()
	{
		if (_treasureGlobalProperty.Count > 0)
		{
			_treasureGlobalProperty.Clear();
		}
		if (_treasureCharacterProperty.Count > 0)
		{
			_treasureCharacterProperty.Clear();
		}
		if (_treasureCharacterList.Count > 0)
		{
			_treasureCharacterList.Clear();
		}
		foreach (Treasure value3 in _idToTreasure.Values)
		{
			ItemTreasureData data = CoreUtils.GetData(value3.TreasureId, RuntimeConfigs.data.itemTreasureDatas);
			if (data?.attrId == null || data.attrIncreaseNum == null)
			{
				continue;
			}
			int num = Math.Min(data.attrId.Length, data.attrIncreaseNum.Length);
			for (int i = 0; i < num; i++)
			{
				if (data.characterId != 0)
				{
					if (!_treasureCharacterProperty.TryGetValue(data.characterId, out var value))
					{
						value = new Dictionary<int, float>();
						_treasureCharacterProperty.Add(data.characterId, value);
						_treasureCharacterList.Add(data.characterId);
					}
					int key = data.attrId[i];
					float num2 = data.attrIncreaseNum[i];
					if (value.TryGetValue(key, out var value2))
					{
						value[key] = value2 + num2;
					}
					else
					{
						value.Add(key, num2);
					}
				}
				else if (_treasureGlobalProperty.ContainsKey(value3.TreasureId))
				{
					_treasureGlobalProperty[value3.TreasureId].Add(data.attrId[i], data.attrIncreaseNum[i]);
				}
				else
				{
					_treasureGlobalProperty.Add(value3.TreasureId, new Dictionary<int, float>());
					_treasureGlobalProperty[value3.TreasureId].Add(data.attrId[i], data.attrIncreaseNum[i]);
				}
			}
		}
		_treasureCharacterList.Sort();
	}

	[Obsolete]
	public void RemoveTreasuresAttr()
	{
	}

	public Dictionary<int, Dictionary<int, float>> GetTreasuresAttrBonus()
	{
		return _treasureGlobalProperty;
	}

	public Dictionary<int, Dictionary<int, float>> GetTreasuresCharacterProperty()
	{
		return _treasureCharacterProperty.OrderBy((KeyValuePair<int, Dictionary<int, float>> kv) => kv.Key).ToDictionary((KeyValuePair<int, Dictionary<int, float>> kv) => kv.Key, (KeyValuePair<int, Dictionary<int, float>> kv) => kv.Value);
	}

	public bool TryGetTreasureCharacterProperty(int characterId, out Dictionary<int, float> properties)
	{
		return _treasureCharacterProperty.TryGetValue(characterId, out properties);
	}

	public Dictionary<int, Dictionary<int, float>> GetMergeTreasuresAttrBonus()
	{
		Dictionary<int, float> dictionary = new Dictionary<int, float>();
		foreach (Dictionary<int, float> value3 in _treasureGlobalProperty.Values)
		{
			foreach (KeyValuePair<int, float> item in value3)
			{
				int key = item.Key;
				float value = item.Value;
				if (dictionary.TryGetValue(key, out var value2))
				{
					dictionary[key] = value2 + value;
				}
				else
				{
					dictionary[key] = value;
				}
			}
		}
		Dictionary<int, Dictionary<int, float>> dictionary2 = new Dictionary<int, Dictionary<int, float>>();
		foreach (KeyValuePair<int, float> item2 in dictionary.OrderBy((KeyValuePair<int, float> kv) => kv.Key))
		{
			dictionary2[item2.Key] = new Dictionary<int, float> { { 0, item2.Value } };
		}
		return dictionary2;
	}

	public Dictionary<int, float> GetMergeTreasuresCharacterProperty(Dictionary<int, float> treasureCharacterPropertyDic)
	{
		if (treasureCharacterPropertyDic == null || treasureCharacterPropertyDic.Count == 0)
		{
			return new Dictionary<int, float>();
		}
		Dictionary<int, float> dictionary = new Dictionary<int, float>();
		foreach (KeyValuePair<int, float> item in treasureCharacterPropertyDic)
		{
			int key = item.Key;
			float value = item.Value;
			if (dictionary.ContainsKey(key))
			{
				dictionary[key] += value;
			}
			else
			{
				dictionary[key] = value;
			}
		}
		return dictionary;
	}

	public string GetPrefabNameByTreasureType(int TreasureType)
	{
		return TreasureType switch
		{
			1 => "UI/TreasureFragment", 
			2 => "UI/TreasureFragment", 
			3 => "UI/TreasureFragment", 
			4 => "UI/TreasureFragment", 
			5 => "UI/TreasureFragment", 
			6 => "UI/TreasureFragment", 
			7 => "UI/TreasureFragment", 
		};
	}

	public int GetMyTreasureCounts()
	{
		return _idToTreasure.Count;
	}

	public int GetMyDiskCounts()
	{
		RefreshDiskCollectionState();
		int num = 0;
		for (int i = 0; i < _allDisks.Count; i++)
		{
			if (_allDisks[i].IsCollected)
			{
				num++;
			}
		}
		return num;
	}

	public List<int> GetTreasureTypeIds()
	{
		List<int> list = new List<int>();
		foreach (int key in RuntimeConfigs.data.itemTreasureTypes.Keys)
		{
			list.Add(key);
		}
		list.Sort();
		return list;
	}

	public IReadOnlyList<TreasureDisk> GetAllDisks()
	{
		RefreshDiskCollectionState();
		return _allDisks;
	}

	public TreasureDisk GetDisk(int treasureId)
	{
		_diskByTreasureId.TryGetValue(treasureId, out var value);
		return value;
	}

	private void RefreshDiskCollectionState(bool markNewCollection = false)
	{
		if (!TryGetMainWorldGemSnapshot(out var gemSnapshot))
		{
			return;
		}
		Dictionary<int, Gem> dictionary = DictionaryPool<int, Gem>.Get();
		try
		{
			foreach (KeyValuePair<int, Gem> item in gemSnapshot)
			{
				Gem value = item.Value;
				if (value != null)
				{
					dictionary[value.Id] = value;
				}
			}
			foreach (TreasureDisk allDisk in _allDisks)
			{
				bool isCollected = allDisk.IsCollected;
				dictionary.TryGetValue(allDisk.ItemId, out var value2);
				allDisk.SetCollectedGem(value2);
				if (!(!markNewCollection | isCollected) && allDisk.IsCollected)
				{
					string nodeFullPath = RedDotPathDefine.Treasure_Fragmented + $"|{allDisk.TreasureId}";
					if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
					{
						Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, active: true, 1031);
					}
					else
					{
						Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: true);
					}
				}
			}
			_diskCollectionStateInitialized = true;
		}
		finally
		{
			DictionaryPool<int, Gem>.Release(dictionary);
		}
	}

	public int GetTypeCounts()
	{
		return GetTreasureTypeIds().Count;
	}

	public int GetTypeIcon(int treasureType)
	{
		return CoreUtils.GetData(treasureType, RuntimeConfigs.data.itemTreasureTypes).uiicon;
	}

	public int GetTypeName(int treasureType)
	{
		return CoreUtils.GetData(treasureType, RuntimeConfigs.data.itemTreasureTypes).name;
	}

	public List<Treasure> GetMyTreasuresByType(TreasureType type)
	{
		_typeToTreasures.TryGetValue(type, out var value);
		return value;
	}

	public List<Treasure> GetAllTreasuresByType(TreasureType type)
	{
		List<Treasure> list = new List<Treasure>();
		foreach (Treasure allTreasure in _allTreasures)
		{
			if (type == allTreasure.Type)
			{
				list.Add(allTreasure);
			}
		}
		return list;
	}

	public bool HasGain(int treasureId)
	{
		_idToTreasure.TryGetValue(treasureId, out var value);
		return value != null;
	}

	public Treasure GetTreasure(int treasureId)
	{
		_idToTreasure.TryGetValue(treasureId, out var value);
		return value;
	}

	public bool IsSpecialTreasure(int treasureId)
	{
		return CoreUtils.GetData(treasureId, RuntimeConfigs.data.itemTreasureDatas).functionId > 0;
	}

	public int GetCharacterIdByTreasureId(int treasureId)
	{
		return CoreUtils.GetData(treasureId, RuntimeConfigs.data.itemTreasureDatas).characterId;
	}

	public bool IsGlobalTreasure(int treasureId)
	{
		ItemTreasureData data = CoreUtils.GetData(treasureId, RuntimeConfigs.data.itemTreasureDatas);
		if (data == null)
		{
			return false;
		}
		if (data.characterId == 0)
		{
			return !IsSpecialTreasure(treasureId);
		}
		return false;
	}

	public (bool, int) IsHaveGuideID(int treasureId)
	{
		ItemTreasureData data = CoreUtils.GetData(treasureId, RuntimeConfigs.data.itemTreasureDatas);
		if (data == null)
		{
			return (false, 0);
		}
		return (data.guideId > 0, data.guideId);
	}

	public IReadOnlyList<Treasure> GetAllSpecialTreasures()
	{
		return _allSpecialTreasures;
	}
}
