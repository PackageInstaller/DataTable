using System;
using System.Collections.Generic;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.Collections;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Pb;
using UnityEngine;

namespace ACT.Game;

public interface IGameService
{
	public enum NetState
	{
		Disconnect,
		Connect,
		Reconnet
	}

	void SetNetState(NetState state);

	void RecordTmpArchivePos(SceneTempArchiveInfo info);

	void CleanTmpArchivePos();

	void RecordSpawnPos(SceneSpawnInfo spawnInfo);

	void RecordCheckPos(int position);

	void AcceptMission(int missionId);

	void FailureMission(int missionId);

	void GiveUpMission(int missionId);

	void SuccessMission(int missionId);

	void UpdateTracingMission(int missionId);

	void UpdateMissionCondition(int missionId, MissionFlowType stageType, int stageIndex, int conditionId, int progress, bool success, Action<bool> callback = null);

	void UpdateMissionAction(int missionId, MissionFlowType stageType, int stageIndex, int conditionGroupIndex, int actionId, int actionType, bool success, Action<bool> callback = null);

	void UpdateMissionStage(int missionId, MissionFlowType stageType, int newMissionStage, Action<IMessage> callback = null);

	void GetDropItem(List<int> dropItemUIDs, Action<DropItemPickItemAck> callback);

	void PickDropPack(uint id, Action<DropItemPickPackageAck> callback);

	void CharacterLevelUp(int characterID, List<Item> items, Action<bool> callback);

	void CharacterBreakThrou(int characterID, int BreakThou, Action<bool> callback);

	void CharacterRefine(int characterID, Action<bool> callback);

	void WeaponLevelUp(int weaponUid, List<Item> items, List<Weapon> weapons, Action<bool> callback);

	void WeaponBreak(int weaponUid, Action<bool> callback);

	void WeaponRefine(int weaponUid, int consumeWeaponUid, Action<bool> callback);

	void CharacterChangeWeapon(int characterId, int weaponUid, Action<bool> callbak);

	void WeaponLock(int weaponUid, bool locked, Action<bool> callback);

	void ChipLevelUp(int chipUid, Action<bool> callback);

	void ChipDecompose(BSet<int> chips, Action<RepeatedField<Item>, bool> callback);

	void CharacterChangeChip(int characterId, int chipId, Action<bool> callback);

	void ChipCancelNewFlag(BSet<int> chipId, Action<bool> callback);

	void CharacterWearEquip(int uid, int characterId, Action<bool> callback);

	void EquipWearGem(int equipUid, int gemSlotId, bool operate, int gemUid, Action<bool> callback);

	void GemFusion(List<int> gemUids, Action<bool, RepeatedField<UniversalItem>> callback);

	void EquipDismantle(List<int> uids, Action<bool, RepeatedField<Item>> callback);

	void EquipEnhance(int uid, int level, Action<bool> callback);

	void EquipCreate(int id, Action<bool, RepeatedField<UniversalItem>> callback);

	void LockGem(int gemUid, bool isLock, Action<bool> callback);

	void LockEquip(int equipUid, bool isLock, Action<bool> callback);

	void CharacterUnloadChip(int characterId, int chipId, Action<bool> callback);

	void MakingProducts(int productId, int productCount, Action callback);

	void LockChip(int chipUid, bool isLock, Action<bool> callBack);

	void PingMessage();

	void UnLockAssistSkinColor(int assistId, int skinId, int colorId, Action callback);

	void PlayerAddCustomMapIcon(int mapArea, int iconType, Vector3 worldPos, Action<int, int, int, Vector3> callback);

	void DeleteCustomMapIcon(int id, Action callback);

	void ModifyCustomMapFlagType(int mapArea, int id, int iconType, Action callback);

	void MapSetupTracePoint(int mapArea, int id, int iconType, bool isCancel, Action callback = null);

	void MapAreaExploreQuery(Action callback);

	void MapAreaExploreReward(int areaId, int type, Action callback = null);

	void BattleTeamChange(int index, Action callback);

	void TeamCharacterChange(PresetTeam team, int index, Action<bool> callback);

	void SaveTeamProfile(List<PresetTeam> teams, int mainTeamIndex, Action<bool> callBack);

	void DyeingAssist(int assistId, int skinId, int colorId, Action callback);

	void AssistEquip(int assistId, Action callback);

