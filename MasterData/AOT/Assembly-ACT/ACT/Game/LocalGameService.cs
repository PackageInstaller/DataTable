using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.UI;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.Collections;
using Fundamental;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Pb;
using UnityEngine;

namespace ACT.Game;

public class LocalGameService : IGameService
{
	protected PlayerModule m_PlayerModule;

	private long _localBloodstainId = 1L;

	private string SavePath = Application.persistentDataPath + "/PlayerDatas.data";

	private string DetailSavePath = Application.persistentDataPath + "/DetailUserDatas.data";

	private Dictionary<uint, DropItemAddNtf> m_LocalDropPackageCache = new Dictionary<uint, DropItemAddNtf>();

	private IGameService _gameServiceImplementation;

	public LocalGameService()
	{
		m_PlayerModule = new PlayerModule();
	}

	public void LoadGame()
	{
		if (File.Exists(SavePath))
		{
			using FileStream input = File.OpenRead(SavePath);
			G.localPlayer = Player.Parser.ParseFrom(input);
		}
		if (File.Exists(DetailSavePath))
		{
			using (FileStream input2 = File.OpenRead(DetailSavePath))
			{
				G.detailUserInfo = DetailUserInfo.Parser.ParseFrom(input2);
			}
		}
	}

	public void SaveGame()
	{
		using (FileStream output = File.Create(SavePath))
		{
			G.localPlayer.WriteTo(output);
		}
		using FileStream output2 = File.Create(DetailSavePath);
		G.detailUserInfo.WriteTo(output2);
	}

	public void LoadSave(LocalSave localSave)
	{
		Player player = (G.localPlayer = localSave.ToPB());
		G.detailUserInfo = localSave.ToUserPB();
		G.detailUserInfo.Profile = player.Profile;
	}

	public void RecordTmpArchivePos(SceneTempArchiveInfo info)
	{
		PlayerProfile profile = G.localPlayer.Profile;
		profile.SceneInfos[(int)profile.SceneStatus].TmpArchiveInfo = info;
	}

	public void CleanTmpArchivePos()
	{
		PlayerProfile profile = G.localPlayer.Profile;
		profile.SceneInfos[(int)profile.SceneStatus].TmpArchiveInfo = null;
	}

	public void RecordSpawnPos(SceneSpawnInfo spawnInfo)
	{
		PlayerProfile profile = G.localPlayer.Profile;
		profile.SceneInfos[(int)profile.SceneStatus].SpawnInfo = spawnInfo;
	}

	public void RecordCheckPos(int uid)
	{
		PlayerProfile profile = G.localPlayer.Profile;
		profile.SceneInfos[(int)profile.SceneStatus].CheckPosUid = uid;
	}

	public void AcceptMission(int missionId)
	{
	}

	public void FailureMission(int missionId)
	{
	}

	public void GiveUpMission(int missionId)
	{
	}

	public void SuccessMission(int missionId)
	{
	}

	public void UpdateTracingMission(int missionId)
	{
	}

	public void UpdateMissionCondition(int missionId, MissionFlowType stageType, int stageIndex, int conditionId, int progress, bool success, Action<bool> callback = null)
	{
		callback?.Invoke(obj: true);
	}

	public void UpdateMissionAction(int missionId, MissionFlowType stageType, int stageIndex, int conditionGroupIndex, int actionId, int actionType, bool success, Action<bool> callback = null)
	{
	}

	public void UpdateMissionStage(int missionId, MissionFlowType stageType, int newMissionStage, Action<IMessage> callback = null)
	{
	}

	public void ReplacTeamProfile(PresetTeam teamProfile, int index)
	{
		G.localPlayer.teamInfo.PresetTeams[index] = teamProfile;
	}

	public void CompleteMissionBluePrint(MissionState mission, int id, Action<bool> callback)
	{
		if (!mission.BluePrintIds.Contains(id))
		{
			mission.BluePrintIds.Add(id);
			SubMissionBluePrintCompleteEvt evt = Singleton<EventManager>.instance.GetEvt<SubMissionBluePrintCompleteEvt>();
			evt.subMissionId = mission.SubMissionId;
			evt.bluePrintId = id;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SubMission_BluePrintComplete, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			callback?.Invoke(obj: true);
		}
	}

	public void SendGetTempleRewards(int areaId, int rewardStarLevel, Action<bool, TempleTakeStarRewardAck> callback)
	{
		callback?.Invoke(arg1: true, null);
	}

