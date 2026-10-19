using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.CharacterProperty;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Net;
using ACT.UI;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Pb;
using Runtime.Model;
using Runtime.Utility;
using UnityEngine;

namespace ACT;

internal class RogueWorld : WorldBase
{
	internal override SceneStatus SceneStatus => SceneStatus.Rogue;

	private int _rogueId => Model<RoGueModel>.Interface.CurrentRogueStage?.id ?? 0;

	internal override void InitWorldData(WorldData data)
	{
		_worldData = data;
		RogueGameInfo gameInfo = Model<RogueNewModel>.Interface.Info.GameInfo;
		_worldData.WorldID = gameInfo.RoomInfo.GameWorldId;
		GameWorld data2 = CoreUtils.GetData(_worldData.WorldID, RuntimeConfigs.data.gameWorlds);
		if (data2 != null)
		{
			_worldData.WorldConfigId = data2.config;
		}
		_worldData.UseWorldSpawnPosition = true;
		_worldData.SpawnPosition = GetLastPos();
		_worldData.TeamInfo = G.localPlayer.teamInfo.Teams[(int)SceneStatus].Teams[0];
	}

	internal override void UninitWorldData()
	{
		Model<RoGueModel>.Interface.ReSet();
	}

	internal override void Update()
	{
	}

	internal override Character GetCharacter(int characterId)
	{
		return G.localPlayer.GetCharacter(characterId);
	}

	internal override void OnCharacterDie(Entity beahve)
	{
		if (beahve == MonoECS.instance.mainEntity && Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.DieAnimationEnd)
		{
			Singleton<GameState>.instance.SetPlayerAliveState(PlayerLiveState.DieAnimationEnd);
		}
	}