	void TriggerCustomInteractEvent(int swid, string eventName, Action<InteractRuleResult> callback, ItemCheck itemCheck = default(ItemCheck));

	void ChangeServiceSaveState(int wid, int swid, int stateId, bool sync, MapViewRecordParam mapViewRecordParam, Action callback, ItemCheck itemCheck = default(ItemCheck));

	void ChangeServiceSaveStates(int wid, List<StateChangeInfo> stateChangeInfos, bool sync, MapViewRecordParam mapViewRecordParam, Action<bool> callback, ItemCheck itemCheck = default(ItemCheck));

	void MapExploreCompleteRequest(int area, int chunkId = 0, Action callback = null);

	void AchievePlayeLevelAward(int level, Action<RepeatedField<Item>> callback, bool isAll = false);

	void SystemGuideChapterReward(int chapter, Action<RepeatedField<UniversalItem>> callback);

	void CheckSystemOpen(int systemId, Action<bool> callback);

	void SyncCharacterCharacteristic(Dictionary<int, CharacterStatus> characterStatus, int battleCharacterIndex);

	void SyncGameInfoReq(SyncGameInfoReq req, Action<bool> callback);

	void CreateBloodstain(BloodstainCreateRequest request, Action<bool, BloodstainData> callback);

	void ClaimBloodstain(string bloodstainId, Action<bool, IList<UniversalItem>> callback);

	void SetBloodStainEnable(bool isEnable, Action<bool> callback);

	void SceneSwitch(Vector3 pos, int chunkId, int worldId, SceneStatus sceneStatus, int areaId, Action<bool> callback = null);

	void DeleteItems(int itemType, List<OperationItem> items, Action<bool> callBack);

	void ComposeItem(Item composeItem, Action<bool> callBack);

	void ChangeWorldLevel(int level, Action<bool, long> callBack);

	void UseItem(int itemId, int itemUid, int count, int chooseItemIndex, Action<bool, RepeatedField<Item>, RepeatedField<UniversalItem>> callBack);

	void LightMapBlock(int worldId, int Roomindex, Action callBack);

	void SkillLevelUp(int characterId, int skillGroupId, Action<bool, RepeatedField<UniversalItem>> callBack);

	void PowerBuyFreeDiamond(Action<int> callBack);

	void RequestPowerCount(Action<PowerInfoQueryAck> callBack);

	void PowerExchangeItem(int itemId, int powerCost, Action<bool, RepeatedField<UniversalItem>> callBack);

	void DrawCard(int id, int count, Action<bool, RepeatedField<Item>> callback);

	void GetDailyReward(Action<bool, RepeatedField<Item>> callBack);

	void SceneBossChallenge(int difficultyLevel, Action<bool> callBack);

	void SceneTakeBossChallengeRewards(Action<bool, RepeatedField<Item>> callBack);

	void SceneResetChallengeBoss(Action<bool> callBack);

	void GetExtraReward(int count, Action<bool, RepeatedField<Item>> callBack);

	void ShopBuy(int id, int subShopIDx, int commodityIdx, int buyNum, Action<ShopBuyCommodityAck> callback);

	void CharacterBreakReward(int characterId, int stage, Action<bool> callBack);

	[Obsolete]
	void ConstellationLevelUp(int characterId, Action<bool> callBack);

	[Obsolete]
	void ConstellationSwitch(int characterId, int stage, Action<bool> callBack);

	void CharacterUpgradeConstellation(int characterId, int constellationId, Action<bool> callBack);

	void CharacterReturnConstellation(int characterId, int constellationId, Action<bool> callBack);

	void CharacterUpdateConstellation(int characterId, RepeatedField<int> constellationIds, Action<bool, int> callBack);

	void CharacterEliteLevelUp(int characterId, int pointId, int toLevel, Action<bool> callBack);

	void CharacterEliteReset(int characterId, int pointId, Action<bool> callBack);

	void CharacterEliteReset(int characterId, int pointId, int pointNode, Action<bool> callBack);

	void RaidEnterInfo(int raidId, TeamUsage usage, Action<bool> callBack, bool enterByGM = false);

	void GetRaidRewardInfo(int rewardRate, Action<bool, RepeatedField<UniversalItem>> callBack);

	void RaidSweep(int raidId, int sweepCount, Action<bool, RepeatedField<UniversalItem>> callBack);