	public void UnlockTemple(int templeId, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void EnterTempleChallenge(int templeId, TeamUsage teamUsage, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void TempleRechallenge(Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void LeaveTemple(Action<bool> callback, bool resetData)
	{
		callback?.Invoke(obj: true);
	}

	public void CompleteTempleStage(Action<RepeatedField<UniversalItem>> callback)
	{
		callback?.Invoke(null);
	}

	public void TempleFailure(Action callback)
	{
		callback?.Invoke();
	}

	public void SyncBattleTempleBuffSelection(int roomIndex, int buffId, Action<bool> callback)
	{
		callback?.Invoke(obj: false);
	}

	public void RaidFailure(Action callback)
	{
		callback?.Invoke();
	}

	public void AbyssFailure(Action callback)
	{
		callback?.Invoke();
	}

	public void EnterTrainingGround(Action<bool> callback)
	{
	}

	public void LeaveTrainingGround(Action<bool> callback)
	{
	}

	public void SendActivityGainReward(int activityId, int activitySubGroupId, int subActivityId, Action<ActivityGetLevelRewardAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendDoubleDungeonReward(int activityId, int rewardBoxId, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SendActivityCombinationReward(int activityId, int activitySubGroupId, Action<bool, ActivityCombinationRewardAck> callback)
	{
		callback?.Invoke(arg1: true, null);
	}

	public void SendActivityMainStoryReward(int activityId, int activityGroup, Action<ActivityMainStoryRewardAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendActivityMapExploreReward(int activityId, int activityGroup, Action<ActivityMapExploreRewardAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendActivityMultiDeviceReward(int activityId, int activityGroup, int activityChallenge, Action<ActivityMultiDeviceRewardAck> callback)
	{
		callback?.Invoke(null);
	}

	private uint GetDropPackageId()
	{
		uint num = 0u;
		foreach (KeyValuePair<uint, DropItemAddNtf> item in m_LocalDropPackageCache)
		{
			if (item.Key > num)
			{
				num = item.Key;
			}
		}
		return ++num;
	}

	private DropItemAddNtf GetDropItem(uint packageId)
	{
		DropItemAddNtf result = m_LocalDropPackageCache[packageId];
		m_LocalDropPackageCache.Remove(packageId);
		return result;
	}

	public void GetDropItem(List<int> dropItemUIDs, Action<DropItemPickItemAck> callback)
	{
		int activeWorldId = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
		DropItemPickItemAck dropItemPickItemAck = new DropItemPickItemAck();
		foreach (int dropItemUID in dropItemUIDs)
		{
			DropItem dropItem = G.localPlayer.Maps[activeWorldId].DropItems[dropItemUID];
			if (RuntimeConfigs.data.itemDatas[dropItem.ItemId].type > 0)
			{
				ItemNtf itemNtf = new ItemNtf
				{
					Changes = 
					{
						new Item
						{
							Id = dropItem.ItemId,
							Count = dropItem.Count
						}
					}
				};
				CoreUtils.DeltaItemNtfToItemNtf(itemNtf);
				Singleton<NetManager>.instance.LocalDispatch(3200, itemNtf);
			}
			if (!RuntimeConfigs.data.itemDatas[dropItem.ItemId].canAutoPick && G.localPlayer.Maps.TryGetValue(activeWorldId, out var value))
			{
				value.DropItems.Remove(dropItemUID);
				dropItemPickItemAck.DropRes.Add(new DropItemPickInfo
				{
					Uid = dropItemUID
				});
			}
		}
		callback?.Invoke(dropItemPickItemAck);
	}

	public void PickDropPack(uint id, Action<DropItemPickPackageAck> callback)
	{
		DropItemAddNtf dropItem = GetDropItem(id);
		DropItemPickPackageAck dropItemPickPackageAck = new DropItemPickPackageAck();
		foreach (DropItem ditem in dropItem.Ditems)
		{
			dropItemPickPackageAck.DropRes.Add(new DropItemPickInfo
			{
				Uid = ditem.Uid
			});
		}
		callback(dropItemPickPackageAck);
	}

	public void AddItem(Item itemIC)
	{
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(itemIC.Id);
		if (itemInfo == null)
		{
			G.localPlayer.Inventory.Items.Add(new Item
			{
				Id = itemIC.Id,
				Count = itemIC.Count
			});
		}
		else
		{
			itemInfo.Count += itemIC.Count;
		}
		if (!G.localPlayer.newItem.Contains(itemIC.Id))
		{
			G.localPlayer.newItem.Add(itemIC.Id);
		}
	}

	private DropItem AddDropItem(Item itemIC)
	{
		return null;
	}

	public void WeaponLevelUp(int weaponUid, List<Item> items, List<Weapon> weapons, Action<bool> callback)
	{
		Weapon weapon = G.localPlayer.Inventory.GetWeapon(weaponUid);
		int currentStageMaxLevel = weapon.CurrentStageMaxLevel;
		int lackExp = weapon.LackExp;
		int num = Mathf.Min(CoreUtils.CalculateWeaponExp(items, weapons), lackExp);
		int num2 = weapon.TotalExp + num;
		for (int i = weapon.Level + 1; i <= currentStageMaxLevel && num2 >= RuntimeConfigs.data.itemWeaponUpgrades[TableRule.GetWeaponUpGradeId(weapon.UpGradeType, i)].totalEXPRequired; i++)
		{
			weapon.Level = i;
		}
		weapon.Exp = num2 - RuntimeConfigs.data.itemWeaponUpgrades[TableRule.GetWeaponUpGradeId(weapon.UpGradeType, weapon.Level)].totalEXPRequired;
		foreach (Item item in items)
		{
			if (item.Count > 0)
			{
				G.localPlayer.Inventory.GetItemInfo(item.Id).Count -= item.Count;
			}
			else
			{
				G.localPlayer.Inventory.Items.Remove(item);
			}
		}
		foreach (Weapon weapon2 in weapons)
		{
			G.localPlayer.Inventory.Weapons.Remove(weapon2);
		}
		callback(obj: true);
	}

	public void WeaponBreak(int weaponUid, Action<bool> callback)
	{
		Weapon weapon = G.localPlayer.Inventory.GetWeapon(weaponUid);
		foreach (ItemKv item in RuntimeConfigs.data.itemWeaponBreakthroughs[TableRule.GetWeaponBreakId(weapon.WeaponId, weapon.Stage)].breakRequirement)
		{
			Item itemInfo = G.localPlayer.Inventory.GetItemInfo(item.id);
			if (itemInfo != null)
			{
				int count = item.count;
				if (count > itemInfo.Count)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError("数量不足,UI部分校验有问题？");
					}
					callback?.Invoke(obj: false);
				}
				else
				{
					itemInfo.Count -= count;
				}
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		}
		weapon.Stage++;
		callback?.Invoke(obj: true);
	}

	public void WeaponRefine(int weaponUid, int consumeWeaponUid, Action<bool> callback)
	{
		Weapon weapon = G.localPlayer.Inventory.GetWeapon(weaponUid);
		Weapon weapon2 = G.localPlayer.Inventory.GetWeapon(consumeWeaponUid);
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(consumeWeaponUid);
		if (weapon == null || weapon == weapon2 || weapon2?.GetEquiper() != null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("武器精炼有问题，UI部分校验有问题？");
			}
			callback(obj: false);
		}
		if (weapon2 != null)
		{
			G.localPlayer.Inventory.Weapons.Remove(weapon2);
		}
		else if (itemInfo != null)
		{
			itemInfo.Count--;
			if (itemInfo.Count <= 0)
			{
				G.localPlayer.Inventory.Items.Remove(itemInfo);
			}
		}
		else
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("武器精炼有问题，UI部分校验有问题？");
			}
			callback(obj: false);
		}
		weapon.Refine++;
		callback(obj: true);
	}

	public void CharacterLevelUp(int characterID, List<Item> items, Action<bool> callback)
	{
		Character character = G.localPlayer.GetCharacter(characterID);
		if (character == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("未拥有该角色");
			}
			return;
		}
		_ = RuntimeConfigs.data.entityCharacterDatas[characterID];
		int levelMax = RuntimeConfigs.data.entityCharacterLevelDatas[character.GetCharacterLevelId()].levelMax;
		int num = CoreUtils.CalculateCharacterExp(items) + RuntimeConfigs.data.entityCharacterXPDatas[character.GetCharacterXpId()].xpTotal + character.Exp;
		for (int i = character.Level; i <= levelMax; i++)
		{
			if (num >= RuntimeConfigs.data.entityCharacterXPDatas[character.GetCharacterXpId(i)].xpTotal)
			{
				character.Level = i;
				continue;
			}
			character.Exp = num - RuntimeConfigs.data.entityCharacterXPDatas[character.GetCharacterXpId()].xpTotal;
			break;
		}
		for (int j = 0; j < items.Count; j++)
		{
			G.localPlayer.Inventory.GetItemInfo(items[j].Id).Count -= items[j].Count;
		}
		callback?.Invoke(obj: true);
	}

	public void CharacterBreakThrou(int characterID, int BreakThou, Action<bool> callback)
	{
		Character character = G.localPlayer.GetCharacter(characterID);
		EntityCharacterLevelData entityCharacterLevelData = RuntimeConfigs.data.entityCharacterLevelDatas[character.GetCharacterLevelId()];
		int num = 0;
		foreach (ItemKv item in entityCharacterLevelData.breakRequirement)
		{
			int count = G.localPlayer.Inventory.GetItemInfo(item.id).Count;
			int count2 = item.count;
			if (count >= count2)
			{
				num++;
				G.localPlayer.Inventory.GetItemInfo(item.id).Count -= item.count;
				continue;
			}
			break;
		}
		if (num == entityCharacterLevelData.breakRequirement.Count)
		{
			character.Stage++;
		}
		callback?.Invoke(obj: true);
	}

	public void CharacterRefine(int characterID, Action<bool> callback)
	{
		callback(obj: true);
	}

	public void CharacterChangeWeapon(int characterId, int weaponUid, Action<bool> callback)
	{
		Character character = G.localPlayer.GetCharacter(characterId);
		int weaponUid2 = character.WeaponUid;
		Weapon weapon = G.localPlayer.Inventory.GetWeapon(weaponUid);
		int equiperID = weapon.GetEquiperID();
		if (equiperID != -1)
		{
			G.localPlayer.GetCharacter(equiperID).WeaponUid = weaponUid2;
		}
		ItemWeaponData data = CoreUtils.GetData(weapon.WeaponId, RuntimeConfigs.data.itemWeaponDatas);
		if (RuntimeConfigs.data.entityCharacterDatas[characterId].wp1Type == data.weaponType)
		{
			character.WeaponUid = weapon.Uid;
		}
		callback(obj: true);
	}

	public void WeaponLock(int weaponUid, bool locked, Action<bool> callback)
	{
		Weapon weapon = G.localPlayer.Inventory.GetWeapon(weaponUid);
		if (weapon == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Uid为" + weaponUid + "的武器不存在");
			}
		}
		else
		{
			weapon.Lock = locked;
			callback?.Invoke(obj: true);
		}
	}

	public void ChipLevelUp(int chipUid, Action<bool> callback)
	{
	}

	public void ChipDecompose(BSet<int> chips, Action<RepeatedField<Item>, bool> callback)
	{
		throw new NotImplementedException();
	}

	public void CharacterChangeChip(int characterId, int chipUid, Action<bool> callback)
	{
	}

	public void ChipCancelNewFlag(BSet<int> chipId, Action<bool> callback)
	{
		throw new NotImplementedException();
	}

	public void CharacterWearEquip(int uid, int characterId, Action<bool> callback)
	{
		throw new NotImplementedException();
	}

	public void EquipWearGem(int equipUid, int gemSlotId, bool operate, int gemUid, Action<bool> callback)
	{
		throw new NotImplementedException();
	}

	public void EquipLock(int equipUid, bool isLock, Action<bool> callback)
	{
		throw new NotImplementedException();
	}

	public void GemLock(int gemUid, bool isLock, Action<bool> callback)
	{
		throw new NotImplementedException();
	}

	public void GemFusion(List<int> gemUids, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
		throw new NotImplementedException();
	}

	public void EquipDismantle(List<int> uids, Action<bool, RepeatedField<Item>> callBack)
	{
		throw new NotImplementedException();
	}

	public void EquipEnhance(int uid, int level, Action<bool> callback)
	{
		throw new NotImplementedException();
	}

	public void EquipCreate(int id, Action<bool, RepeatedField<UniversalItem>> callback)
	{
		throw new NotImplementedException();
	}

	public void LockGem(int gemUid, bool isLock, Action<bool> callBack)
	{
		throw new NotImplementedException();
	}

	public void LockEquip(int equipUid, bool isLock, Action<bool> callBack)
	{
		throw new NotImplementedException();
	}

	public void CharacterUnloadChip(int characterId, int chipId, Action<bool> callback)
	{
		throw new NotImplementedException();
	}

	public void MakingProducts(int productId, int produceCount, Action callback)
	{
		if (G.localPlayer.Inventory.GetItemInfo(productId) != null)
		{
			G.localPlayer.Inventory.GetItemInfo(productId).Count += produceCount;
		}
		else
		{
			Item item = new Item();
			item.Id = productId;
			item.Count = produceCount;
			G.localPlayer.Inventory.Items.Add(item);
		}
		int moneyNeeded = RuntimeConfigs.data.itemRecipeDatas[productId].moneyNeeded;
		G.detailUserInfo.Attributes[2] -= moneyNeeded * produceCount;
		foreach (ItemKv item2 in RuntimeConfigs.data.itemRecipeDatas[productId].itemNeeded)
		{
			G.localPlayer.Inventory.GetItemInfo(item2.id).Count -= item2.count * produceCount;
		}
		callback?.Invoke();
	}

	public void LockChip(int chipUid, bool isLock, Action<bool> callback)
	{
		Chip chip = G.localPlayer.Inventory.GetChip(chipUid);
		if (chip == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("背包中没有该芯片，芯片id" + chipUid);
			}
		}
		else
		{
			chip.Lock = isLock;
			callback(obj: true);
		}
	}

