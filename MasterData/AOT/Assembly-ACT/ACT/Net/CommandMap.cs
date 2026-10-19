using System;
using System.Collections.Generic;
using ACT.Game.Data;
using Fundamental;
using Google.Protobuf;
using Pb;
using UnityEngine;

namespace ACT.Net;

public static class CommandMap
{
	private static Dictionary<string, ushort> s_Map;

	static CommandMap()
	{
		s_Map = new Dictionary<string, ushort>();
		s_Map[OptUtils.GetTypeName(typeof(CommonStart))] = 0;
		s_Map[OptUtils.GetTypeName(typeof(DemandDataReq))] = 2;
		s_Map[OptUtils.GetTypeName(typeof(PingReq))] = 6;
		s_Map[OptUtils.GetTypeName(typeof(CommonEnd))] = 8;
		s_Map[OptUtils.GetTypeName(typeof(LoginMsgStart))] = 10;
		s_Map[OptUtils.GetTypeName(typeof(LoginReq))] = 11;
		s_Map[OptUtils.GetTypeName(typeof(LoginMsgEnd))] = 1000;
		s_Map[OptUtils.GetTypeName(typeof(GateMsgStart))] = 1001;
		s_Map[OptUtils.GetTypeName(typeof(EnterGameReq))] = 1002;
		s_Map[OptUtils.GetTypeName(typeof(EnterMatchReq))] = 1004;
		s_Map[OptUtils.GetTypeName(typeof(QueryUserProfileReq))] = 1006;
		s_Map[OptUtils.GetTypeName(typeof(LeaderboardQueryReq))] = 1050;
		s_Map[OptUtils.GetTypeName(typeof(LeaderboardQueryMemberReq))] = 1052;
		s_Map[OptUtils.GetTypeName(typeof(RoomJoinReq))] = 1100;
		s_Map[OptUtils.GetTypeName(typeof(RoomLeaveReq))] = 1102;
		s_Map[OptUtils.GetTypeName(typeof(GameBatchPacket))] = 2002;
		s_Map[OptUtils.GetTypeName(typeof(CreateUserReq))] = 2022;
		s_Map[OptUtils.GetTypeName(typeof(EnterGameLoadReq))] = 2024;
		s_Map[OptUtils.GetTypeName(typeof(RandomNameReq))] = 2026;
		s_Map[OptUtils.GetTypeName(typeof(GmActionProcessReq))] = 2130;
		s_Map[OptUtils.GetTypeName(typeof(GmChatsReq))] = 2132;
		s_Map[OptUtils.GetTypeName(typeof(GmChatReq))] = 2134;
		s_Map[OptUtils.GetTypeName(typeof(ActivityGetLevelRewardReq))] = 3102;
		s_Map[OptUtils.GetTypeName(typeof(ActivityDoubleDungeonRewardReq))] = 3105;
		s_Map[OptUtils.GetTypeName(typeof(ActivitySignInChooseRewardReq))] = 3108;
		s_Map[OptUtils.GetTypeName(typeof(ActivitySignInRewardReq))] = 3110;
		s_Map[OptUtils.GetTypeName(typeof(ActivityAbyssRewardReq))] = 3113;
		s_Map[OptUtils.GetTypeName(typeof(ActivityCombinationRewardReq))] = 3116;
		s_Map[OptUtils.GetTypeName(typeof(ActivityRoleTrialRewardReq))] = 3120;
		s_Map[OptUtils.GetTypeName(typeof(ActivityDailyLotteryGachaReq))] = 3123;
		s_Map[OptUtils.GetTypeName(typeof(ActivityRefreshReq))] = 3125;
		s_Map[OptUtils.GetTypeName(typeof(ActivitySkinTrialRewardReq))] = 3128;
		s_Map[OptUtils.GetTypeName(typeof(ActivityTotalRechargeRewardReq))] = 3131;
		s_Map[OptUtils.GetTypeName(typeof(ActivityKujiRewardReq))] = 3134;
		s_Map[OptUtils.GetTypeName(typeof(ActivityKujiDrawReq))] = 3136;
		s_Map[OptUtils.GetTypeName(typeof(ActivityMainStoryRewardReq))] = 3139;
		s_Map[OptUtils.GetTypeName(typeof(ActivityMapExploreRewardReq))] = 3142;
		s_Map[OptUtils.GetTypeName(typeof(ActivityMultiDeviceRewardReq))] = 3145;
		s_Map[OptUtils.GetTypeName(typeof(UseItemsReq))] = 3201;
		s_Map[OptUtils.GetTypeName(typeof(DelItemsReq))] = 3203;
		s_Map[OptUtils.GetTypeName(typeof(ComposeItemReq))] = 3206;
		s_Map[OptUtils.GetTypeName(typeof(UseLittleItemReq))] = 3209;
		s_Map[OptUtils.GetTypeName(typeof(SyncLittleItemsReq))] = 3211;
		s_Map[OptUtils.GetTypeName(typeof(PotionUseReq))] = 3217;
		s_Map[OptUtils.GetTypeName(typeof(PotionLevelUpReq))] = 3219;
		s_Map[OptUtils.GetTypeName(typeof(PotionUpdateAdditiveReq))] = 3221;
		s_Map[OptUtils.GetTypeName(typeof(PotionRecoverUseCountReq))] = 3225;
		s_Map[OptUtils.GetTypeName(typeof(RecycleItemsReq))] = 3228;
		s_Map[OptUtils.GetTypeName(typeof(OpenBagChestReq))] = 3231;
		s_Map[OptUtils.GetTypeName(typeof(PowerInfoQueryReq))] = 3235;
		s_Map[OptUtils.GetTypeName(typeof(CharacterLevelUpReq))] = 3301;
		s_Map[OptUtils.GetTypeName(typeof(CharacterStageReq))] = 3303;
		s_Map[OptUtils.GetTypeName(typeof(CharacterTakeStageRewardReq))] = 3305;
		s_Map[OptUtils.GetTypeName(typeof(CharacterStatusSyncReq))] = 3307;
		s_Map[OptUtils.GetTypeName(typeof(CharacterUpgradeSkillGroupReq))] = 3309;
		s_Map[OptUtils.GetTypeName(typeof(CharacterUpgradeConstellationReq))] = 3311;
		s_Map[OptUtils.GetTypeName(typeof(CharacterReturnConstellationReq))] = 3313;
		s_Map[OptUtils.GetTypeName(typeof(CharacterUpdateConstellationReq))] = 3315;
		s_Map[OptUtils.GetTypeName(typeof(CharacterEliteLevelUpReq))] = 3317;
		s_Map[OptUtils.GetTypeName(typeof(CharacterEliteResetReq))] = 3319;
		s_Map[OptUtils.GetTypeName(typeof(GiftToCharacterReq))] = 3321;
		s_Map[OptUtils.GetTypeName(typeof(WeaponWearReq))] = 3401;
		s_Map[OptUtils.GetTypeName(typeof(WeaponLockReq))] = 3403;
		s_Map[OptUtils.GetTypeName(typeof(WeaponLevelUpReq))] = 3405;
		s_Map[OptUtils.GetTypeName(typeof(WeaponStageReq))] = 3407;
		s_Map[OptUtils.GetTypeName(typeof(WeaponRefineReq))] = 3409;
		s_Map[OptUtils.GetTypeName(typeof(ChipWearReq))] = 3501;
		s_Map[OptUtils.GetTypeName(typeof(ChipLockReq))] = 3503;
		s_Map[OptUtils.GetTypeName(typeof(ChipLevelUpReq))] = 3505;
		s_Map[OptUtils.GetTypeName(typeof(ChipUnloadReq))] = 3507;
		s_Map[OptUtils.GetTypeName(typeof(ChipDecomposeReq))] = 3509;
		s_Map[OptUtils.GetTypeName(typeof(ChipCancelNewFlagReq))] = 3511;
		s_Map[OptUtils.GetTypeName(typeof(DropItemPickItemReq))] = 3700;
		s_Map[OptUtils.GetTypeName(typeof(DropItemPickPackageReq))] = 3703;
		s_Map[OptUtils.GetTypeName(typeof(RecordLastPosReq))] = 3900;
		s_Map[OptUtils.GetTypeName(typeof(RecordSpawnPosReq))] = 3902;
		s_Map[OptUtils.GetTypeName(typeof(ReplacMissionTrackingReq))] = 3906;
		s_Map[OptUtils.GetTypeName(typeof(EscModifyNicknameReq))] = 3914;
		s_Map[OptUtils.GetTypeName(typeof(EscModifySignatureReq))] = 3916;
		s_Map[OptUtils.GetTypeName(typeof(EscModifyAvatarReq))] = 3918;
		s_Map[OptUtils.GetTypeName(typeof(SavePlayingMusicReq))] = 3921;
		s_Map[OptUtils.GetTypeName(typeof(SyncGameInfoReq))] = 3923;
		s_Map[OptUtils.GetTypeName(typeof(RecordCheckPosReq))] = 3925;
		s_Map[OptUtils.GetTypeName(typeof(ChangeNickNameReq))] = 3927;
		s_Map[OptUtils.GetTypeName(typeof(PublicChatReq))] = 3929;
		s_Map[OptUtils.GetTypeName(typeof(SyncSettingOptionsReq))] = 3932;
		s_Map[OptUtils.GetTypeName(typeof(RecordTmpArchivePosReq))] = 3936;
		s_Map[OptUtils.GetTypeName(typeof(ChangeGenderReq))] = 3938;
		s_Map[OptUtils.GetTypeName(typeof(EscModifyAvatarFrameReq))] = 3940;
		s_Map[OptUtils.GetTypeName(typeof(EscModifyTitleReq))] = 3943;
		s_Map[OptUtils.GetTypeName(typeof(EscModifyShowCharacterReq))] = 3946;
		s_Map[OptUtils.GetTypeName(typeof(MissionUpdateStateReq))] = 4000;
		s_Map[OptUtils.GetTypeName(typeof(AcceptMissionReq))] = 4003;
		s_Map[OptUtils.GetTypeName(typeof(MissionMonsterDieReq))] = 4005;
		s_Map[OptUtils.GetTypeName(typeof(MissionUpdateBluePrintReq))] = 4007;
		s_Map[OptUtils.GetTypeName(typeof(MissionApplyItemReq))] = 4009;
		s_Map[OptUtils.GetTypeName(typeof(MissionStateUpdateReq))] = 4014;
		s_Map[OptUtils.GetTypeName(typeof(MissionConditionUpdateReq))] = 4017;
		s_Map[OptUtils.GetTypeName(typeof(MissionAcceptReq))] = 4020;
		s_Map[OptUtils.GetTypeName(typeof(MissionRAcceptReq))] = 4026;
		s_Map[OptUtils.GetTypeName(typeof(MissionRUpdateFlowReq))] = 4028;
		s_Map[OptUtils.GetTypeName(typeof(MissionRConditionUpdateReq))] = 4030;
		s_Map[OptUtils.GetTypeName(typeof(MissionRActionUpdateReq))] = 4032;
		s_Map[OptUtils.GetTypeName(typeof(MissionRUpdateStateReq))] = 4034;
		s_Map[OptUtils.GetTypeName(typeof(FishSetupReq))] = 4100;
		s_Map[OptUtils.GetTypeName(typeof(FishStartReq))] = 4102;
		s_Map[OptUtils.GetTypeName(typeof(FishReq))] = 4104;
		s_Map[OptUtils.GetTypeName(typeof(HandbookUpdateReq))] = 4202;
		s_Map[OptUtils.GetTypeName(typeof(ArchiveUpdateReq))] = 4252;
		s_Map[OptUtils.GetTypeName(typeof(ArchiveReadReq))] = 4254;
		s_Map[OptUtils.GetTypeName(typeof(RecipeMakeReq))] = 4300;
		s_Map[OptUtils.GetTypeName(typeof(AssistDyeingReq))] = 4402;
		s_Map[OptUtils.GetTypeName(typeof(AssistSetupReq))] = 4404;
		s_Map[OptUtils.GetTypeName(typeof(AssistEquipReq))] = 4406;
		s_Map[OptUtils.GetTypeName(typeof(MapSetupCustomFlagReq))] = 4501;
		s_Map[OptUtils.GetTypeName(typeof(MapDelCustomFlagReq))] = 4503;
		s_Map[OptUtils.GetTypeName(typeof(LightMapBlockReq))] = 4507;
		s_Map[OptUtils.GetTypeName(typeof(MapViewLogReq))] = 4510;
		s_Map[OptUtils.GetTypeName(typeof(MapViewCompleteLayerReq))] = 4513;
		s_Map[OptUtils.GetTypeName(typeof(SceneSwitchReq))] = 4515;
		s_Map[OptUtils.GetTypeName(typeof(MapModifyCustomFlagTypeReq))] = 4517;
		s_Map[OptUtils.GetTypeName(typeof(MapSetupTracePointReq))] = 4519;
		s_Map[OptUtils.GetTypeName(typeof(MapFetchCustomFlagInfoReq))] = 4521;
		s_Map[OptUtils.GetTypeName(typeof(MapSubmitDivinePupilReq))] = 4525;
		s_Map[OptUtils.GetTypeName(typeof(MapClaimDivinePupilRewardReq))] = 4527;
		s_Map[OptUtils.GetTypeName(typeof(MapAreaExploreQueryReq))] = 4530;
		s_Map[OptUtils.GetTypeName(typeof(MapExploreClaimRewardReq))] = 4532;
		s_Map[OptUtils.GetTypeName(typeof(ChunkSwitchReq))] = 4534;
		s_Map[OptUtils.GetTypeName(typeof(SceneWorldLayerSwitchReq))] = 4536;
		s_Map[OptUtils.GetTypeName(typeof(TriggerInteractEventReq))] = 4700;
		s_Map[OptUtils.GetTypeName(typeof(SceneChallengeBossReq))] = 4702;
		s_Map[OptUtils.GetTypeName(typeof(SceneTakeChallengeBossRewardReq))] = 4704;
		s_Map[OptUtils.GetTypeName(typeof(SceneResetChallengeBossReq))] = 4706;
		s_Map[OptUtils.GetTypeName(typeof(TriggerTeleportPointReq))] = 4708;
		s_Map[OptUtils.GetTypeName(typeof(WildBossTakeRewardReq))] = 4710;
		s_Map[OptUtils.GetTypeName(typeof(WildBossRewardBoughtReq))] = 4712;
		s_Map[OptUtils.GetTypeName(typeof(RoomJoinConfirmReq))] = 4803;
		s_Map[OptUtils.GetTypeName(typeof(RoomKickoutReq))] = 4806;
		s_Map[OptUtils.GetTypeName(typeof(RoomSetPermissionReq))] = 4808;
		s_Map[OptUtils.GetTypeName(typeof(RoomCreateReq))] = 4811;
		s_Map[OptUtils.GetTypeName(typeof(RoomSyncReq))] = 4813;
		s_Map[OptUtils.GetTypeName(typeof(RoomInfoReq))] = 4817;
		s_Map[OptUtils.GetTypeName(typeof(SystemOpenReq))] = 4900;
		s_Map[OptUtils.GetTypeName(typeof(SystemTakeLevelRewardReq))] = 4903;
		s_Map[OptUtils.GetTypeName(typeof(SystemGuideTakeChapterRewardReq))] = 4906;
		s_Map[OptUtils.GetTypeName(typeof(SystemReadDoneReq))] = 4908;
		s_Map[OptUtils.GetTypeName(typeof(ChangeWorldLevelReq))] = 5000;
		s_Map[OptUtils.GetTypeName(typeof(DrawCardReq))] = 5004;
		s_Map[OptUtils.GetTypeName(typeof(DrawCardChooseItemReq))] = 5006;
		s_Map[OptUtils.GetTypeName(typeof(DestroyReq))] = 5008;
		s_Map[OptUtils.GetTypeName(typeof(RedeemCodeUseReq))] = 5010;
		s_Map[OptUtils.GetTypeName(typeof(GachaCardDrawReq))] = 5012;
		s_Map[OptUtils.GetTypeName(typeof(GachaQueryHistoryReq))] = 5014;
		s_Map[OptUtils.GetTypeName(typeof(GachaExchangeFinalGuaranteedReq))] = 5018;
		s_Map[OptUtils.GetTypeName(typeof(GachaExchangeAccumulativeRewardReq))] = 5020;
		s_Map[OptUtils.GetTypeName(typeof(GachaExchangeTicketReq))] = 5024;
		s_Map[OptUtils.GetTypeName(typeof(TempArchiveUpdateReq))] = 5028;
		s_Map[OptUtils.GetTypeName(typeof(ChangeSkinReq))] = 5038;
		s_Map[OptUtils.GetTypeName(typeof(MonthlyPassRecordPopReq))] = 5043;
		s_Map[OptUtils.GetTypeName(typeof(GachaExchangeMilestoneRewardReq))] = 5046;
		s_Map[OptUtils.GetTypeName(typeof(PlayerDeadReq))] = 5049;
		s_Map[OptUtils.GetTypeName(typeof(SetBloodStainEnableReq))] = 5052;
		s_Map[OptUtils.GetTypeName(typeof(BloodStainInteractReq))] = 5054;
		s_Map[OptUtils.GetTypeName(typeof(ChangeEffectDressReq))] = 5056;
		s_Map[OptUtils.GetTypeName(typeof(PowerExchangeReq))] = 5060;
		s_Map[OptUtils.GetTypeName(typeof(GachaTargetSelectReq))] = 5062;
		s_Map[OptUtils.GetTypeName(typeof(GachaTargetCancelReq))] = 5064;
		s_Map[OptUtils.GetTypeName(typeof(MailChangeStateReq))] = 5100;
		s_Map[OptUtils.GetTypeName(typeof(MailChangeTagReq))] = 5102;
		s_Map[OptUtils.GetTypeName(typeof(MailOpenBoxReq))] = 5104;
		s_Map[OptUtils.GetTypeName(typeof(MailUnlockReq))] = 5108;
		s_Map[OptUtils.GetTypeName(typeof(RaidEnterReq))] = 5200;
		s_Map[OptUtils.GetTypeName(typeof(RaidTakeRewardsReq))] = 5205;
		s_Map[OptUtils.GetTypeName(typeof(RaidLeaveReq))] = 5207;
		s_Map[OptUtils.GetTypeName(typeof(RaidRechallengeReq))] = 5210;
		s_Map[OptUtils.GetTypeName(typeof(RaidPlayerDeadReq))] = 5212;
		s_Map[OptUtils.GetTypeName(typeof(RaidSweepReq))] = 5214;
		s_Map[OptUtils.GetTypeName(typeof(RaidFailureReq))] = 5216;
		s_Map[OptUtils.GetTypeName(typeof(TrainingGroundEnterReq))] = 5250;
		s_Map[OptUtils.GetTypeName(typeof(TrainingGroundLeaveReq))] = 5252;
		s_Map[OptUtils.GetTypeName(typeof(ShopBuyCommodityReq))] = 5301;
		s_Map[OptUtils.GetTypeName(typeof(ExchangeFreeDiamondReq))] = 5305;
		s_Map[OptUtils.GetTypeName(typeof(ExchangeCommodityReq))] = 5307;
		s_Map[OptUtils.GetTypeName(typeof(PowerBuyReq))] = 5400;
		s_Map[OptUtils.GetTypeName(typeof(CreatOrderReq))] = 5500;
		s_Map[OptUtils.GetTypeName(typeof(PayActionProcessReq))] = 5502;
		s_Map[OptUtils.GetTypeName(typeof(OrderShipDisplayedReq))] = 5505;
		s_Map[OptUtils.GetTypeName(typeof(AbyssChallengeStageReq))] = 5600;
		s_Map[OptUtils.GetTypeName(typeof(AbyssCompleteSubStageReq))] = 5602;
		s_Map[OptUtils.GetTypeName(typeof(AbyssTakeRewardReq))] = 5604;
		s_Map[OptUtils.GetTypeName(typeof(AbyssLeaveReq))] = 5607;
		s_Map[OptUtils.GetTypeName(typeof(AbyssRechallengeReq))] = 5610;
		s_Map[OptUtils.GetTypeName(typeof(AbyssFailureReq))] = 5612;
		s_Map[OptUtils.GetTypeName(typeof(AchievementTakeRewardReq))] = 5700;
		s_Map[OptUtils.GetTypeName(typeof(AchievementTakeGroupRewardReq))] = 5702;
		s_Map[OptUtils.GetTypeName(typeof(AchievementSyncInfoReq))] = 5704;
		s_Map[OptUtils.GetTypeName(typeof(AchievementCompleteReq))] = 5708;
		s_Map[OptUtils.GetTypeName(typeof(AchievementChangeTagReq))] = 5710;
		s_Map[OptUtils.GetTypeName(typeof(AchievementRecordConversationReq))] = 5712;
		s_Map[OptUtils.GetTypeName(typeof(AchievementRecordConversationOptionReq))] = 5714;
		s_Map[OptUtils.GetTypeName(typeof(AchievementRewardReq))] = 5716;
		s_Map[OptUtils.GetTypeName(typeof(AchievementGroupRewardReq))] = 5718;
		s_Map[OptUtils.GetTypeName(typeof(CookReq))] = 5800;
		s_Map[OptUtils.GetTypeName(typeof(CookResetMinorBuffReq))] = 5802;
		s_Map[OptUtils.GetTypeName(typeof(CookSaveCustomMenuReq))] = 5804;
		s_Map[OptUtils.GetTypeName(typeof(CookDelCustomMenuReq))] = 5806;
		s_Map[OptUtils.GetTypeName(typeof(CookModifyCustomMenuNameReq))] = 5809;
		s_Map[OptUtils.GetTypeName(typeof(GuideLogsInterfaceReq))] = 5901;
		s_Map[OptUtils.GetTypeName(typeof(GuideTriggerReq))] = 5903;
		s_Map[OptUtils.GetTypeName(typeof(GuideReadReq))] = 5905;
		s_Map[OptUtils.GetTypeName(typeof(GuideUnlockReq))] = 5907;
		s_Map[OptUtils.GetTypeName(typeof(GuideCompleteReq))] = 5909;
		s_Map[OptUtils.GetTypeName(typeof(AnswerQuestionReq))] = 6000;
		s_Map[OptUtils.GetTypeName(typeof(QuestionnaireReadReq))] = 6004;
		s_Map[OptUtils.GetTypeName(typeof(FriendOperateReq))] = 6100;
		s_Map[OptUtils.GetTypeName(typeof(FriendSearchReq))] = 6102;
		s_Map[OptUtils.GetTypeName(typeof(HandbookDailyMissionClaimRewardReq))] = 6200;
		s_Map[OptUtils.GetTypeName(typeof(HandbookDailyActivePtClaimRewardReq))] = 6202;
		s_Map[OptUtils.GetTypeName(typeof(HandbookGrowthGuideMissionClaimRewardReq))] = 6204;
		s_Map[OptUtils.GetTypeName(typeof(HandbookGrowthGuideChapterClaimRewardReq))] = 6206;
		s_Map[OptUtils.GetTypeName(typeof(RedPointSetReq))] = 6301;
		s_Map[OptUtils.GetTypeName(typeof(RogueUnlockTalentTreeCodeReq))] = 6401;
		s_Map[OptUtils.GetTypeName(typeof(RogueUpdateTalentTreeNodeReq))] = 6403;
		s_Map[OptUtils.GetTypeName(typeof(RogueChallengeReq))] = 6405;
		s_Map[OptUtils.GetTypeName(typeof(RogueEnterNextRoomReq))] = 6407;
		s_Map[OptUtils.GetTypeName(typeof(RogueBuyItemReq))] = 6409;
		s_Map[OptUtils.GetTypeName(typeof(RogueRecycleItemReq))] = 6411;
		s_Map[OptUtils.GetTypeName(typeof(RogueHangGameReq))] = 6413;
		s_Map[OptUtils.GetTypeName(typeof(RogueContinueGameReq))] = 6415;
		s_Map[OptUtils.GetTypeName(typeof(RogueFinishGameReq))] = 6417;
		s_Map[OptUtils.GetTypeName(typeof(RogueCoinRewardReq))] = 6419;
		s_Map[OptUtils.GetTypeName(typeof(RogueTeamChangeReq))] = 6422;
		s_Map[OptUtils.GetTypeName(typeof(RoguePickUpItemReq))] = 6424;
		s_Map[OptUtils.GetTypeName(typeof(RogueModifyCoinReq))] = 6426;
		s_Map[OptUtils.GetTypeName(typeof(RogueEnterRoomReq))] = 6428;
		s_Map[OptUtils.GetTypeName(typeof(RogueSetRoomFinishedReq))] = 6431;
		s_Map[OptUtils.GetTypeName(typeof(RogueGmNextRoomReq))] = 6433;
		s_Map[OptUtils.GetTypeName(typeof(RogueGmAddItemReq))] = 6435;
		s_Map[OptUtils.GetTypeName(typeof(AssistantNpcHelpReq))] = 6501;
		s_Map[OptUtils.GetTypeName(typeof(AssistantNpcFinishReq))] = 6503;
		s_Map[OptUtils.GetTypeName(typeof(EquipCreateReq))] = 6602;
		s_Map[OptUtils.GetTypeName(typeof(EquipEnhanceReq))] = 6604;
		s_Map[OptUtils.GetTypeName(typeof(EquipDismantleReq))] = 6606;
		s_Map[OptUtils.GetTypeName(typeof(EquipWearReq))] = 6608;
		s_Map[OptUtils.GetTypeName(typeof(EquipGemOperateReq))] = 6610;
		s_Map[OptUtils.GetTypeName(typeof(EquipLockReq))] = 6612;
		s_Map[OptUtils.GetTypeName(typeof(GemFusionReq))] = 6614;
		s_Map[OptUtils.GetTypeName(typeof(GemLockReq))] = 6616;
		s_Map[OptUtils.GetTypeName(typeof(TempleUnlockReq))] = 6701;
		s_Map[OptUtils.GetTypeName(typeof(TempleChallengeReq))] = 6703;
		s_Map[OptUtils.GetTypeName(typeof(TempleRechallengeReq))] = 6705;
		s_Map[OptUtils.GetTypeName(typeof(TempleLeaveReq))] = 6707;
		s_Map[OptUtils.GetTypeName(typeof(TempleCompleteStageReq))] = 6709;
		s_Map[OptUtils.GetTypeName(typeof(TempleTakeStarRewardReq))] = 6711;
		s_Map[OptUtils.GetTypeName(typeof(TempleFailureReq))] = 6713;
		s_Map[OptUtils.GetTypeName(typeof(TempleSelectBuffReq))] = 6715;
		s_Map[OptUtils.GetTypeName(typeof(ContactChooseOptionReq))] = 6803;
		s_Map[OptUtils.GetTypeName(typeof(ContactChatWithPlayerReq))] = 6805;
		s_Map[OptUtils.GetTypeName(typeof(ReplacePresetTeamReq))] = 6901;
		s_Map[OptUtils.GetTypeName(typeof(SavePresetTeamsReq))] = 6903;
		s_Map[OptUtils.GetTypeName(typeof(ModifyPresetTeamNameReq))] = 6905;
		s_Map[OptUtils.GetTypeName(typeof(DelPresetTeamReq))] = 6907;
		s_Map[OptUtils.GetTypeName(typeof(RecordBattleTeamReq))] = 6909;
		s_Map[OptUtils.GetTypeName(typeof(UpdateUsageTeamReq))] = 6911;
		s_Map[OptUtils.GetTypeName(typeof(LoungeEnterReq))] = 7000;
		s_Map[OptUtils.GetTypeName(typeof(LoungeTriggerPointReq))] = 7002;
		s_Map[OptUtils.GetTypeName(typeof(LoungeLeaveReq))] = 7004;
		s_Map[OptUtils.GetTypeName(typeof(BattlePassBuyLevelReq))] = 7101;
		s_Map[OptUtils.GetTypeName(typeof(BattlePassClaimTaskReq))] = 7103;
		s_Map[OptUtils.GetTypeName(typeof(BattlePassClaimRewardReq))] = 7105;
		s_Map[OptUtils.GetTypeName(typeof(VocabularyUnlockContentReq))] = 7201;
		s_Map[OptUtils.GetTypeName(typeof(VocabularyReadContentReq))] = 7203;
		s_Map[OptUtils.GetTypeName(typeof(VocabularyRememberGroupStateReq))] = 7205;
		s_Map[OptUtils.GetTypeName(typeof(ReviewPromptDisplayedReq))] = 7301;
		s_Map[OptUtils.GetTypeName(typeof(GameMsgEnd))] = 10000;
		s_Map[OptUtils.GetTypeName(typeof(MatchForwardMessageReq))] = 10002;
	}