	void LeaveRaid(Action<bool> callBack);

	void ReopenRaid(Action<bool> callBack);

	void ParkourRaidDead(Action<bool> callBack);

	void AbyssEnter(int abyssIndex, int abyssGroupId, List<TeamUsage> abyssTeamInfos, Action<bool> callBack, bool enterByGM = false);

	void AbyssCompleteSubStage(int sceond, Action<bool, bool, bool, AbyssStage, RepeatedField<UniversalItem>> callBack);

	void RechallengeAbyss(bool onlyCurrentLayer, Action<bool> callBack);

	void ComeBackAbyss(Action<bool> callBack);

	void LeaveAbyss(Action<bool> callBack);

	void AbyssTaskReward(int startNum, int abyssId, int stageIndex, bool claimAll, Action<bool, RepeatedField<UniversalItem>> callBack);

	void EnterTrainingGround(Action<bool> callback);

	void LeaveTrainingGround(Action<bool> callback);

	void UpdateUsageTeam(int scene, TeamUsage usage, Action<bool> callback);

	void ChangeAvatar(int avatarId, Action<bool> callBack);

	void ChangeAvatarFrame(int avatarFrameId, Action<bool> callBack);

	void ChangeTitle(int titleId, Action<bool> callBack);

	void ChangeShowCharacter(List<int> showCharacterIds, Action<bool> callBack);

	void ChangeNickname(string nickname, Action<bool, string, IMessage> callBack);

	void ChangeSignature(string signature, Action<bool, IMessage> callBack);

	void SaveMusic(int id);

	void AchievementSyncInfoReq(AchievementSyncInfo achievementSyncInfo, Action<bool> callback);

	void ReceiveAchievementReward(int id, Action<bool, RepeatedField<Item>> callback);

	void ReceiveAchievementGroupReward(int id, Action<bool, RepeatedField<Item>> callback);

	void AchievementComplete(int id, Action<bool, int> callback);

	void AchievementChange(int id, AchievementTag tag, Action<bool> callback);

	void SendConversationKeyPoint(List<int> ids, Action<bool> callback);

	void ClearConversationKeyPoints(List<int> ids, Action<bool> callback);

	void DestroyAccount(Action<bool> callback);

	void SaveSettingOptions(string json, Action<bool> callback);

	void GuideFinish(int guideListId, int step, Action<bool> callback);

	void SendGuideUnlock(int guideId, Action<GuideUnlockAck> callback);

	void SendGuideComplete(int guideId, Action<GuideCompleteAck> callback);

	void TriggerTutorial(int tutorialId, Action<bool> callback);

	void ReadTutorial(List<int> tutorialIds, Action<bool> callback);

	void LogPlayerExplorePos(string area, string layer, Vector2 playerWorldPos, Action<bool, string, string, Vector2> callback);

	void LayerExploreComplete(string area, string layer, Action<bool> callback);

	void SendConversationRecordOptions(Dictionary<int, int> keyValues, Action<bool> callback);

	void SendUnLockMonster(int type, Action<bool> callback);

	void SendKillMonsterNum(int monsterid, Action<HandbookUpdateAck> callback);

	void SendUnLockWildBoss(int monsterPointId, Action<bool> callback);

	void SendUseLittleItem(int itemId, Action<bool> callback);

	void TriggerTeleportPoint(Action<bool> callback);

	void RefreshRedDot(RedPoints redPoints, Action<bool> callback);

	void SyncLittleItems(LittleItemsShortcutInfo info, Action<bool> callback);

	void SendCreateCharacter(string type, int gender, Action<CreateUserAck> callback);

	void SendRogueChallenge(int modeId, int coreId, TeamUsage battleCharacter, long seed, Action<RogueChallengeAck> callback);

	void SendRogueEnterRoom(int gameworldId, Action<RogueEnterRoomAck> callback);

	void SendRogueEnterNextRoom(RogueRoomType type, Dictionary<int, RogueItem> roguebag, Dictionary<int, int> battleInfo, Dictionary<int, int> abilityUsage, Action<RogueEnterNextRoomAck> callback);

	void SendRogueGmNextRoom(RogueRoomType type, Action<RogueGmNextRoomAck> callback);

	void SendRogueBuyItem(bool isbuy, int itemid, Action<RogueBuyItemAck> callback, bool isReplace = false, int ReplacePosition = 0);