	protected override void AddListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AllCharacterDieEnd, AllCharacterDie);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnSpawnMonsterDataPart, OnSpawnMonsterDataPart);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueAddItem, OnAddRogueItem);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueRemoveItem, OnRemoveRogueItem);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_RoomStateChange, OnRoomStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_MonoLoaderEnd, OnMonoLoaderEnd);
	}

	private void OnMonoLoaderEnd(BaseEventContent obj)
	{
		RogueMode data = CoreUtils.GetData(Model<RogueNewModel>.Interface.Info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes);
		if (data != null)
		{
			GameUtility.OpenToolTip(Model<RogueNewModel>.Interface.Info.GameInfo.Index + 1 + "-" + data.mapNodeList.Length);
		}
	}

	protected override void RemoveListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AllCharacterDieEnd, AllCharacterDie);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnSpawnMonsterDataPart, OnSpawnMonsterDataPart);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueAddItem, OnAddRogueItem);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueRemoveItem, OnRemoveRogueItem);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_RoomStateChange, OnRoomStateChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_MonoLoaderEnd, OnMonoLoaderEnd);
	}

	private void OnRoomStateChange(BaseEventContent evt)
	{
		if (evt is RogueRoomStateChangeEvent { nextState: RogueNewModel.RogueRoomState.RogueEnd })
		{
			Model<RogueNewModel>.Interface.SendRogueFinishGame(RogueFinishType.Pass, async (RogueFinishGameAck ack) =>
			{
				await GameUtility.PlaySettlementPreformance(GameLoader.raidPerformanceConfig);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueOpenSettlement, null);
			});
		}
	}

	protected override async void OnFail()
	{
		Model<RogueNewModel>.Interface.SendRogueFinishGame(RogueFinishType.Dead);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueOpenSettlement, null);
		WorldChallengeState = WorldChallengeState.Normal;
	}

	private static void SyncBagCharacterSkins(List<Character> characters)
	{
		foreach (Character character2 in characters)
		{
			if (CharacterDataHelper.TryGetBagCharacterById(character2.Id, out var character))
			{
				character2.SkinId = character.SkinId;
				character2.EffectDressId = character.EffectDressId;
			}
		}
	}

	protected override async UniTask OnBeforeEnterWorld()
	{
		AddTalentSystemProperties();
		await UniTask.CompletedTask;
	}

	private void AddTalentSystemProperties()
	{
		if (_worldData?.TeamInfo == null)
		{
			return;
		}
		List<Character> allCharactersByTeamInfo = CharacterDataHelper.GetAllCharactersByTeamInfo(SceneStatus, _worldData.TeamInfo);
		SyncBagCharacterSkins(allCharactersByTeamInfo);
		int battleCharacterIdx = _worldData.TeamInfo.BattleCharacterIdx;
		if ((uint)battleCharacterIdx >= (uint)allCharactersByTeamInfo.Count)
		{
			return;
		}
		Character character = allCharactersByTeamInfo[battleCharacterIdx];
		if (character?.systemProperty == null)
		{
			return;
		}
		Dictionary<int, float> dictionary = DictionaryPool<int, float>.Get();
		try
		{
			MapField<int, RogueTalentTreeNode> mapField = Model<RogueNewModel>.Interface.Info?.TalentTree?.Nodes;
			if (mapField != null)
			{
				foreach (RogueTalentTreeNode value2 in mapField.Values)
				{
					if (value2 == null || value2.Level <= 0)
					{
						continue;
					}
					TalentNodeLevelData talentNodeLevelDataByLevel = Model<RogueNewModel>.Interface.GetTalentNodeLevelDataByLevel(value2.NodeId, value2.Level);
					if (talentNodeLevelDataByLevel?.propertyBonus == null)
					{
						continue;
					}
					foreach (Properties propertyBonu in talentNodeLevelDataByLevel.propertyBonus)
					{
						if (propertyBonu != null)
						{
							dictionary.TryGetValue(propertyBonu.property, out var value);
							dictionary[propertyBonu.property] = value + propertyBonu.value;
						}
					}
				}
			}
			character.systemProperty.ClearSystemPropertiesBySource(SystemPropertySource.RogueTalentNode);
			if (dictionary.Count > 0)
			{
				character.systemProperty.ReplaceSystemProperties(dictionary, SystemPropertySource.RogueTalentNode);
				character.DisPatchSystemPropertiesChange(character, dictionary, 7);
			}
		}
		finally
		{
			DictionaryPool<int, float>.Release(dictionary);
		}
	}

	protected override async UniTask OnAfterEnterWorld()
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_Enter, null);
		ReportOnRogueStart();
		OpenTip();
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsValid)
		{
			mainEntity.GetCompAbility().RefreshRogueAbility();
		}
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtRogueRoomEnter evt = abilitySystem.GetEvt<EvtRogueRoomEnter>(mainEntity, null);
		evt.mainEntity = mainEntity;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
	}

	private void OpenTip()
	{
		OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
		evt.position = UIPosition.UpperMiddle;
		evt.type = HudComponentType.RegionNameTip;
		evt.priorityInQueue = 3;
		RogueMode data = CoreUtils.GetData(Model<RogueNewModel>.Interface.Info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes);
		string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.name);
		string areaName = Model<RogueNewModel>.Interface.Info.GameInfo.Index + 1 + "-" + data.mapNodeList.Length;
		evt.uiData = new RegionNameTipData(localizeString, areaName, "", default, 1);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	protected override Vector3 GetLastPos()
	{
		Vector3 vector = Vector3.zero;
		if (_worldData.IsReconnect)
		{
			vector = G.localPlayer.GetLastPos(SceneStatus.Rogue);
			if (vector == Vector3.zero)
			{
				_worldData.UseWorldSpawnPosition = true;
			}
		}
		else
		{
			_worldData.UseWorldSpawnPosition = true;
		}
		return vector;
	}

	protected override async UniTask OnBeforeLeaveWorld()
	{
		bool isFail = Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.Normal;
		bool giveUp = (Singleton<GameState>.instance.WorldLoadState & WorldLoadState.GiveUp) > WorldLoadState.None;
		ReportOnRogueLeave(isFail, giveUp);
		MonoECS.instance.IsLoadSubScene = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_Exit, null);
	}

	protected override async UniTask OnBeforeReopenWorld()
	{
		bool needRespawn = Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.Normal;
		ReportOnRogueRestart(needRespawn);
	}

	protected override async UniTask OnAfterReopenWorld()
	{
		ReportOnRogueStart();
	}

	private void ReportOnRogueStart()
	{
	}

	private void ReportOnRogueLeave(bool isFail, bool giveUp)
	{
	}

	private void ReportOnRogueRestart(bool needRespawn)
	{
	}

	private void AllCharacterDie(BaseEventContent evt)
	{
		WorldChallengeState = WorldChallengeState.Fail;
	}

	private void OnSpawnMonsterDataPart(BaseEventContent evt)
	{
		if (!(evt is SpawnMonsterDataPartEvt spawnMonsterDataPartEvt) || CoreUtils.GetData(Model<RogueNewModel>.Interface.Info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes) == null)
		{
			return;
		}
		int rogueMapnode = GameUtility.GetRogueMapnode();
		if (!RuntimeConfigs.data.mapNodeConfigs.TryGetValue(rogueMapnode, out var value))
		{
			return;
		}
		Entity entityBehave = spawnMonsterDataPartEvt.entityBehave;
		EntityType entityType = entityBehave.GetEntityType();
		EntityType entityType2 = entityBehave.GetEntityType();
		if (entityType2 != EntityType.Monster && entityType2 != EntityType.Elite && entityType2 != EntityType.Boss)
		{
			return;
		}
		CompMonster compMonster = entityBehave.GetCompMonster();
		if (compMonster == null)
		{
			return;
		}
		List<PropertiesMulti> list = ((entityType != EntityType.Monster && entityType != EntityType.Elite) ? value.bossPropertyFactor : value.elitePropertyFactor);
		List<PropertiesMulti> list2 = new List<PropertiesMulti>();
		foreach (PropertiesMulti item in list)
		{
			list2.Add(new PropertiesMulti(item.property, Mathf.Clamp(item.multi - 1f, 0f, item.multi - 1f)));
		}
		List<Properties> list3 = new List<Properties>();
		foreach (PropertiesMulti item2 in list2)
		{
			float value2 = CoreUtils.s_PropertyCal[item2.property];
			list3.Add(new Properties(item2.property, value2));
		}
		CoreUtils.StartPropertyCal();
		CoreUtils.AddProperties(list3, list2);
		CompAbility? compAbility = entityBehave.GetCompAbility();
		compAbility.PushProperties(CoreUtils.s_PropertyCal, needCal: false, PropertySource.Rogue, compMonster.id);
		compAbility.CalAllProperty();
	}

	private void OnAddRogueItem(BaseEventContent evt)
	{
		if (!(evt is RogueAddItemEvent rogueAddItemEvent))
		{
			return;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsValid)
		{
			CompAbility compAbility = mainEntity.GetCompAbility();
			compAbility.AddRogueElementAbility(rogueAddItemEvent.RogueBagItem.RogueItem.ItemId);
			if (rogueAddItemEvent.RogueBagItem.RogueItemType == 3)
			{
				compAbility.AddRogueItemAbility(rogueAddItemEvent.RogueBagItem.RogueItem.ItemId);
			}
		}
		if (rogueAddItemEvent.RogueBagItem.RogueItemType == 2)
		{
			RefreshAssistCharacters();
		}
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtAddRogueItem evt2 = abilitySystem.GetEvt<EvtAddRogueItem>(mainEntity, null);
		evt2.mainEntity = mainEntity;
		evt2.itemId = rogueAddItemEvent.RogueBagItem.RogueItem.ItemId;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
	}

	private void OnRemoveRogueItem(BaseEventContent evt)
	{
		if (!(evt is RogueRemoveItemEvent rogueRemoveItemEvent))
		{
			return;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsValid)
		{
			CompAbility compAbility = mainEntity.GetCompAbility();
			compAbility.RemoveRogueElementAbility(rogueRemoveItemEvent.RogueBagItem.RogueItem.ItemId);
			if (rogueRemoveItemEvent.RogueBagItem.RogueItemType == 3)
			{
				compAbility.RemoveRogueItemAbility(rogueRemoveItemEvent.RogueBagItem.RogueItem.ItemId);
			}
		}
		if (rogueRemoveItemEvent.RogueBagItem.RogueItemType == 2)
		{
			RefreshAssistCharacters();
		}
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtRemoveRogueItem evt2 = abilitySystem.GetEvt<EvtRemoveRogueItem>(mainEntity, null);
		evt2.mainEntity = mainEntity;
		evt2.itemId = rogueRemoveItemEvent.RogueBagItem.RogueItem.ItemId;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
	}

	private void RefreshAssistCharacters()
	{
		RogueTeamChangeReq rogueTeamChangeReq = new RogueTeamChangeReq();
		TeamUsage rogueTeamInfo = new TeamUsage();
		List<RogueBagItemData> bagData = Model<RogueNewModel>.Interface.GetRogueBagByType(2);
		foreach (int item in (from id in bagData.Select((RogueBagItemData b) => b.RogueItem.ItemId).ToList()
			orderby bagData.FirstOrDefault((RogueBagItemData b) => b.RogueItem.ItemId == id)?.RogueItem.Position ?? int.MaxValue
			select id).ToList())
		{
			RogueAssistCharacter data = CoreUtils.GetData(item, RuntimeConfigs.data.rogueAssistCharacters);
			if (data != null)
			{
				rogueTeamInfo.CharacterUsage.Add(new TeamCharacterUsage
				{
					CharacterId = data.entityCharacterDataId,
					IsTrial = true
				});
			}
		}
		rogueTeamChangeReq.Team = rogueTeamInfo;
		Singleton<NetManager>.instance.Request(rogueTeamChangeReq, async (IMessage msg) =>
		{
			if (msg is RogueTeamChangeAck rogueTeamChangeAck)
			{
				SceneStatus sceneStatus = SceneStatus;
				List<Character> curTeamCharacters = CharacterDataHelper.GetCurTeamCharacters();
				CharacterRepository curCharacterRepository = CharacterDataHelper.GetCurCharacterRepository();
				CharacterDataHelper.MergeCharacterDictionary((int)sceneStatus, isExtraCharacter: true, curCharacterRepository.ExtraCharacters, rogueTeamChangeAck.RogueTeam.ExtraCharacters, removeExcess: true);
				CharacterDependHelper.MergePresenceCharacterDependDictionary(curCharacterRepository.ExtraCharacters, curCharacterRepository.CharacterDependSnapshot, curCharacterRepository.ExtraCharacterDependSnapshot.EquipSnapshot, rogueTeamChangeAck.RogueTeam.ExtraCharacterDependSnapshot?.EquipSnapshot, removeExcess: true);
				CharacterDependHelper.MergePresenceCharacterDependDictionary(curCharacterRepository.ExtraCharacters, curCharacterRepository.CharacterDependSnapshot, curCharacterRepository.ExtraCharacterDependSnapshot.GemSnapshot, rogueTeamChangeAck.RogueTeam.ExtraCharacterDependSnapshot?.GemSnapshot, removeExcess: true);
				_worldData.TeamInfo.ExtraCharacterIds.Clear();
				foreach (TeamCharacterUsage item2 in rogueTeamInfo.CharacterUsage)
				{
					int characterId = item2.CharacterId;
					EntityCharacterProbation entityCharacterProbation = RuntimeConfigs.data.entityCharacterProbations[characterId];
					if (!_worldData.TeamInfo.ExtraCharacterIds.Contains(entityCharacterProbation.characterId))
					{
						_worldData.TeamInfo.ExtraCharacterIds.Add(entityCharacterProbation.characterId);
					}
				}
				List<Character> curTeamCharacters2 = CharacterDataHelper.GetCurTeamCharacters();
				BattleTeamCharactersLocalChange(curTeamCharacters, curTeamCharacters2).Forget();
			}
		});
	}

	public async UniTask BattleTeamCharactersLocalChange(List<Character> before, List<Character> after, bool loadSave = false)
	{
		while (before.Count < BattleConsts.TEAMCAPITAL)
		{
			before.Add(null);
		}
		while (after.Count < BattleConsts.TEAMCAPITAL)
		{
			after.Add(null);
		}
		Vector3 pos = MonoECS.instance.mainEntity.GetRootTransform().position;
		WorldManager worldMgr = Singleton<GameManager>.instance.worldManager;
		for (int i = 0; i < 3; i++)
		{
			if (before[i] != null && !after.Contains(before[i]))
			{
				await worldMgr.RemoveTeamCharacter(before[i]);
			}
		}
		int battleIndex = 0;
		for (int i = 0; i < 3; i++)
		{
			Character character = after[i];
			if (character != null && character.Id != 0 && !before.Contains(character))
			{
				await worldMgr.SpawnTeamCharacter(character, i, battleIndex, isLeft: true, pos, loadSave);
				if (EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
				{
					entity.GetCompAbility().InitRogueDummyAbility();
				}
			}
		}
		EntityId[] array = new EntityId[BattleConsts.TEAMCAPITAL];
		for (int j = 0; j < array.Length; j++)
		{
			Character character2 = after[j];
			array[j] = ((character2 != null && EntityHelper.TryGetBattleEntityByCharacter(character2, out var entity2)) ? entity2.Id : EntityId.Invalid);
		}
		MPPlayer.local.SetTeamCharacters(array, battleIndex, after);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_Refresh, null);
	}

	private async System.Threading.Tasks.Task PrecacheAssistCharacters()
	{
		List<int> list = new List<int>();
		foreach (RogueAssistCharacter value2 in RuntimeConfigs.data.rogueAssistCharacters.Values)
		{
			int characterId = value2.characterId;
			if (!list.Contains(characterId))
			{
				list.Add(characterId);
			}
		}
		foreach (int item in list)
		{
			if (RuntimeConfigs.data.entityCharacterDatas.TryGetValue(item, out var value))
			{
				string config = value.config;
				AssetLoadHandle handle = AssetStationManager.BattleStation.LoadAsync<ConfigCharacter>(config);
				await handle;
				PrecacheUtility.Preload<YooAssetReference>(handle.As<ConfigCharacter>().Precache);
			}
		}
	}

	private async System.Threading.Tasks.Task ReleaseAssistCharacters()
	{
		List<int> list = new List<int>();
		foreach (RogueAssistCharacter value2 in RuntimeConfigs.data.rogueAssistCharacters.Values)
		{
			int characterId = value2.characterId;
			if (!list.Contains(characterId))
			{
				list.Add(characterId);
			}
		}
		foreach (int item in list)
		{
			if (RuntimeConfigs.data.entityCharacterDatas.TryGetValue(item, out var value))
			{
				string config = value.config;
				AssetLoadHandle handle = AssetStationManager.BattleStation.LoadAsync<ConfigCharacter>(config);
				await handle;
				PrecacheUtility.ReleasePreload<YooAssetReference>(handle.As<ConfigCharacter>().Precache);
			}
		}
	}
}