	internal static IMessage Parse(ushort cmdId, byte[] data, int offset, int len)
	{
		switch (cmdId)
		{
		case 1:
			return ErrorAck.Parser.ParseFrom(data, offset, len);
		case 3:
			return DemandDataAck.Parser.ParseFrom(data, offset, len);
		case 4:
			return AttributeNtf.Parser.ParseFrom(data, offset, len);
		case 5:
			return KickUserNtf.Parser.ParseFrom(data, offset, len);
		case 7:
			return PingAck.Parser.ParseFrom(data, offset, len);
		case 12:
			return LoginAck.Parser.ParseFrom(data, offset, len);
		case 1003:
			return EnterGameAck.Parser.ParseFrom(data, offset, len);
		case 1005:
			return EnterMatchAck.Parser.ParseFrom(data, offset, len);
		case 1007:
			return QueryUserProfileAck.Parser.ParseFrom(data, offset, len);
		case 1051:
			return LeaderboardQueryAck.Parser.ParseFrom(data, offset, len);
		case 1053:
			return LeaderboardQueryMemberAck.Parser.ParseFrom(data, offset, len);
		case 1101:
			return RoomJoinAck.Parser.ParseFrom(data, offset, len);
		case 1103:
			return RoomLeaveAck.Parser.ParseFrom(data, offset, len);
		case 2023:
			return CreateUserAck.Parser.ParseFrom(data, offset, len);
		case 2025:
			return EnterGameLoadAck.Parser.ParseFrom(data, offset, len);
		case 2027:
			return RandomNameAck.Parser.ParseFrom(data, offset, len);
		case 2131:
			return GmActionProcessAck.Parser.ParseFrom(data, offset, len);
		case 2133:
			return GmChatsAck.Parser.ParseFrom(data, offset, len);
		case 2135:
			return GmChatAck.Parser.ParseFrom(data, offset, len);
		case 2136:
			return GmChatNtf.Parser.ParseFrom(data, offset, len);
		case 3000:
			return CountNtf.Parser.ParseFrom(data, offset, len);
		case 3001:
			return ConditionNtf.Parser.ParseFrom(data, offset, len);
		case 3002:
			return ResetDailyNtf.Parser.ParseFrom(data, offset, len);
		case 3003:
			return DailyDataNtf.Parser.ParseFrom(data, offset, len);
		case 3004:
			return NotifyCollectionItemLimitNtf.Parser.ParseFrom(data, offset, len);
		case 3100:
			return OperationalActivityDataNtf.Parser.ParseFrom(data, offset, len);
		case 3101:
			return ActivityLevelRewardNtf.Parser.ParseFrom(data, offset, len);
		case 3103:
			return ActivityGetLevelRewardAck.Parser.ParseFrom(data, offset, len);
		case 3104:
			return ActivityDoubleDungeonNtf.Parser.ParseFrom(data, offset, len);
		case 3106:
			return ActivityDoubleDungeonRewardAck.Parser.ParseFrom(data, offset, len);
		case 3107:
			return ActivitySignInNtf.Parser.ParseFrom(data, offset, len);
		case 3109:
			return ActivitySignInChooseRewardAck.Parser.ParseFrom(data, offset, len);
		case 3111:
			return ActivitySignInRewardAck.Parser.ParseFrom(data, offset, len);
		case 3112:
			return ActivityAbyssNtf.Parser.ParseFrom(data, offset, len);
		case 3114:
			return ActivityAbyssRewardAck.Parser.ParseFrom(data, offset, len);
		case 3115:
			return ActivityCombinationNtf.Parser.ParseFrom(data, offset, len);
		case 3117:
			return ActivityCombinationRewardAck.Parser.ParseFrom(data, offset, len);
		case 3118:
			return ActivityTempleChallengeNtf.Parser.ParseFrom(data, offset, len);
		case 3119:
			return ActivityRoleTrialNtf.Parser.ParseFrom(data, offset, len);
		case 3121:
			return ActivityRoleTrialRewardAck.Parser.ParseFrom(data, offset, len);
		case 3122:
			return ActivityDailyLotteryNtf.Parser.ParseFrom(data, offset, len);
		case 3124:
			return ActivityDailyLotteryGachaAck.Parser.ParseFrom(data, offset, len);
		case 3126:
			return ActivityRefreshAck.Parser.ParseFrom(data, offset, len);
		case 3127:
			return ActivitySkinTrialNtf.Parser.ParseFrom(data, offset, len);
		case 3129:
			return ActivitySkinTrialRewardAck.Parser.ParseFrom(data, offset, len);
		case 3130:
			return ActivityTotalRechargeNtf.Parser.ParseFrom(data, offset, len);
		case 3132:
			return ActivityTotalRechargeRewardAck.Parser.ParseFrom(data, offset, len);
		case 3133:
			return ActivityKujiNtf.Parser.ParseFrom(data, offset, len);
		case 3135:
			return ActivityKujiRewardAck.Parser.ParseFrom(data, offset, len);
		case 3137:
			return ActivityKujiDrawAck.Parser.ParseFrom(data, offset, len);
		case 3138:
			return ActivityMainStoryNtf.Parser.ParseFrom(data, offset, len);
		case 3140:
			return ActivityMainStoryRewardAck.Parser.ParseFrom(data, offset, len);
		case 3141:
			return ActivityMapExploreNtf.Parser.ParseFrom(data, offset, len);
		case 3143:
			return ActivityMapExploreRewardAck.Parser.ParseFrom(data, offset, len);
		case 3144:
			return ActivityMultiDeviceNtf.Parser.ParseFrom(data, offset, len);
		case 3146:
			return ActivityMultiDeviceRewardAck.Parser.ParseFrom(data, offset, len);
		case 3200:
			return ItemNtf.Parser.ParseFrom(data, offset, len);
		case 3202:
			return UseItemsAck.Parser.ParseFrom(data, offset, len);
		case 3204:
			return DelItemsAck.Parser.ParseFrom(data, offset, len);
		case 3205:
			return ItemGotLogsNtf.Parser.ParseFrom(data, offset, len);
		case 3207:
			return ComposeItemAck.Parser.ParseFrom(data, offset, len);
		case 3208:
			return LittleItemsNtf.Parser.ParseFrom(data, offset, len);
		case 3210:
			return UseLittleItemAck.Parser.ParseFrom(data, offset, len);
		case 3212:
			return SyncLittleItemsAck.Parser.ParseFrom(data, offset, len);
		case 3218:
			return PotionUseAck.Parser.ParseFrom(data, offset, len);
		case 3220:
			return PotionLevelUpAck.Parser.ParseFrom(data, offset, len);
		case 3222:
			return PotionUpdateAdditiveAck.Parser.ParseFrom(data, offset, len);
		case 3223:
			return PotionInfoNtf.Parser.ParseFrom(data, offset, len);
		case 3224:
			return TreasureInfoNtf.Parser.ParseFrom(data, offset, len);
		case 3226:
			return PotionRecoverUseCountAck.Parser.ParseFrom(data, offset, len);
		case 3227:
			return PotionNtf.Parser.ParseFrom(data, offset, len);
		case 3229:
			return RecycleItemsAck.Parser.ParseFrom(data, offset, len);
		case 3230:
			return PotionChangeNtf.Parser.ParseFrom(data, offset, len);
		case 3232:
			return OpenBagChestAck.Parser.ParseFrom(data, offset, len);
		case 3233:
			return ExpiredTimeLimitItemAutoUseNtf.Parser.ParseFrom(data, offset, len);
		case 3234:
			return ItemDestroyedNtf.Parser.ParseFrom(data, offset, len);
		case 3236:
			return PowerInfoQueryAck.Parser.ParseFrom(data, offset, len);
		case 3237:
			return BagChestRewardSelectCountNtf.Parser.ParseFrom(data, offset, len);
		case 3300:
			return CharacterNtf.Parser.ParseFrom(data, offset, len);
		case 3302:
			return CharacterLevelUpAck.Parser.ParseFrom(data, offset, len);
		case 3304:
			return CharacterStageAck.Parser.ParseFrom(data, offset, len);
		case 3306:
			return CharacterTakeStageRewardAck.Parser.ParseFrom(data, offset, len);
		case 3308:
			return CharacterStatusSyncAck.Parser.ParseFrom(data, offset, len);
		case 3310:
			return CharacterUpgradeSkillGroupAck.Parser.ParseFrom(data, offset, len);
		case 3312:
			return CharacterUpgradeConstellationAck.Parser.ParseFrom(data, offset, len);
		case 3314:
			return CharacterReturnConstellationAck.Parser.ParseFrom(data, offset, len);
		case 3316:
			return CharacterUpdateConstellationAck.Parser.ParseFrom(data, offset, len);
		case 3318:
			return CharacterEliteLevelUpAck.Parser.ParseFrom(data, offset, len);
		case 3320:
			return CharacterEliteResetAck.Parser.ParseFrom(data, offset, len);
		case 3322:
			return GiftToCharacterAck.Parser.ParseFrom(data, offset, len);
		case 3323:
			return CharacterChangeNtf.Parser.ParseFrom(data, offset, len);
		case 3324:
			return CharacterDependChangeNtf.Parser.ParseFrom(data, offset, len);
		case 3400:
			return WeaponNtf.Parser.ParseFrom(data, offset, len);
		case 3402:
			return WeaponWearAck.Parser.ParseFrom(data, offset, len);
		case 3404:
			return WeaponLockAck.Parser.ParseFrom(data, offset, len);
		case 3406:
			return WeaponLevelUpAck.Parser.ParseFrom(data, offset, len);
		case 3408:
			return WeaponStageAck.Parser.ParseFrom(data, offset, len);
		case 3410:
			return WeaponRefineAck.Parser.ParseFrom(data, offset, len);
		case 3500:
			return ChipNtf.Parser.ParseFrom(data, offset, len);
		case 3502:
			return ChipWearAck.Parser.ParseFrom(data, offset, len);
		case 3504:
			return ChipLockAck.Parser.ParseFrom(data, offset, len);
		case 3506:
			return ChipLevelUpAck.Parser.ParseFrom(data, offset, len);
		case 3508:
			return ChipUnloadAck.Parser.ParseFrom(data, offset, len);
		case 3510:
			return ChipDecomposeAck.Parser.ParseFrom(data, offset, len);
		case 3512:
			return ChipCancelNewFlagAck.Parser.ParseFrom(data, offset, len);
		case 3701:
			return DropItemPickItemAck.Parser.ParseFrom(data, offset, len);
		case 3702:
			return DropItemAddNtf.Parser.ParseFrom(data, offset, len);
		case 3704:
			return DropItemPickPackageAck.Parser.ParseFrom(data, offset, len);
		case 3901:
			return RecordLastPosAck.Parser.ParseFrom(data, offset, len);
		case 3903:
			return RecordSpawnPosAck.Parser.ParseFrom(data, offset, len);
		case 3907:
			return ReplacMissionTrackingAck.Parser.ParseFrom(data, offset, len);
		case 3915:
			return EscModifyNicknameAck.Parser.ParseFrom(data, offset, len);
		case 3917:
			return EscModifySignatureAck.Parser.ParseFrom(data, offset, len);
		case 3919:
			return EscModifyAvatarAck.Parser.ParseFrom(data, offset, len);
		case 3920:
			return EscAvatarNtf.Parser.ParseFrom(data, offset, len);
		case 3922:
			return SavePlayingMusicAck.Parser.ParseFrom(data, offset, len);
		case 3924:
			return SyncGameInfoAck.Parser.ParseFrom(data, offset, len);
		case 3926:
			return RecordCheckPosAck.Parser.ParseFrom(data, offset, len);
		case 3928:
			return ChangeNickNameAck.Parser.ParseFrom(data, offset, len);
		case 3930:
			return PublicChatAck.Parser.ParseFrom(data, offset, len);
		case 3931:
			return PublicChatNtf.Parser.ParseFrom(data, offset, len);
		case 3933:
			return SyncSettingOptionAck.Parser.ParseFrom(data, offset, len);
		case 3937:
			return RecordTmpArchivePosAck.Parser.ParseFrom(data, offset, len);
		case 3939:
			return ChangeGenderAck.Parser.ParseFrom(data, offset, len);
		case 3941:
			return EscModifyAvatarFrameAck.Parser.ParseFrom(data, offset, len);
		case 3942:
			return EscAvatarFrameNtf.Parser.ParseFrom(data, offset, len);
		case 3944:
			return EscModifyTitleAck.Parser.ParseFrom(data, offset, len);
		case 3945:
			return EscTitleNtf.Parser.ParseFrom(data, offset, len);
		case 3947:
			return EscModifyShowCharacterAck.Parser.ParseFrom(data, offset, len);
		case 4001:
			return MissionUpdateStateAck.Parser.ParseFrom(data, offset, len);
		case 4002:
			return MissionNtf.Parser.ParseFrom(data, offset, len);
		case 4004:
			return AcceptMissionAck.Parser.ParseFrom(data, offset, len);
		case 4006:
			return MissionMonsterDieAck.Parser.ParseFrom(data, offset, len);
		case 4008:
			return MissionUpdateBluePrintAck.Parser.ParseFrom(data, offset, len);
		case 4010:
			return MissionApplyItemAck.Parser.ParseFrom(data, offset, len);
		case 4011:
			return MissionRNtf.Parser.ParseFrom(data, offset, len);
		case 4012:
			return NewMissionRNtf.Parser.ParseFrom(data, offset, len);
		case 4013:
			return MissionStateUpdateNtf.Parser.ParseFrom(data, offset, len);
		case 4015:
			return MissionStateUpdateAck.Parser.ParseFrom(data, offset, len);
		case 4016:
			return MissionConditionStateNtf.Parser.ParseFrom(data, offset, len);
		case 4018:
			return MissionConditionUpdateAck.Parser.ParseFrom(data, offset, len);
		case 4019:
			return MissionFlowUpdateNtf.Parser.ParseFrom(data, offset, len);
		case 4021:
			return MissionAcceptAck.Parser.ParseFrom(data, offset, len);
		case 4022:
			return MissionExpireNtf.Parser.ParseFrom(data, offset, len);
		case 4023:
			return MissionConditionActionPairCompleteNtf.Parser.ParseFrom(data, offset, len);
		case 4024:
			return MissionFlowCompleteNtf.Parser.ParseFrom(data, offset, len);
		case 4025:
			return MissionTrackingNtf.Parser.ParseFrom(data, offset, len);
		case 4027:
			return MissionRAcceptAck.Parser.ParseFrom(data, offset, len);
		case 4029:
			return MissionRUpdateFlowAck.Parser.ParseFrom(data, offset, len);
		case 4031:
			return MissionRConditionUpdateAck.Parser.ParseFrom(data, offset, len);
		case 4033:
			return MissionRActionUpdateAck.Parser.ParseFrom(data, offset, len);
		case 4035:
			return MissionRUpdateStateAck.Parser.ParseFrom(data, offset, len);
		case 4101:
			return FishSetupAck.Parser.ParseFrom(data, offset, len);
		case 4103:
			return FishStartAck.Parser.ParseFrom(data, offset, len);
		case 4105:
			return FishAck.Parser.ParseFrom(data, offset, len);
		case 4200:
			return HandbookInfoNtf.Parser.ParseFrom(data, offset, len);
		case 4201:
			return HandbookNtf.Parser.ParseFrom(data, offset, len);
		case 4203:
			return HandbookUpdateAck.Parser.ParseFrom(data, offset, len);
		case 4250:
			return ArchiveNtf.Parser.ParseFrom(data, offset, len);
		case 4251:
			return ArchiveChangeNtf.Parser.ParseFrom(data, offset, len);
		case 4253:
			return ArchiveUpdateAck.Parser.ParseFrom(data, offset, len);
		case 4555:
			return ArchiveReadAck.Parser.ParseFrom(data, offset, len);
		case 4301:
			return RecipeMakeAck.Parser.ParseFrom(data, offset, len);
		case 4400:
			return AssistNtf.Parser.ParseFrom(data, offset, len);
		case 4401:
			return AssistSkinNtf.Parser.ParseFrom(data, offset, len);
		case 4403:
			return AssistDyeingAck.Parser.ParseFrom(data, offset, len);
		case 4405:
			return AssistSetupAck.Parser.ParseFrom(data, offset, len);
		case 4407:
			return AssistEquipAck.Parser.ParseFrom(data, offset, len);
		case 4500:
			return MapCustomFlagNtf.Parser.ParseFrom(data, offset, len);
		case 4502:
			return MapSetupCustomFlagAck.Parser.ParseFrom(data, offset, len);
		case 4504:
			return MapDelCustomFlagAck.Parser.ParseFrom(data, offset, len);
		case 4505:
			return ServiceSaveStateNtf.Parser.ParseFrom(data, offset, len);
		case 4506:
			return ServiceBehaveNtf.Parser.ParseFrom(data, offset, len);
		case 4508:
			return LightMapBlockAck.Parser.ParseFrom(data, offset, len);
		case 4509:
			return LightedMapBlocksNtf.Parser.ParseFrom(data, offset, len);
		case 4511:
			return MapViewLogAck.Parser.ParseFrom(data, offset, len);
		case 4512:
			return MapViewNtf.Parser.ParseFrom(data, offset, len);
		case 4514:
			return MapViewCompleteLayerAck.Parser.ParseFrom(data, offset, len);
		case 4516:
			return SceneSwitchAck.Parser.ParseFrom(data, offset, len);
		case 4518:
			return MapModifyCustomFlagTypeAck.Parser.ParseFrom(data, offset, len);
		case 4520:
			return MapSetupTracePointAck.Parser.ParseFrom(data, offset, len);
		case 4522:
			return MapFetchCustomFlagInfoAck.Parser.ParseFrom(data, offset, len);
		case 4523:
			return MapTrancePointNtf.Parser.ParseFrom(data, offset, len);
		case 4524:
			return MapAreaDivinePupilsNtf.Parser.ParseFrom(data, offset, len);
		case 4526:
			return MapSubmitDivinePupilAck.Parser.ParseFrom(data, offset, len);
		case 4528:
			return MapClaimDivinePupilRewardAck.Parser.ParseFrom(data, offset, len);
		case 4529:
			return MapAreaUnlockNtf.Parser.ParseFrom(data, offset, len);
		case 4531:
			return MapAreaExploreQueryAck.Parser.ParseFrom(data, offset, len);
		case 4533:
			return MapExploreClaimRewardAck.Parser.ParseFrom(data, offset, len);
		case 4535:
			return ChunkSwitchAck.Parser.ParseFrom(data, offset, len);
		case 4537:
			return SceneWorldLayerSwitchAck.Parser.ParseFrom(data, offset, len);
		case 4701:
			return TriggerInteractEventAck.Parser.ParseFrom(data, offset, len);
		case 4703:
			return SceneChallengeBossAck.Parser.ParseFrom(data, offset, len);
		case 4705:
			return SceneTakeChallengeBossRewardAck.Parser.ParseFrom(data, offset, len);
		case 4707:
			return SceneResetChallengeBossAck.Parser.ParseFrom(data, offset, len);
		case 4709:
			return TriggerTeleportPointAck.Parser.ParseFrom(data, offset, len);
		case 4711:
			return WildBossTakeRewardAck.Parser.ParseFrom(data, offset, len);
		case 4713:
			return WildBossRewardBoughtAck.Parser.ParseFrom(data, offset, len);
		case 4802:
			return RoomJoinNtf.Parser.ParseFrom(data, offset, len);
		case 4804:
			return RoomJoinConfirmAck.Parser.ParseFrom(data, offset, len);
		case 4805:
			return RoomJoinConfirmNtf.Parser.ParseFrom(data, offset, len);
		case 4807:
			return RoomKickoutAck.Parser.ParseFrom(data, offset, len);
		case 4809:
			return RoomSetPermissionAck.Parser.ParseFrom(data, offset, len);
		case 4810:
			return RoomNtf.Parser.ParseFrom(data, offset, len);
		case 4812:
			return RoomCreateAck.Parser.ParseFrom(data, offset, len);
		case 4814:
			return RoomSyncAck.Parser.ParseFrom(data, offset, len);
		case 4815:
			return RoomForwardingMessageNtf.Parser.ParseFrom(data, offset, len);
		case 4818:
			return RoomInfoAck.Parser.ParseFrom(data, offset, len);
		case 4901:
			return SystemOpenAck.Parser.ParseFrom(data, offset, len);
		case 4902:
			return SystemOpenNtf.Parser.ParseFrom(data, offset, len);
		case 4904:
			return SystemTakeLevelRewardAck.Parser.ParseFrom(data, offset, len);
		case 4905:
			return SystemTakeLevelRewardNtf.Parser.ParseFrom(data, offset, len);
		case 4907:
			return SystemGuideTakeChapterRewardAck.Parser.ParseFrom(data, offset, len);
		case 4909:
			return SystemReadDoneAck.Parser.ParseFrom(data, offset, len);
		case 4910:
			return SystemStatusNtf.Parser.ParseFrom(data, offset, len);
		case 4911:
			return SystemStatusChangeNtf.Parser.ParseFrom(data, offset, len);
		case 5001:
			return ChangeWorldLevelAck.Parser.ParseFrom(data, offset, len);
		case 5002:
			return OperationTimeStampsNtf.Parser.ParseFrom(data, offset, len);
		case 5003:
			return ProgressNtf.Parser.ParseFrom(data, offset, len);
		case 5005:
			return DrawCardAck.Parser.ParseFrom(data, offset, len);
		case 5007:
			return DrawCardChooseItemAck.Parser.ParseFrom(data, offset, len);
		case 5009:
			return DestroyAck.Parser.ParseFrom(data, offset, len);
		case 5011:
			return RedeemCodeUseAck.Parser.ParseFrom(data, offset, len);
		case 5013:
			return GachaCardDrawAck.Parser.ParseFrom(data, offset, len);
		case 5015:
			return GachaQueryHistoryAck.Parser.ParseFrom(data, offset, len);
		case 5016:
			return GachaPoolDataNtf.Parser.ParseFrom(data, offset, len);
		case 5017:
			return GachaPoolShareDataChangeNtf.Parser.ParseFrom(data, offset, len);
		case 5019:
			return GachaExchangeFinalGuaranteedAck.Parser.ParseFrom(data, offset, len);
		case 5021:
			return GachaExchangeAccumulativeRewardAck.Parser.ParseFrom(data, offset, len);
		case 5022:
			return TipNoticeNtf.Parser.ParseFrom(data, offset, len);
		case 5023:
			return ClientUpdateNtf.Parser.ParseFrom(data, offset, len);
		case 5025:
			return GachaExchangeTicketAck.Parser.ParseFrom(data, offset, len);
		case 5026:
			return NewNoticeNtf.Parser.ParseFrom(data, offset, len);
		case 5027:
			return TaskNtf.Parser.ParseFrom(data, offset, len);
		case 5029:
			return TempArchiveUpdateAck.Parser.ParseFrom(data, offset, len);
		case 5030:
			return GoodsNtf.Parser.ParseFrom(data, offset, len);
		case 5031:
			return AddGoodsNtf.Parser.ParseFrom(data, offset, len);
		case 5032:
			return DelGoodsNtf.Parser.ParseFrom(data, offset, len);
		case 5033:
			return TaskGroupNtf.Parser.ParseFrom(data, offset, len);
		case 5034:
			return ClientModuleComponentStateNtf.Parser.ParseFrom(data, offset, len);
		case 5035:
			return ClientModuleClientModuleComponentStateChangeNtf.Parser.ParseFrom(data, offset, len);
		case 5036:
			return GachaPoolEffectiveInfoNtf.Parser.ParseFrom(data, offset, len);
		case 5037:
			return TipsNtf.Parser.ParseFrom(data, offset, len);
		case 5039:
			return ChangeSkinAck.Parser.ParseFrom(data, offset, len);
		case 5040:
			return SkinAddNtf.Parser.ParseFrom(data, offset, len);
		case 5041:
			return MonthlyPassPurchaseNtf.Parser.ParseFrom(data, offset, len);
		case 5042:
			return MonthlyPassDailyRewardNtf.Parser.ParseFrom(data, offset, len);
		case 5044:
			return MonthlyPassRecordPopAck.Parser.ParseFrom(data, offset, len);
		case 5045:
			return MonthlyPassSyncNtf.Parser.ParseFrom(data, offset, len);
		case 5047:
			return GachaExchangeMilestoneRewardAck.Parser.ParseFrom(data, offset, len);
		case 5048:
			return SkinSyncNtf.Parser.ParseFrom(data, offset, len);
		case 5050:
			return PlayerDeadAck.Parser.ParseFrom(data, offset, len);
		case 5051:
			return BloodStainNotify.Parser.ParseFrom(data, offset, len);
		case 5053:
			return SetBloodStainEnableAck.Parser.ParseFrom(data, offset, len);
		case 5055:
			return BloodStainInteractAck.Parser.ParseFrom(data, offset, len);
		case 5057:
			return ChangeEffectDressAck.Parser.ParseFrom(data, offset, len);
		case 5058:
			return EffectDressAddNtf.Parser.ParseFrom(data, offset, len);
		case 5059:
			return EffectDressSyncNtf.Parser.ParseFrom(data, offset, len);
		case 5061:
			return PowerExchangeAck.Parser.ParseFrom(data, offset, len);
		case 5063:
			return GachaTargetSelectAck.Parser.ParseFrom(data, offset, len);
		case 5065:
			return GachaTargetCancelAck.Parser.ParseFrom(data, offset, len);
		case 5101:
			return MailChangeStateAck.Parser.ParseFrom(data, offset, len);
		case 5103:
			return MailChangeTagAck.Parser.ParseFrom(data, offset, len);
		case 5105:
			return MailOpenBoxAck.Parser.ParseFrom(data, offset, len);
		case 5106:
			return MailNtf.Parser.ParseFrom(data, offset, len);
		case 5107:
			return MailHasNewNtf.Parser.ParseFrom(data, offset, len);
		case 5109:
			return MailUnlockAck.Parser.ParseFrom(data, offset, len);
		case 5201:
			return RaidEnterAck.Parser.ParseFrom(data, offset, len);
		case 5206:
			return RaidTakeRewardsAck.Parser.ParseFrom(data, offset, len);
		case 5208:
			return RaidLeaveAck.Parser.ParseFrom(data, offset, len);
		case 5209:
			return RaidNtf.Parser.ParseFrom(data, offset, len);
		case 5211:
			return RaidRechallengeAck.Parser.ParseFrom(data, offset, len);
		case 5213:
			return RaidPlayerDeadAck.Parser.ParseFrom(data, offset, len);
		case 5215:
			return RaidSweepAck.Parser.ParseFrom(data, offset, len);
		case 5217:
			return RaidFailureAck.Parser.ParseFrom(data, offset, len);
		case 5251:
			return TrainingGroundEnterAck.Parser.ParseFrom(data, offset, len);
		case 5253:
			return TrainingGroundLeaveAck.Parser.ParseFrom(data, offset, len);
		case 5300:
			return ShopNtf.Parser.ParseFrom(data, offset, len);
		case 5302:
			return ShopBuyCommodityAck.Parser.ParseFrom(data, offset, len);
		case 5303:
			return DiamondDataNtf.Parser.ParseFrom(data, offset, len);
		case 5304:
			return BundleDataNtf.Parser.ParseFrom(data, offset, len);
		case 5306:
			return ExchangeFreeDiamondAck.Parser.ParseFrom(data, offset, len);
		case 5308:
			return ExchangeCommodityAck.Parser.ParseFrom(data, offset, len);
		case 5401:
			return PowerBuyAck.Parser.ParseFrom(data, offset, len);
		case 5501:
			return CreatOrderAck.Parser.ParseFrom(data, offset, len);
		case 5503:
			return PayActionProcessAck.Parser.ParseFrom(data, offset, len);
		case 5504:
			return OrderShipNtf.Parser.ParseFrom(data, offset, len);
		case 5506:
			return OrderShipDisplayedAck.Parser.ParseFrom(data, offset, len);
		case 5601:
			return AbyssChallengeStageAck.Parser.ParseFrom(data, offset, len);
		case 5603:
			return AbyssCompleteSubStageAck.Parser.ParseFrom(data, offset, len);
		case 5605:
			return AbyssTakeRewardAck.Parser.ParseFrom(data, offset, len);
		case 5608:
			return AbyssLeaveAck.Parser.ParseFrom(data, offset, len);
		case 5609:
			return AbyssNtf.Parser.ParseFrom(data, offset, len);
		case 5611:
			return AbyssRechallengeAck.Parser.ParseFrom(data, offset, len);
		case 5613:
			return AbyssFailureAck.Parser.ParseFrom(data, offset, len);
		case 5701:
			return AchievementTakeRewardAck.Parser.ParseFrom(data, offset, len);
		case 5703:
			return AchievementTakeGroupRewardAck.Parser.ParseFrom(data, offset, len);
		case 5705:
			return AchievementSyncInfoAck.Parser.ParseFrom(data, offset, len);
		case 5706:
			return AchievementNtf.Parser.ParseFrom(data, offset, len);
		case 5709:
			return AchievementCompleteAck.Parser.ParseFrom(data, offset, len);
		case 5711:
			return AchievementChangeTagAck.Parser.ParseFrom(data, offset, len);
		case 5713:
			return AchievementRecordConversationAck.Parser.ParseFrom(data, offset, len);
		case 5715:
			return AchievementRecordConversationOptionAck.Parser.ParseFrom(data, offset, len);
		case 5717:
			return AchievementRewardAck.Parser.ParseFrom(data, offset, len);
		case 5719:
			return AchievementGroupRewardAck.Parser.ParseFrom(data, offset, len);
		case 5720:
			return AchievementInfoNtf.Parser.ParseFrom(data, offset, len);
		case 5801:
			return CookAck.Parser.ParseFrom(data, offset, len);
		case 5803:
			return CookResetMinorBuffAck.Parser.ParseFrom(data, offset, len);
		case 5805:
			return CookSaveCustomMenuAck.Parser.ParseFrom(data, offset, len);
		case 5807:
			return CookDelCustomMenuAck.Parser.ParseFrom(data, offset, len);
		case 5808:
			return CookNtf.Parser.ParseFrom(data, offset, len);
		case 5810:
			return CookModifyCustomMenuNameAck.Parser.ParseFrom(data, offset, len);
		case 5900:
			return GuideLogsNtf.Parser.ParseFrom(data, offset, len);
		case 5902:
			return GuideLogsInterfaceAck.Parser.ParseFrom(data, offset, len);
		case 5904:
			return GuideTriggerAck.Parser.ParseFrom(data, offset, len);
		case 5906:
			return GuideReadAck.Parser.ParseFrom(data, offset, len);
		case 5908:
			return GuideUnlockAck.Parser.ParseFrom(data, offset, len);
		case 5910:
			return GuideCompleteAck.Parser.ParseFrom(data, offset, len);
		case 5911:
			return GuideChangeNtf.Parser.ParseFrom(data, offset, len);
		case 6001:
			return AnswerQuestionAck.Parser.ParseFrom(data, offset, len);
		case 6002:
			return AnswerQuestionsNtf.Parser.ParseFrom(data, offset, len);
		case 6003:
			return QuestionnaireNtf.Parser.ParseFrom(data, offset, len);
		case 6005:
			return QuestionnaireReadAck.Parser.ParseFrom(data, offset, len);
		case 6101:
			return FriendOperateAck.Parser.ParseFrom(data, offset, len);
		case 6103:
			return FriendSearchAck.Parser.ParseFrom(data, offset, len);
		case 6104:
			return FriendsNtf.Parser.ParseFrom(data, offset, len);
		case 6201:
			return HandbookDailyMissionClaimRewardAck.Parser.ParseFrom(data, offset, len);
		case 6203:
			return HandbookDailyActivePtClaimRewardAck.Parser.ParseFrom(data, offset, len);
		case 6205:
			return HandbookGrowthGuideMissionClaimRewardAck.Parser.ParseFrom(data, offset, len);
		case 6207:
			return HandbookGrowthGuideChapterClaimRewardAck.Parser.ParseFrom(data, offset, len);
		case 6300:
			return RedPointNtf.Parser.ParseFrom(data, offset, len);
		case 6302:
			return RedPointSetAck.Parser.ParseFrom(data, offset, len);
		case 6400:
			return RogueInfoNtf.Parser.ParseFrom(data, offset, len);
		case 6402:
			return RogueUnlockTalentTreeCodeAck.Parser.ParseFrom(data, offset, len);
		case 6404:
			return RogueUpdateTalentTreeNodeAck.Parser.ParseFrom(data, offset, len);
		case 6406:
			return RogueChallengeAck.Parser.ParseFrom(data, offset, len);
		case 6408:
			return RogueEnterNextRoomAck.Parser.ParseFrom(data, offset, len);
		case 6410:
			return RogueBuyItemAck.Parser.ParseFrom(data, offset, len);
		case 6412:
			return RogueRecycleItemAck.Parser.ParseFrom(data, offset, len);
		case 6414:
			return RogueHangGameAck.Parser.ParseFrom(data, offset, len);
		case 6416:
			return RogueContinueGameAck.Parser.ParseFrom(data, offset, len);
		case 6418:
			return RogueFinishGameAck.Parser.ParseFrom(data, offset, len);
		case 6420:
			return RogueCoinRewardAck.Parser.ParseFrom(data, offset, len);
		case 6421:
			return RogueCoinNtf.Parser.ParseFrom(data, offset, len);
		case 6423:
			return RogueTeamChangeAck.Parser.ParseFrom(data, offset, len);
		case 6425:
			return RoguePickUpItemAck.Parser.ParseFrom(data, offset, len);
		case 6427:
			return RogueModifyCoinAck.Parser.ParseFrom(data, offset, len);
		case 6429:
			return RogueEnterRoomAck.Parser.ParseFrom(data, offset, len);
		case 6430:
			return RogueTalentTreeNtf.Parser.ParseFrom(data, offset, len);
		case 6432:
			return RogueSetRoomFinishedAck.Parser.ParseFrom(data, offset, len);
		case 6434:
			return RogueGmNextRoomAck.Parser.ParseFrom(data, offset, len);
		case 6436:
			return RogueGmAddItemAck.Parser.ParseFrom(data, offset, len);
		case 6500:
			return AssistantNpcNtf.Parser.ParseFrom(data, offset, len);
		case 6502:
			return AssistantNpcHelpAck.Parser.ParseFrom(data, offset, len);
		case 6504:
			return AssistantNpcFinishAck.Parser.ParseFrom(data, offset, len);
		case 6600:
			return EquipInfoNtf.Parser.ParseFrom(data, offset, len);
		case 6601:
			return GemInfoNtf.Parser.ParseFrom(data, offset, len);
		case 6603:
			return EquipCreateAck.Parser.ParseFrom(data, offset, len);
		case 6605:
			return EquipEnhanceAck.Parser.ParseFrom(data, offset, len);
		case 6607:
			return EquipDismantleAck.Parser.ParseFrom(data, offset, len);
		case 6609:
			return EquipWearAck.Parser.ParseFrom(data, offset, len);
		case 6611:
			return EquipGemOperateAck.Parser.ParseFrom(data, offset, len);
		case 6613:
			return EquipLockAck.Parser.ParseFrom(data, offset, len);
		case 6615:
			return GemFusionAck.Parser.ParseFrom(data, offset, len);
		case 6617:
			return GemLockAck.Parser.ParseFrom(data, offset, len);
		case 6700:
			return TempleInfoNtf.Parser.ParseFrom(data, offset, len);
		case 6702:
			return TempleUnlockAck.Parser.ParseFrom(data, offset, len);
		case 6704:
			return TempleChallengeAck.Parser.ParseFrom(data, offset, len);
		case 6706:
			return TempleRechallengeAck.Parser.ParseFrom(data, offset, len);
		case 6708:
			return TempleLeaveAck.Parser.ParseFrom(data, offset, len);
		case 6710:
			return TempleCompleteStageAck.Parser.ParseFrom(data, offset, len);
		case 6712:
			return TempleTakeStarRewardAck.Parser.ParseFrom(data, offset, len);
		case 6714:
			return TempleFailureAck.Parser.ParseFrom(data, offset, len);
		case 6716:
			return TempleSelectBuffAck.Parser.ParseFrom(data, offset, len);
		case 6800:
			return ContactNtf.Parser.ParseFrom(data, offset, len);
		case 6801:
			return ContactCharacterMessageNtf.Parser.ParseFrom(data, offset, len);
		case 6802:
			return ContactCharacterSessionNtf.Parser.ParseFrom(data, offset, len);
		case 6804:
			return ContactChooseOptionAck.Parser.ParseFrom(data, offset, len);
		case 6806:
			return ContactChatWithPlayerAck.Parser.ParseFrom(data, offset, len);
		case 6807:
			return ContactPlayerMessageNtf.Parser.ParseFrom(data, offset, len);
		case 6900:
			return TeamInfoNtf.Parser.ParseFrom(data, offset, len);
		case 6902:
			return ReplacePresetTeamAck.Parser.ParseFrom(data, offset, len);
		case 6904:
			return SavePresetTeamsAck.Parser.ParseFrom(data, offset, len);
		case 6906:
			return ModifyPresetTeamNameAck.Parser.ParseFrom(data, offset, len);
		case 6908:
			return DelPresetTeamAck.Parser.ParseFrom(data, offset, len);
		case 6910:
			return RecordBattleTeamAck.Parser.ParseFrom(data, offset, len);
		case 6912:
			return UpdateUsageTeamAck.Parser.ParseFrom(data, offset, len);
		case 7001:
			return LoungeEnterAck.Parser.ParseFrom(data, offset, len);
		case 7003:
			return LoungeTriggerPointAck.Parser.ParseFrom(data, offset, len);
		case 7005:
			return LoungeLeaveAck.Parser.ParseFrom(data, offset, len);
		case 7100:
			return BattlePassNtf.Parser.ParseFrom(data, offset, len);
		case 7102:
			return BattlePassBuyLevelAck.Parser.ParseFrom(data, offset, len);
		case 7104:
			return BattlePassClaimTaskAck.Parser.ParseFrom(data, offset, len);
		case 7106:
			return BattlePassClaimRewardAck.Parser.ParseFrom(data, offset, len);
		case 7200:
			return VocabularyNtf.Parser.ParseFrom(data, offset, len);
		case 7202:
			return VocabularyUnlockContentAck.Parser.ParseFrom(data, offset, len);
		case 7204:
			return VocabularyReadContentAck.Parser.ParseFrom(data, offset, len);
		case 7206:
			return VocabularyRememberGroupStateAck.Parser.ParseFrom(data, offset, len);
		case 7300:
			return ReviewPromptNtf.Parser.ParseFrom(data, offset, len);
		case 7302:
			return ReviewPromptDisplayedAck.Parser.ParseFrom(data, offset, len);
		case 10001:
			return MatchMsgStart.Parser.ParseFrom(data, offset, len);
		case 10003:
			return MatchForwardMessageAck.Parser.ParseFrom(data, offset, len);
		case 10004:
			return MatchForwardMessageNtf.Parser.ParseFrom(data, offset, len);
		case 10100:
			return MatchMsgEnd.Parser.ParseFrom(data, offset, len);
		default:
			Debug.LogError($"Cmd {cmdId} not exist");
			return null;
		}
	}

	internal static ushort GetCmdId(Type type)
	{
		string cachedName = type.GetCachedName();
		if (s_Map.TryGetValue(cachedName, out var value))
		{
			return value;
		}
		Debug.LogError("Cmd " + cachedName + " not exist");
		return 0;
	}
}