	void SendRogueBuyGmItem(int itemid, Action<RogueGmAddItemAck> callback);

	void SendRogueCoinReward(Action<RogueCoinRewardAck> callback);

	void SendRecycleItem(int itemId, Action<RogueRecycleItemAck> callback);

	void SendRoguePickUpItem(int itemId, bool isReplace, int replacePosition, Action<RoguePickUpItemAck> callback);

	void SendRogueSetRoomFinished(Action<RogueSetRoomFinishedAck> callback);

	void SendRogueHangGame(Action<RogueHangGameAck> callback);

	void SendRogueContinueGame(Action<RogueContinueGameAck> callback);

	void SendRogueFinishGame(RogueFinishType finishType, Action<RogueFinishGameAck> callback);

	void SendUpgradeTalentNode(int nodeId, Action<RogueUpdateTalentTreeNodeAck> callback);

	void SendAssistNpcHelp(int npcId, int wid, Action<bool> callback);

	void SendAssistNpcFinish(int npcId, Action<bool> callback);

	void CompleteMissionBluePrint(MissionState mission, int id, Action<bool> callback);

	void ContactChooseOption(int sessionId, int chooseIdx, Action<bool> callback);

	void SyncBloodBottleLevelUp(int bottleId, int toLevel, Action<bool> callback);

	void UpdateBottleMaterials(int bottleId, List<int> matId, Action<bool> callback);

	void SendUseBloodBottle(Action<bool> callbackt);

	void RecoverBottleUseCount(int targetCount, Action<int> callback);

	void SendGetTempleRewards(int templeId, int rewardStarLevel, Action<bool, TempleTakeStarRewardAck> callback);

	void UnlockTemple(int templeId, Action<bool> callback);

	void EnterTempleChallenge(int areaId, TeamUsage teamUsage, Action<bool> callback);

	void TempleRechallenge(Action<bool> callback);

	void LeaveTemple(Action<bool> callback, bool resetData = true);

	void CompleteTempleStage(Action<RepeatedField<UniversalItem>> callback);

	void TempleFailure(Action callback);

	void RaidFailure(Action callback);

	void AbyssFailure(Action callback);

	void SyncBattleTempleBuffSelection(int roomIndex, int buffId, Action<bool> callback);

	void SendActivityGainReward(int activityId, int activitySubGroupId, int subActivityId, Action<ActivityGetLevelRewardAck> callback);

	void SendDoubleDungeonReward(int activityId, int rewardBoxId, Action<bool> callback);

	void SendActivityCombinationReward(int activityId, int activitySubGroupId, Action<bool, ActivityCombinationRewardAck> callback);

	void SendActivityMainStoryReward(int activityId, int activityGroup, Action<ActivityMainStoryRewardAck> callback);

	void SendActivityMapExploreReward(int activityId, int activityGroup, Action<ActivityMapExploreRewardAck> callback);

	void SendActivityMultiDeviceReward(int activityId, int activityGroup, int activityChallenge, Action<ActivityMultiDeviceRewardAck> callback);

	void SendGachaCardDraw(int gachaid, int count, Action<GachaCardDrawAck> callback, bool Beginner = false);

	void SendGachaQueryHistory(GachaPoolType poolType, int page, Action<GachaQueryHistoryAck> callback)
	{
	}

	void SendGachaExchangeFinalGuaranteed(int poolid, int gachaitemid, Action<GachaExchangeFinalGuaranteedAck> callback)
	{
	}

	void SendGachaTargetSelect(int gachaId, int targetGachaItemId, Action<GachaTargetSelectAck> callback);

	void SendGachaTargetCancel(int gachaId, Action<GachaTargetCancelAck> callback);

	void SendGaChaExchangeMilestoneReward(int poolId, Action<GachaExchangeMilestoneRewardAck> callback);

	void SendGachaExchangeTicket(int poolid, int num, Action<GachaExchangeTicketAck> callback)
	{
	}

	void RequestActivitySignInChooseReward(int activityId, int groupId, int challengeId, int rewards, Action<ActivitySignInChooseRewardAck> callBack);

	void RequestActivitySignInReward(int activityId, int groupId, int challengeId, Action<ActivitySignInRewardAck> callBack);

	void RequestActivityAbyssReward(int activityId, int activityGroup, int activityChallenge, Action<ActivityAbyssRewardAck> callBack);