	public void PingMessage()
	{
		PingAck pingAck = new PingAck();
		pingAck.Ts = TimeManager.LocalTime.NowTimestamp;
		TimeManager.ServerTime.SetTimestamp(pingAck.Ts);
		MonoECS.instance.ResetPingMessage(10L);
	}

	public void UnLockAssistSkinColor(int assistId, int skinId, int colorId, Action callback)
	{
		G.localPlayer.GetAssist(assistId).GetAssistSkin(skinId).Colors[colorId] = true;
		callback?.Invoke();
	}

	public void UnLockTransferPoint(int wid, int transferUId, Action callback)
	{
		callback?.Invoke();
	}

	public void UnLockLightHousePoint(int wid, int lightHouseUId, Action callback)
	{
		callback?.Invoke();
	}

	public void PlayerAddCustomMapIcon(int mapArea, int iconType, Vector3 worldPos, Action<int, int, int, Vector3> callback)
	{
	}

	public void DeleteCustomMapIcon(int id, Action callback)
	{
	}

	public void ModifyCustomMapFlagType(int mapArea, int id, int iconType, Action callback)
	{
	}

	public void MapSetupTracePoint(int mapArea, int id, int iconType, bool isCancel, Action callback = null)
	{
	}

	public void MapAreaExploreQuery(Action callback)
	{
	}

