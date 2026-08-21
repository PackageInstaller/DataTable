require("campaign_component_info")

function ICampaignComRequest:GetHandleCode()
  return ECampaignComHandle.ECCH_INVALID
end

function SeasonMazeSelectHardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeSelectHard
end

function SeasonMazeRoundEndReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeRoundEnd
end

function SeasonMazeRandomHandReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeRandomHand
end

function SeasonMazeChooseHandReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeChooseHand
end

function SeasonMazeClearingReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeClearing
end

function SeasonMazeGoPointReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeGoPoint
end

function SeasonMazeRoomEndReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeRoomEnd
end

function SeasonMazeBattleReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeBattle
end

function SeasonMazeEventReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeEvent
end

function SeasonMazeResourceReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeResource
end

function SeasonMazeOreReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeOre
end

function SeasonMazeBoxReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeBox
end

function SeasonMazeRoundReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeRound
end

function SeasonMazeAltarReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeAltar
end

function SeasonMazeUseOnceReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeUseOnce
end

function SeasonMazeSaveLvReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeSaveLv
end

function SeasonMazeGetSlotReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeGetSlot
end

function SeasonMazeOperaSlotReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeOperaSlot
end

function SeasonMazeGetMarketReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeGetMarket
end

function SeasonMazeOperaMarketReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeOperaMarket
end

function SeasonMazeChooseRelicReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeChooseRelic
end

function SeasonMazeNewHandReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeNewHand
end

function SeasonMazeChangeFormationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeChangeFormation
end

function SeasonMazeInitSelectReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeInitPetSelect
end

function SeasonMazeFitAutoBeadReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeFitAutoBead
end

function SeasonMazeAutoBeadComposeReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeComposeAutoBead
end

function SeasonMazeHealthyReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeHealthy
end

function SeasonMazeResurrectPetReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeResurrectPet
end

function SeasonMazePetRecruitListReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazePetRecruitList
end

function SeasonMazePetRecruitSelectReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazePetRecruitSelect
end

function SeasonMazePetRecruitResetReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazePetRecruitReset
end

function SeasonMazeSelectFullBreakPetReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeSelectFullBreakPet
end

function SeasonMazeClearAllBeadNewReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeClearAllBeadNew
end

function LineChangeFormationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleLineChangeFormationReq
end

function CompleteStoryMissionReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleLineMissionMsg
end

function CompleteStoryTreeMissionReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCompleteStoryTreeMission
end

function CombatSimulatorComponentRefreshReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCombatSimulatorComponentRefresh
end

function CombatSimulatorComponentOpenGiftReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCombatSimulatorComponentOpenGift
end

function CombatSimulatorComponentDelCartridgeReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCombatSimulatorComponentDelCartridge
end

function CompleteStorySummerIIMissionReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCompleteStorySummerIIMission
end

function SummerIISelectAffixReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSelectAffix
end

function SummerIIChangeFormationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSummerIIChangeFormationReq
end

function CamQuestTakeReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleQuestTake
end

function CamOneKeyQuestTakeReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleOneKeyTakeAll
end

function CamQuestDailyResetReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleQuestDailyReset
end

function DemoComponentReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleDemoMsg
end

function BusinessSelectReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBusinessSelectReq
end

function BusinessHarborReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBusinessHarborReq
end

function BusinessShipReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBusinessShipReq
end

function BusinessHireSeamanReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBusinessHireSeamanReq
end

function BusinessWorkSeamanReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBusinessWorkSeamanReq
end

function BusinessSailingReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBusinessSailingReq
end

function ExchangeItemComponentExchangeReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleExchangeItemComponentExchange
end

function PersonProgressComponentReceiveRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleReceiveReward
end

function PersonProgressComponentOneKeyReceiveRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandlePersonProgressOneKeyRecvRewards
end

function PersonProgressProgressReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandlePersonProgressProgressReq
end

function CumulativeLoginComponentReceiveRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleReceiveCumulativeLoginReward
end

function StoryComponentRecvRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleRecvStoryReward
end

function LotteryComponentLotteryReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleLottery
end

function MiniGameComponentMissionStoryReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleStoryMsg
end

function MiniGameComponentScoreReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleScoreMsg
end

function MiniGameComponentRecvRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleRecvRewardMsg
end

function MiniGameExploreComponentRandomLocationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleRandomRewardPostion
end

function MiniGameExploreComponentRecvRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleExploredReceiveReward
end

function MiniGameExploreComponentClearNewEquipReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleEnterExplored
end

function LVRewardComponentReceiveRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleReceiveLVReward
end

function LVRewardComponentOneKeyReceiveRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleOneKeyReceiveReward
end

function BuyGiftComponentApplyBuyReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleApplyBuyGift
end

function BackComponentRecvRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleRecvBackReward
end

function BattlefieldComponentDailyResetReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBattlefieldDailyReset
end

function BuildComponentBuildReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBuild
end

function BuildComponentStoryReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleStory
end

function BuildComponentCompleteEventReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCompleteEvent
end

function PicnicPutFoodReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandlePicnicPutFood
end

function PicnicWatchStoryReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandlePicnicStory
end

function SubjectComponentRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleRewardSubject
end

function SubjectComponentTestScoreReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleTestScoreSubject
end

function EntrustComponentCompleteReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleEntrustCompleteEvent
end

function EntrustComponentMoveEventReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleMoveCompleteEvent
end

function ChallengeSelectAffixReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleChallengeSelectAffix
end

function ChallengeClearAffixReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleClearAffix
end

function ChallengeClearNewReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleChallengeClearNewReq
end

function SeniorSkinComponentApplyShake:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleApplySeniorSkinShake
end

function TakeRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleTakeTimeRewardReward
end

function AvgSetCurrentLocationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSetCurrentLocation
end

function AvgUpdateNodeDataReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleUpdateNodeData
end

function AvgComplateEndingReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleComplateEnding
end

function AvgManualChooseReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleManualChoose
end

function AvgGainEvidenceReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleGainEvidence
end

function AvgShowEvidenceReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleShowEvidence
end

function AvgAcceptBadgeRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleGetBadgeReward
end

function PointProgressComponentReceiveRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandlePointReceiveReward
end

function PointProgressComponentOneKeyReceiveRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandlePointProgressOneKeyRecvRewards
end

function HomlandTaskComponentGetReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCMPHomelandTaskGet
end

function ChallengeChangeFormationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleChallengeChangeFormationReq
end

function BloodsuckerComponentUpgradeTalentPointReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleUpgradeTalentPoint
end

function BloodsuckerComponentSelectSkillReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSelectSkill
end

function BloodsuckerComponentResetTalentTreeReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleResetTalentTree
end

function BloodsuckerComponentChangeFormationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCompChangeFormation
end

function IdolStartPlayReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleIdolStartPlay
end

function IdolTrainReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleIdolTrain
end

function IdolCompleteEventReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleIdolCompleteEvent
end

function IdolCompleteActivityReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleIdolCompleteActivity
end

function IdolGetAchieveRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleIdolGetAchieveReward
end

function IdolComplateEndingReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleIdolComplateEnding
end

function IdolConcertFailReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleIdolConcertFail
end

function NewYearDinnerMakeFoodReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleNewYearDinnerMakeFood
end

function NewYearDinnerRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleNewYearDinnerReward
end

function SubmitMissionInfoReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSubmitMission
end

function PostStationMissionStoryReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSubmitStory
end

function PostStationGetTargetRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleGetTargetReward
end

function HandleReadMiniMailReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleReadMiniMail
end

function CCampaignEventApplyChangeFormationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleDifficultyChangeFormation
end

function CCampaignEventResetSubMissionRecordReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleDifficultyResetSubMissionRecord
end

function BounceMissionSettleReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBounceMissionSettle
end

function BounceMissionGetRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBounceMissionGetReward
end

function DetectiveSubmitItemReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleDetectiveSubmitItem
end

function DetectiveSubmitEndingReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleDetectiveSubmitEnding
end

function DetectiveAutoSaveReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleDetectiveAutoSave
end

function DetectiveReadRecordPlayReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleDetectiveReadRecordPlay
end

function PopStarChangeFormationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandlePopStarChangeFormation
end

function TurnCardOperateReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleTurnCardOperate
end

function CompleteMultiLineReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleMultiLineMissionSettle
end

function MultiLineGetRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleMultiLineMissionGetReward
end

function MultiLineSetMarkReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleMultiLineSetMark
end

function SmeltItemComponentReceiveRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleReceiveSmeltItemReward
end

function PickUpComponentReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandlePickUpCoin
end

function SubmitStoryComponentReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSubmitSimulationOperationStory
end

function UpgradeComponentReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleUpgradeArch
end

function GetArchInfosComponentReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleGetArchInfos
end

function EightPetsChangeFormationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleEightPetsChangeFormation
end

function CompleteStorySeasonMissionReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMissionMsg
end

function SeasonChangeFormationReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonChangeFormation
end

function SeasonClientDataPointReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonClientDataPoint
end

function SeasonClientDataExtReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonClientDataExt
end

function SeasonClientStageDataReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonClientStageData
end

function SeasonPointClientDataReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonPointClientData
end

function RandomLotteryComponentCostReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleReceiveRandomLotteryCost
end

function RandomLotteryComponentDrawReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleRandomLotteryComponentDraw
end

function RandomLotteryComponentDrawRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleRandomLotteryComponentDrawReward
end

function DispatchReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleDispatch
end

function GetDispatchRewardsReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleGetDispatchRewards
end

function SurveyClientDataReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSurveyClientDataReq
end

function ActionPointDataReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleActionPointData
end

function TimeLoginComponentReceiveRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleReceiveTimeLoginReward
end

function SeasonMissionTeamRecordReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMissionTeamRecord
end

function DoVoteReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleDoVote
end

function GetZonePetVoteReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleGetZoneInfo
end

function TakeCollectCardRewardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleTakeRewards
end

function DropCardsReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleDropCards
end

function SendCardReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSendCard
end

function ClearSendCardInfoReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleClearSendCardInfo
end

function PersonProgressComponentCollectReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandlePersonProgressCollect
end

function SeasonMazeRecruitRoomSelectPropReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeRecruitRoomSelectProp
end

function SeasonMazeRecruitRoomReflushReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeRecruitRoomReflush
end

function SeasonMazeRecruitRoomSelectReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeRecruitRoomSelect
end

function SeasonMazeRoomTransferReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeRoomTransfer
end

function SeasonMazeManunlBanPetReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleSeasonMazeBanPet
end

function AlchemyComponentMakeupReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleAlchemyMakeup
end

function AlchemyComponentSellReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleAlchemyShopSell
end

function AlchemyComponentBuyReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleAlchemyShopBuy
end