	void RequestActivityRefresh(Action<ActivityRefreshAck> callBack);

	void SubmitDivineEye(int exploreAreaId, int submitCount, Action<bool, List<UniversalItem>> callback);

	void RewardDivineEye(int exploreAreaId, Action<bool> callback);

	void QuestionnaireRead(int id);

	void SwitchTempArchiveUpdateReq(TempArchiveOperation operation, SyncGameInfoReq syncData, Action<bool> callback);

	void SendOrder(int goodsId, int subShopId = 0, bool isRetry = false, Action<bool, CreatOrderAck> callback = null);

	void ExchangeFreeDiamond(int num, Action<bool> callback = null);

	void ExchangeCommodity(int subShopId, int commodityId, Action<bool, List<Item>> callback = null, List<int> selectedIndex = null);

	void OrderShipDisplay(string orderId, Action<bool> isSuccess = null);

	void SendWorldLevelBreakReq(Action<bool, IList<UniversalItem>> callback);

	void SendHandbookDailyMissionClaimReward(int rowID, Action<bool, List<Item>> callback = null);

	void SendHandbookDailyActivePtClaimReward(Action<bool, List<Item>> callback = null);

	void BattlePassBuyLevelReq(int buyCount, Action<bool> callback);

	void BattlePassClaimTaskReq(int taskGroupId, int taskId, Action<bool> callback);

	void BattlePassClaimRewardReq(int level, bool isPremium, Action<bool, RepeatedField<UniversalItem>> callback);

	void SendUnlockTextLibraryReq(List<int> unlockIds, Action<VocabularyUnlockContentAck, bool> callBack);

	void SendTextLibraryReadReq(List<int> textLibraryIds, Action<bool> callBack);

	void SendTextLibraryGroupState(Dictionary<int, bool> syncGoup, Action<bool> callBack);

	void SendOpenPackageGift(int packageGiftId, int openCount, Action<List<UniversalItem>, bool> callback, int selfSelectItemIndex = 0);

	void RecycleItemsReq(RepeatedField<UniversalItem> universalItems, Action<RecycleItemsAck> callback);

	void ActivityRoleTrialRewardReq(int activityId, int activityGroup, int activityChallenge, Action<ActivityRoleTrialRewardAck> callback);

	void SendActivityDailyLotteryGachaReq(int activityID, int lotteryPoolID, Action<ActivityDailyLotteryGachaAck> callback);

	void SendActivityKujiRewardReq(int activityId, int activityGroup, Action<ActivityKujiRewardAck> callback);

	void SendActivityKujiDrawReq(int activityId, Action<ActivityKujiDrawAck> callback);

	void SendAwardChapterReward(int chapterId, Action<HandbookGrowthGuideChapterClaimRewardAck, bool> callback);

	void SendAwardTargetGuideMissionReward(int missionGroupId, int chapterId, Action<HandbookGrowthGuideMissionClaimRewardAck, bool> callback);

	void SendRedeemCodeUseReq(string code, Action<RedeemCodeUseAck, bool, IMessage> callback);

	void RequestEnterLounge(Action<IMessage> callback);

	void SendChangeGender(int gender, Action<ChangeGenderAck> callback);

	void WildBossTakeRewardReq(int wildBossCollectionUid, Action<bool, RepeatedField<UniversalItem>> callback);

	void WildBossRewardBoughtReq(int buyCont, Action<bool> callback);

	void SendAchievementRewardReq(int groupId, Action<AchievementRewardAck> callback);

	void SendAchievementGroupRewardReq(int groupId, Action<AchievementGroupRewardAck> callback);

	void SendChangeSkinReq(int roleId, int skinId, Action<ChangeSkinAck> callback);

	void SendChangeEffectDressReq(int roleId, int effectDressId, bool wear, Action<ChangeEffectDressAck> callback);

	void SendMonthlyPassRecordPopReq(int passId, long PopTimeUnix, Action<MonthlyPassRecordPopAck> callback);

	void SendActivitySkinTrialRewardReq(int activityId, int activityChallengeGroupId, int activityChallengeId, Action<ActivitySkinTrialRewardAck> callback);

	void SendActivityTotalRechargeRewardReq(int activityId, int activityGroup, Action<ActivityTotalRechargeRewardAck> callback);
}