	public void MapAreaExploreReward(int areaId, int type, Action callback = null)
	{
	}

	public void BattleTeamChange(int index, Action callback)
	{
		G.localPlayer.teamInfo.MainTeamIdx = index;
		callback?.Invoke();
	}

	public void TeamCharacterChange(PresetTeam team, int index, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SaveTeamProfile(List<PresetTeam> teams, int mainTeamIndex, Action<bool> callBack)
	{
	}

	public void DyeingAssist(int assistId, int skinId, int colorId, Action callback)
	{
		callback?.Invoke();
	}

	public void AssistEquip(int assistId, Action callback)
	{
		callback?.Invoke();
	}

	public void ChangeServiceSaveState(int wid, int swid, int stateId, bool sync, MapViewRecordParam mapViewRecordParam, Action callback, ItemCheck itemCheck = default(ItemCheck))
	{
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		int num = ruleManager.SharedGetState(swid);
		ruleManager.TryGetWorldStateAsset(swid, out var _);
		bool flag = CoreUtils.TryGetServiceBehaveId(wid, swid, out var behaveId);
		if (num < 0 && LuminApplication.LogEnabled)
		{
			Debug.LogWarning("试图本地模拟执行服务器权限的状态修改!");
		}
		int stateId2 = LocalStateChangeRule(wid, swid, stateId);
		LocalChangeServiceSaveState(wid, swid, num, stateId2);
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(swid);
		bool flag2 = ((worldStateAssetDataBySGOID is MonsterPointData) ? (stateId == 1) : (worldStateAssetDataBySGOID is CollectionPointData && stateId == 1));
		bool flag3 = flag2;
		int cleanedTs = CoreUtils.UnixTimeSeconds();
		if (!flag3 && G.localPlayer.Maps.TryGetValue(wid, out var value) && value.ServiceCleanedTs.TryGetValue(swid, out var value2))
		{
			cleanedTs = value2;
		}
		Singleton<NetManager>.instance.LocalDispatch(4505, new ServiceSaveStateNtf
		{
			Wid = wid,
			Changes = 
			{
				new ServiceSaveState
				{
					Uid = swid,
					StateId = stateId2,
					BehaveId = (flag ? behaveId : 0),
					CleanedTs = cleanedTs
				}
			}
		});
		LocalStateWorldEvent evt = Singleton<EventManager>.instance.GetEvt<LocalStateWorldEvent>();
		evt.eventType = ClientEvent.Local_ServiceState_Refresh;
		evt.sourceSwid = swid;
		evt.stateId = stateId2;
		ruleManager.LocalEventDispatch(ClientEvent.Local_ServiceState_Refresh, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		callback?.Invoke();
	}

	private void LocalChangeServiceSaveState(int wid, int swid, int curStateId, int stateId)
	{
		ServiceSaveTag serviceSaveTag = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(swid).serviceSaveTag;
		if (curStateId >= 0 && stateId == 1)
		{
			switch (serviceSaveTag)
			{
			case ServiceSaveTag.Monster:
			{
				int monsterId = CoreUtils.ServiceBehaveId(wid, swid);
				uint dropPackageId2 = GetDropPackageId();
				DropItemAddNtf dropItemAddNtf2 = new DropItemAddNtf();
				m_LocalDropPackageCache.Add(dropPackageId2, dropItemAddNtf2);
				dropItemAddNtf2.PackageId = dropPackageId2;
				dropItemAddNtf2.Wid = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
				dropItemAddNtf2.DropSoureUid = swid;
				CoreUtils.DetermineActualMonsterRewards(monsterId, GameUtility.GetWorldLevelIndex(), dropItemAddNtf2.Ditems);
				if (dropItemAddNtf2.Ditems.Count != 0)
				{
					Singleton<NetManager>.instance.LocalDispatch(3702, dropItemAddNtf2);
				}
				break;
			}
			case ServiceSaveTag.Collection:
			{
				int collectionId = CoreUtils.ServiceBehaveId(wid, swid);
				uint dropPackageId = GetDropPackageId();
				DropItemAddNtf dropItemAddNtf = new DropItemAddNtf();
				m_LocalDropPackageCache.Add(dropPackageId, dropItemAddNtf);
				dropItemAddNtf.PackageId = dropPackageId;
				dropItemAddNtf.Wid = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
				dropItemAddNtf.DropSoureUid = swid;
				CoreUtils.DetermineActualCollectionRewards(collectionId, dropItemAddNtf.Ditems);
				if (dropItemAddNtf.Ditems.Count != 0)
				{
					Singleton<NetManager>.instance.LocalDispatch(3702, dropItemAddNtf);
				}
				break;
			}
			}
		}
		_ = LuminApplication.LogEnabled;
	}

	public int LocalStateChangeRule(int wid, int swid, int stateId)
	{
		return stateId;
	}

	public void ChangeServiceSaveStates(int wid, List<Pb.StateChangeInfo> stateChangeInfos, bool sync, MapViewRecordParam mapViewRecordParam, Action<bool> callback, ItemCheck itemCheck = default(ItemCheck))
	{
		foreach (Pb.StateChangeInfo stateChangeInfo in stateChangeInfos)
		{
			ChangeServiceSaveState(wid, stateChangeInfo.Uid, stateChangeInfo.StateId, sync, mapViewRecordParam, null, itemCheck);
		}
		callback?.Invoke(obj: true);
	}

	public void MapExploreCompleteRequest(int area, int chunkId = 0, Action callback = null)
	{
		callback?.Invoke();
	}

	public void TriggerCustomInteractEvent(int swid, string eventName, Action<InteractRuleResult> callback, ItemCheck itemCheck = default(ItemCheck))
	{
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		LocalStateWorldEvent evt = Singleton<EventManager>.instance.GetEvt<LocalStateWorldEvent>();
		evt.eventType = ClientEvent.Local_CustomInteractEvent;
		evt.sourceSwid = swid;
		evt.eventName = eventName;
		InteractRuleResult obj = ruleManager.LocalEventDispatch(ClientEvent.Local_CustomInteractEvent, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		callback?.Invoke(obj);
	}

	public void AchievePlayeLevelAward(int level, Action<RepeatedField<Item>> callback, bool isAll = false)
	{
		throw new NotImplementedException();
	}

	public void SystemGuideChapterReward(int chapter, Action<RepeatedField<UniversalItem>> callback)
	{
		throw new NotImplementedException();
	}

	public void CheckSystemOpen(int systemId, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SyncCharacterCharacteristic(Dictionary<int, CharacterStatus> characterStatus, int battleCharacterIndex)
	{
	}

	public void SyncGameInfoReq(SyncGameInfoReq req, Action<bool> callback)
	{
	}

	public void CreateBloodstain(BloodstainCreateRequest request, Action<bool, BloodstainData> callback)
	{
		BloodstainData arg = new BloodstainData
		{
			BloodstainId = _localBloodstainId++.ToString(),
			ChunkId = request.ChunkId,
			Position = request.Position,
			Rotation = request.Rotation,
			State = BloodstainState.Initial,
			CreateTs = DateTimeOffset.UtcNow.ToUnixTimeSeconds()
		};
		callback?.Invoke(arg1: true, arg);
	}

	public void ClaimBloodstain(string bloodstainId, Action<bool, IList<UniversalItem>> callback)
	{
		callback?.Invoke(arg1: true, Array.Empty<UniversalItem>());
	}

	public void SetBloodStainEnable(bool isEnable, Action<bool> callback)
	{
	}

	public void SceneSwitch(Vector3 pos, int chunkId, int worldId, SceneStatus sceneStatus, int areaId, Action<bool> callback = null)
	{
		callback?.Invoke(obj: true);
	}

	public void DeleteItems(int itemType, List<OperationItem> items, Action<bool> callBack)
	{
		switch (itemType)
		{
		case 0:
		{
			for (int j = 0; j < items.Count; j++)
			{
				Weapon weapon = G.localPlayer.Inventory.GetWeapon(items[j].Index);
				ItemData itemData2 = RuntimeConfigs.data.itemDatas[weapon.WeaponId];
				if (weapon != null && itemData2.canBeDelete)
				{
					G.localPlayer.Inventory.Weapons.Remove(weapon);
				}
			}
			break;
		}
		case 1:
		{
			for (int k = 0; k < items.Count; k++)
			{
				Chip chip = G.localPlayer.Inventory.GetChip(items[k].Index);
				ItemData itemData3 = RuntimeConfigs.data.itemDatas[chip.Id];
				if (chip != null && itemData3.canBeDelete)
				{
					G.localPlayer.Inventory.Chips.Remove(chip);
				}
			}
			break;
		}
		case 2:
		{
			for (int i = 0; i < items.Count; i++)
			{
				Item itemInfo = G.localPlayer.Inventory.GetItemInfo(items[i].Index);
				ItemData itemData = RuntimeConfigs.data.itemDatas[itemInfo.Id];
				if (itemInfo != null && itemData.canBeDelete)
				{
					itemInfo.Count -= items[i].Count;
					if (itemInfo.Count <= 0)
					{
						G.localPlayer.Inventory.Items.Remove(itemInfo);
					}
				}
			}
			break;
		}
		}
		callBack(obj: true);
	}

	public void ComposeItem(Item composeItem, Action<bool> callBack)
	{
	}

	public void ChangeWorldLevel(int level, Action<bool, long> callBack)
	{
	}

	public void UseItem(int itemId, int itemUid, int count, int chooseItemIndex, Action<bool, RepeatedField<Item>, RepeatedField<UniversalItem>> callBack)
	{
		throw new NotImplementedException();
	}

	public void LightMapBlock(int worldId, int Roomindex, Action callBack)
	{
		G.localPlayer.Maps[worldId].LightedMapBlocks.Add(Roomindex, value: true);
	}

	public void SkillLevelUp(int characterId, int skillGroupId, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
		G.localPlayer.GetCharacter(characterId).SkillGroupLevels[skillGroupId]++;
		callBack(arg1: true, null);
	}

	public void PowerBuyFreeDiamond(Action<int> callBack)
	{
		throw new NotImplementedException();
	}

	public void RequestPowerCount(Action<PowerInfoQueryAck> callBack)
	{
	}

	public void PowerExchangeItem(int itemId, int powerCost, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
		throw new NotImplementedException();
	}

	public void CharacterBreakReward(int characterId, int stage, Action<bool> callBack)
	{
		throw new NotImplementedException();
	}

	public void ConstellationLevelUp(int characterId, Action<bool> callBack)
	{
		callBack(obj: true);
	}

	public void ConstellationSwitch(int characterId, int stage, Action<bool> callBack)
	{
		throw new NotImplementedException();
	}

	public void CharacterUpgradeConstellation(int characterId, int constellationId, Action<bool> callBack)
	{
		throw new NotImplementedException();
	}

	public void CharacterReturnConstellation(int characterId, int constellationId, Action<bool> callBack)
	{
		throw new NotImplementedException();
	}

	public void CharacterUpdateConstellation(int characterId, RepeatedField<int> constellationIds, Action<bool, int> callBack)
	{
		throw new NotImplementedException();
	}

	public void CharacterEliteLevelUp(int characterId, int pointId, int toLevel, Action<bool> callBack)
	{
		throw new NotImplementedException();
	}

	public void CharacterEliteReset(int characterId, int pointId, int pointNode, Action<bool> callBack)
	{
		throw new NotImplementedException();
	}

	public void CharacterEliteReset(int characterId, int pointId, Action<bool> callBack)
	{
		throw new NotImplementedException();
	}

	public void DrawCard(int id, int count, Action<bool, RepeatedField<Item>> callback)
	{
		throw new NotImplementedException();
	}

	public void GetDailyReward(Action<bool, RepeatedField<Item>> callBack)
	{
		throw new NotImplementedException();
	}

	public void SceneBossChallenge(int difficultyLevel, Action<bool> callBack)
	{
		throw new NotImplementedException();
	}

	public void SceneTakeBossChallengeRewards(Action<bool, RepeatedField<Item>> callBack)
	{
		throw new NotImplementedException();
	}

	public void SceneResetChallengeBoss(Action<bool> callBack)
	{
		callBack?.Invoke(obj: true);
	}

	public void GetExtraReward(int count, Action<bool, RepeatedField<Item>> callBack)
	{
		throw new NotImplementedException();
	}

	public void ShopBuy(int id, int subShopIDx, int commodityIdx, int buyNum, Action<ShopBuyCommodityAck> callback)
	{
		throw new NotImplementedException();
	}

	public void RaidEnterInfo(int raidId, TeamUsage usage, Action<bool> callBack, bool enterByGM = false)
	{
		throw new NotImplementedException();
	}

	public void GetRaidRewardInfo(int rewardRate, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
		RepeatedField<UniversalItem> repeatedField = new RepeatedField<UniversalItem>();
		for (int i = 0; i < 3; i++)
		{
			int num = i;
			repeatedField.Add(new UniversalItem
			{
				Index = 200011 + num,
				Count = 10
			});
		}
		callBack?.Invoke(arg1: true, repeatedField);
	}

	public void RaidSweep(int raidId, int sweepCount, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
	}

	public void LeaveRaid(Action<bool> callBack)
	{
	}

	public void ParkourRaidDead(Action<bool> callBack)
	{
	}

	public void ReopenRaid(Action<bool> callBack)
	{
	}

	public void AbyssEnter(int abyssIndex, int abyssGroupId, List<TeamUsage> abyssTeamInfos, Action<bool> callBack, bool enterByGM = false)
	{
	}

	public void AbyssCompleteSubStage(int sceond, Action<bool, bool, bool, AbyssStage, RepeatedField<UniversalItem>> callBack)
	{
	}

	public void RechallengeAbyss(bool onlyCurrentLayer, Action<bool> callBack)
	{
	}

	public void ComeBackAbyss(Action<bool> callBack)
	{
	}

	public void LeaveAbyss(Action<bool> callBack)
	{
	}

	public void AbyssTaskReward(int startNum, int abyssId, int stageIndex, bool claimAll, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
	}

	public void ChangeAvatar(int avatarId, Action<bool> callBack)
	{
		G.localPlayer.Profile.EscInfo.CurAvatarId = avatarId;
		callBack(obj: true);
	}

	public void ChangeAvatarFrame(int avatarFrameId, Action<bool> callBack)
	{
		G.localPlayer.Profile.EscInfo.CurAvatarFrameId = avatarFrameId;
		callBack?.Invoke(obj: true);
	}

	public void ChangeTitle(int titleId, Action<bool> callBack)
	{
		G.localPlayer.Profile.EscInfo.CurTitleId = titleId;
		callBack?.Invoke(obj: true);
	}

	public void ChangeShowCharacter(List<int> showCharacterIds, Action<bool> callBack)
	{
		G.localPlayer.Profile.EscInfo.ShowCharacterIds.Clear();
		if (showCharacterIds != null)
		{
			G.localPlayer.Profile.EscInfo.ShowCharacterIds.AddRange(showCharacterIds);
		}
		callBack?.Invoke(obj: true);
	}

	public void ChangeNickname(string nickname, Action<bool, string, IMessage> callBack)
	{
		if (G.detailUserInfo == null)
		{
			G.detailUserInfo = new DetailUserInfo();
		}
		if (G.detailUserInfo.Brief == null)
		{
			G.detailUserInfo.Brief = new BriefUserInfo();
		}
		if (G.detailUserInfo.Brief != null)
		{
			G.detailUserInfo.Brief.Nickname = nickname;
		}
		callBack?.Invoke(arg1: true, nickname, null);
	}

	public void ChangeSignature(string signature, Action<bool, IMessage> callBack)
	{
		if (G.localPlayer?.Profile?.EscInfo != null)
		{
			G.localPlayer.Profile.EscInfo.Signature = signature;
		}
		callBack?.Invoke(arg1: true, null);
	}

	public void SaveMusic(int id)
	{
		G.localPlayer.Profile.PlayingMusic = id;
	}

	public void AchievementSyncInfoReq(AchievementSyncInfo achievementSyncInfo, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void ReceiveAchievementReward(int id, Action<bool, RepeatedField<Item>> callback)
	{
		callback?.Invoke(arg1: true, null);
	}

	public void ReceiveAchievementGroupReward(int id, Action<bool, RepeatedField<Item>> callback)
	{
		callback?.Invoke(arg1: true, null);
	}

	public void AchievementComplete(int id, Action<bool, int> callback)
	{
		callback?.Invoke(arg1: true, 0);
	}

	public void AchievementChange(int id, AchievementTag tag, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SendConversationKeyPoint(List<int> ids, Action<bool> callback)
	{
		callback?.Invoke(obj: false);
	}

	public void ClearConversationKeyPoints(List<int> ids, Action<bool> callback)
	{
		callback?.Invoke(obj: false);
	}

	public void DestroyAccount(Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SaveSettingOptions(string json, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void GuideFinish(int guideListId, int step, Action<bool> callback)
	{
		G.localPlayer.InterfaceGuide.TryAdd(guideListId, step);
		callback?.Invoke(obj: false);
	}

	public void SendGuideUnlock(int guideId, Action<GuideUnlockAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendGuideComplete(int guideId, Action<GuideCompleteAck> callback)
	{
		callback?.Invoke(null);
	}

	public void TriggerTutorial(int tutorialId, Action<bool> callback)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GUIDEIMAGEVIDEO, new GuideImageVideoViewData
		{
			tutorialId = tutorialId
		});
	}

	public void ReadTutorial(List<int> tutorialIds, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SendConversationRecordOptions(Dictionary<int, int> keyValues, Action<bool> callback)
	{
		MapField<int, int> conversationOptionInfo = G.localPlayer.Achievements.Info.ConversationOptionInfo;
		foreach (KeyValuePair<int, int> keyValue in keyValues)
		{
			conversationOptionInfo[keyValue.Key] = keyValue.Value;
		}
	}

	public void SendUnLockMonster(int type, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SendKillMonsterNum(int type, Action<HandbookUpdateAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendUnLockWildBoss(int monsterPointId, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SendUseLittleItem(int itemId, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void TriggerTeleportPoint(Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SyncBloodBottleLevelUp(int bottleId, int toLevel, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void UpdateBottleMaterials(int bottleId, List<int> matId, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SendUseBloodBottle(Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void RecoverBottleUseCount(int targetCount, Action<int> callback)
	{
		callback?.Invoke(-1);
	}

	public void RefreshRedDot(RedPoints redPoints, Action<bool> callback)
	{
		throw new NotImplementedException();
	}

	public void SyncLittleItems(LittleItemsShortcutInfo info, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SendCreateCharacter(string type, int gender, Action<CreateUserAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendUnLockMonster(string type, int gender, Action<bool> callback)
	{
	}

	public void LogPlayerExplorePos(string area, string layer, Vector2 playerWorldPos, Action<bool, string, string, Vector2> callback)
	{
		callback?.Invoke(arg1: false, area, layer, playerWorldPos);
	}

	public void LayerExploreComplete(string area, string layer, Action<bool> callback)
	{
		callback?.Invoke(obj: false);
	}

	public void SetNetState(IGameService.NetState state)
	{
	}

	public void SendRogueChallenge(int modeId, int coreId, TeamUsage battleCharacter, long seed, Action<RogueChallengeAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRogueEnterRoom(int gameworldId, Action<RogueEnterRoomAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRogueEnterNextRoom(RogueRoomType type, Dictionary<int, ACT.Game.Data.RogueItem> roguebag, Dictionary<int, int> battleInfo, Dictionary<int, int> abilityUsage, Action<RogueEnterNextRoomAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRogueGmNextRoom(RogueRoomType type, Action<RogueGmNextRoomAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRogueBuyItem(bool isbuy, int itemid, Action<RogueBuyItemAck> callback, bool isReplace = false, int ReplacePosition = 0)
	{
		callback?.Invoke(null);
	}

	public void SendRogueBuyGmItem(int itemid, Action<RogueGmAddItemAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRogueCoinReward(Action<RogueCoinRewardAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRecycleItem(int itemId, Action<RogueRecycleItemAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRoguePickUpItem(int itemId, bool isReplace, int replacePosition, Action<RoguePickUpItemAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRogueSetRoomFinished(Action<RogueSetRoomFinishedAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRogueHangGame(Action<RogueHangGameAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRogueContinueGame(Action<RogueContinueGameAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendRogueFinishGame(RogueFinishType finishType, Action<RogueFinishGameAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendUpgradeTalentNode(int nodeId, Action<RogueUpdateTalentTreeNodeAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendAssistNpcHelp(int npcId, int wid, Action<bool> callback)
	{
		AssistantNpcNtf assistantNpcNtf = new AssistantNpcNtf();
		assistantNpcNtf.Npcs.AddRange(G.localPlayer.AssistantSystem.Npcs);
		if (assistantNpcNtf.Npcs.All((AssistantNpc x) => x.Id != npcId))
		{
			assistantNpcNtf.Npcs.Add(new AssistantNpc
			{
				Id = npcId
			});
		}
		Singleton<NetManager>.instance.LocalDispatch(6500, assistantNpcNtf);
	}

	public void SendAssistNpcFinish(int npcId, Action<bool> callback)
	{
		AssistantNpcNtf assistantNpcNtf = new AssistantNpcNtf();
		assistantNpcNtf.Npcs.AddRange(G.localPlayer.AssistantSystem.Npcs);
		for (int num = assistantNpcNtf.Npcs.Count - 1; num >= 0; num--)
		{
			if (assistantNpcNtf.Npcs[num].Id == npcId)
			{
				assistantNpcNtf.Npcs.RemoveAt(num);
				break;
			}
		}
		Singleton<NetManager>.instance.LocalDispatch(6500, assistantNpcNtf);
	}

	public void ContactChooseOption(int sessionId, int chooseIdx, Action<bool> callback)
	{
		callback?.Invoke(obj: false);
	}

	public void SendGachaCardDraw(int gachaid, int count, Action<GachaCardDrawAck> callback, bool Beginner = false)
	{
		callback?.Invoke(null);
	}

	public void SendGachaQueryHistory(GachaPoolType poolType, int page, Action<GachaQueryHistoryAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendGachaExchangeFinalGuaranteed(int poolid, int gachaitemid, Action<GachaExchangeFinalGuaranteedAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendGachaTargetSelect(int gachaId, int targetGachaItemId, Action<GachaTargetSelectAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendGachaTargetCancel(int gachaId, Action<GachaTargetCancelAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendGaChaExchangeMilestoneReward(int poolId, Action<GachaExchangeMilestoneRewardAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendGachaExchangeTicket(int poolid, int num, Action<GachaExchangeTicketAck> callback)
	{
	}

	public void ResetScrollBattleReq(int id, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void RequestActivitySignInChooseReward(int activityId, int groupId, int challengeId, int rewards, Action<ActivitySignInChooseRewardAck> callBack)
	{
		callBack?.Invoke(null);
	}

	public void RequestActivitySignInReward(int activityId, int groupId, int challengeId, Action<ActivitySignInRewardAck> callBack)
	{
		callBack?.Invoke(null);
	}

	public void RequestActivityAbyssReward(int activityId, int activityGroup, int activityChallenge, Action<ActivityAbyssRewardAck> callBack)
	{
		callBack?.Invoke(null);
	}

	public void RequestActivityRefresh(Action<ActivityRefreshAck> callBack)
	{
		callBack?.Invoke(null);
	}

	public void QuestionnaireRead(int id)
	{
	}

	public void SwitchTempArchiveUpdateReq(TempArchiveOperation operation, SyncGameInfoReq syncData, Action<bool> callback)
	{
	}

	public void SendOrder(int goodsId, int subShopId = 0, bool isRetry = false, Action<bool, CreatOrderAck> callback = null)
	{
	}

	public void ExchangeFreeDiamond(int num, Action<bool> callback = null)
	{
	}

	public void ExchangeCommodity(int subShopId, int commodityId, Action<bool, List<Item>> callback = null, List<int> selectedIndex = null)
	{
	}

	public void OrderShipDisplay(string orderId, Action<bool> isSuccess = null)
	{
		isSuccess?.Invoke(obj: true);
	}

	public void SendWorldLevelBreakReq(Action<bool, IList<UniversalItem>> callback)
	{
	}

	public void SendHandbookDailyMissionClaimReward(int rowID, Action<bool, List<Item>> callback)
	{
	}

	public void SendHandbookDailyActivePtClaimReward(Action<bool, List<Item>> callback = null)
	{
	}

	public void BattlePassBuyLevelReq(int buyCount, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void BattlePassClaimTaskReq(int taskGroupId, int taskId, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void BattlePassClaimRewardReq(int level, bool isPremium, Action<bool, RepeatedField<UniversalItem>> callback)
	{
		callback?.Invoke(arg1: true, null);
	}

	public void SendUnlockTextLibraryReq(List<int> unlockIds, Action<VocabularyUnlockContentAck, bool> callBack)
	{
		callBack?.Invoke(null, arg2: true);
	}

	public void SendTextLibraryReadReq(List<int> textLibraryIds, Action<bool> callBack)
	{
		callBack?.Invoke(obj: true);
	}

	public void SendTextLibraryGroupState(Dictionary<int, bool> syncGoup, Action<bool> callBack)
	{
		callBack?.Invoke(obj: true);
	}

	public void SendOpenPackageGift(int packageGiftId, int openCount, Action<List<UniversalItem>, bool> callback, int selfSelectItemIndex = 0)
	{
		callback?.Invoke(null, arg2: true);
	}

	public void SubmitDivineEye(int exploreAreaId, int submitCount, Action<bool, List<UniversalItem>> callback)
	{
		callback?.Invoke(arg1: true, null);
	}

	public void RewardDivineEye(int exploreAreaId, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void AddMapSelfNode(int mapArea, int iconType, Vector3 worldPos, Action<int, int, int, Vector3> callback)
	{
	}

	public void DeleteMapSelfNode(int id, Action<int> callback)
	{
	}

	public void RecycleItemsReq(RepeatedField<UniversalItem> universalItems, Action<RecycleItemsAck> callback)
	{
	}

	public void UpdateUsageTeam(int scene, TeamUsage usage, Action<bool> callback)
	{
	}

	public void ActivityRoleTrialRewardReq(int activityId, int activityGroup, int activityChallenge, Action<ActivityRoleTrialRewardAck> callback)
	{
	}

	public void SendActivityDailyLotteryGachaReq(int activityID, int lotteryPoolID, Action<ActivityDailyLotteryGachaAck> callback)
	{
	}

	public void SendActivityKujiRewardReq(int activityId, int activityGroup, Action<ActivityKujiRewardAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendActivityKujiDrawReq(int activityId, Action<ActivityKujiDrawAck> callback)
	{
		callback?.Invoke(null);
	}

	public void SendAwardChapterReward(int chapterId, Action<HandbookGrowthGuideChapterClaimRewardAck, bool> callback)
	{
	}

	public void SendAwardTargetGuideMissionReward(int missionGroupId, int chapterId, Action<HandbookGrowthGuideMissionClaimRewardAck, bool> callback)
	{
	}

	public void SendRedeemCodeUseReq(string code, Action<RedeemCodeUseAck, bool, IMessage> callback)
	{
	}

	public void RequestEnterLounge(Action<IMessage> callback)
	{
		callback?.Invoke(new LoungeEnterAck());
	}

	public void SendChangeGender(int gender, Action<ChangeGenderAck> callback)
	{
		callback?.Invoke(new ChangeGenderAck());
	}

	public void SendAchievementRewardReq(int groupId, Action<AchievementRewardAck> callback)
	{
	}

	public void SendAchievementGroupRewardReq(int groupId, Action<AchievementGroupRewardAck> callback)
	{
	}

	public void WildBossTakeRewardReq(int wildBossCollectionUid, Action<bool, RepeatedField<UniversalItem>> callback)
	{
		callback?.Invoke(arg1: true, null);
	}

	public void WildBossRewardBoughtReq(int buyCont, Action<bool> callback)
	{
		callback?.Invoke(obj: true);
	}

	public void SendChangeSkinReq(int roleId, int skinId, Action<ChangeSkinAck> callback)
	{
		callback?.Invoke(new ChangeSkinAck());
	}

	public void SendChangeEffectDressReq(int roleId, int effectDressId, bool wear, Action<ChangeEffectDressAck> callback)
	{
		callback?.Invoke(new ChangeEffectDressAck
		{
			CharacterId = roleId,
			EffectDressId = (wear ? effectDressId : 0)
		});
	}

	public void SendMonthlyPassRecordPopReq(int passId, long PopTimeUnix, Action<MonthlyPassRecordPopAck> callback)
	{
		callback?.Invoke(new MonthlyPassRecordPopAck());
	}

	public void SendActivitySkinTrialRewardReq(int activityId, int activityChallengeGroupId, int activityChallengeId, Action<ActivitySkinTrialRewardAck> callback)
	{
		callback?.Invoke(new ActivitySkinTrialRewardAck());
	}

	public void SendActivityTotalRechargeRewardReq(int activityId, int activityGroup, Action<ActivityTotalRechargeRewardAck> callback)
	{
		callback?.Invoke(new ActivityTotalRechargeRewardAck());
	}
}
