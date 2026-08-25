local RPC = System.RPC
local MsgPack = require("cmsgpack")
local Lz4 = require("lz4")
local RoleResponse, Super = System.NewClass("Role", ProtoBase)

function RoleResponse:Startup()
  Super.Startup(self)
end

function RoleResponse:Shutdown()
  Super.Shutdown(self)
end

function RoleResponse:ClearData()
  Super.ClearData(self)
end

RPC("T")

function RoleResponse:OnSyncRoleData(data)
  Logger.Proto("RoleResponse:OnSyncRoleData: data = %s", table.tostring(data))
  self:Dispatch("OnSyncRoleData", data)
end

RPC("T")

function RoleResponse:OnSyncRoleIcon(data)
  Logger.Proto("RoleResponse:OnSyncRoleIcon: data = %s", table.tostring(data))
  self:Dispatch("OnSyncRoleIcon", data)
end

RPC("T")

function RoleResponse:OnSyncEnergy(data)
  Logger.Proto("RoleResponse:OnSyncEnergy: data = %s", table.tostring(data))
  self:Dispatch("OnSyncEnergy", data)
end

RPC("T")

function RoleResponse:OnSyncTicket(data)
  Logger.Proto("RoleResponse:OnSyncTicket: data = %s", table.tostring(data))
  self:Dispatch("OnSyncTicket", data)
end

RPC("T")

function RoleResponse:OnSyncLives(data)
  Logger.Proto("RoleResponse:OnSyncLives: data = %s", table.tostring(data))
  self:Dispatch("OnSyncLives", data)
end

RPC("T")

function RoleResponse:OnSyncPlayerLevelExp(data)
  Logger.Proto("RoleResponse:OnSyncPlayerLevelExp: data = %s", table.tostring(data))
  self:Dispatch("OnSyncPlayerLevelExp", data)
end

RPC("T")

function RoleResponse:OnSyncDefaultCard(data)
  Logger.Proto("RoleResponse:OnSyncDefaultCard: data = %s", table.tostring(data))
  self:Dispatch("OnSyncDefaultCard", data)
end

RPC("T")

function RoleResponse:OnSyncItems(data)
  Logger.Proto("RoleResponse:OnSyncItems: data = %s", table.tostring(data), debug.traceback())
  self:Dispatch("OnSyncItems", data)
end

RPC("T")

function RoleResponse:OnInitItems(data)
  Logger.Proto("RoleResponse:OnInitItems: data count = %s", #data)
  self:Dispatch("OnInitItems", data)
end

RPC("T")

function RoleResponse:OnSyncFeatureUnlock(data)
  Logger.Proto("RoleResponse:OnSyncFeatureUnlock: data = %s", table.tostring(data))
  self:Dispatch("OnSyncFeatureUnlock", data)
end

RPC("T")

function RoleResponse:OnSyncSchoolTower(data)
  Logger.Proto("RoleResponse:OnSyncSchoolTower:data = %s", table.tostring(data))
  self:Dispatch("OnSyncSchoolTower", data)
end

RPC("T")

function RoleResponse:OnSyncSwitchData(data)
  Logger.Proto("RoleResponse:OnSyncSwitchData: data = %s", table.tostring(data))
  self:Dispatch("OnSyncSwitchData", data)
end

RPC("T")

function RoleResponse:OnSyncSocialData(data)
  Logger.Proto("RoleResponse:OnSyncSocialData: data = %s", table.tostring(data))
  self:Dispatch("OnSyncSocialData", data)
end

RPC("T")

function RoleResponse:OnSyncSettingData(data)
  Logger.Proto("RoleResponse:OnSyncSettingData: data = %s", table.tostring(data))
  self:Dispatch("OnSyncSettingData", data)
end

RPC("T")

function RoleResponse:OnMoreGameInvite(data)
  Logger.Proto("RoleResponse:OnMoreGameInvite: data = %s", table.tostring(data))
  self:Dispatch("OnMoreGameInvite", data)
end

RPC("T")

function RoleResponse:OnSyncSaveAccountJson(data)
  Logger.Proto("RoleResponse:OnSyncSaveAccountJson: data = %s", table.tostring(data))
  self:Dispatch("OnSyncSaveAccountJson", data)
end

RPC("T")

function RoleResponse:OnSyncBattleFrontData(data)
  Logger.Proto("RoleResponse:OnSyncBattleFrontData: data = %s", table.tostring(data))
  self:Dispatch("OnSyncBattleFrontData", data)
end

RPC("T")

function RoleResponse:OnSyncNpc(data)
  Logger.Proto("RoleResponse:OnSyncNpc: data = %s", table.tostring(data))
  self:Dispatch("OnSyncNpc", data)
end

RPC("T")

function RoleResponse:OnReplaceRole(data)
  Logger.Proto("RoleResponse:OnReplaceRole: data = %s", table.tostring(data))
  self:Dispatch("OnReplaceRole", data)
end

RPC("T")

function RoleResponse:OnServerNotice(data)
  Logger.Proto("RoleResponse:OnServerNotice: data = %s", table.tostring(data))
  self:Dispatch("OnServerNotice", data)
end

RPC("T")

function RoleResponse:OnRedPointNotice(data)
  Logger.Proto("RoleResponse:OnRedPointNotice: data = %s", table.tostring(data))
  self:Dispatch("OnRedPointNotice", data)
end

RPC("T")

function RoleResponse:OnRemoveRedPointNotice(data)
  Logger.Proto("RoleResponse:OnRemoveRedPointNotice: data = %s", table.tostring(data))
  self:Dispatch("OnRemoveRedPointNotice", data)
end

RPC("T")

function RoleResponse:OnSyncBuildingProductionItem(data)
  Logger.Proto("RoleResponse:OnSyncBuildingProductionItem: data = %s", table.tostring(data))
  self:Dispatch("OnSyncBuildingProductionItem", data)
end

RPC("T")

function RoleResponse:OnRefreshTimeNotice(data)
  Logger.Proto("RoleResponse:OnRefreshTimeNotice: data = %s", table.tostring(data))
  self:Dispatch("OnRefreshTimeNotice", data)
end

RPC("T")

function RoleResponse:OnSyncRolesAttrs(data)
  Logger.Proto("RoleResponse:OnSyncRolesAttrs: data =", table.tostring(data))
  self:Dispatch("OnSyncRolesAttrs", data)
end

RPC("T")

function RoleResponse:OnNoticeShowNewAwaker(data)
  Logger.Proto("RoleResponse:OnNoticeShowNewAwaker: data =", table.tostring(data))
  self:Dispatch("OnNoticeShowNewAwaker", data)
end

RPC("T")

function RoleResponse:OnSyncRolesExp(data)
  Logger.Proto("RoleResponse:OnSyncRolesExp: data =", table.tostring(data))
  self:Dispatch("OnSyncRolesExp", data)
end

RPC("T")

function RoleResponse:OnSyncShopData(data)
  Logger.Proto("RoleResponse:OnSyncShopData: data =", table.tostring(data))
  self:Dispatch("OnSyncShopData", data)
end

RPC("T")

function RoleResponse:OnSyncRechargeData(data)
  Logger.Proto("RoleResponse:OnSyncRechargeData: data =", table.tostring(data))
  self:Dispatch("OnSyncRechargeData", data)
end

RPC("T")

function RoleResponse:OnSyncAwakerData(data)
  Logger.Proto("RoleResponse:OnSyncAwakerData: data =", table.tostring(data))
  self:Dispatch("OnSyncAwakerData", data)
end

RPC("T")

function RoleResponse:SyncEffectList(data)
  Logger.Proto("RoleResponse:SyncEffectList: data =", table.tostring(data))
  self:Dispatch("SyncEffectList", data)
end

RPC("T")

function RoleResponse:OnSyncAwakerFavorLvUpgrade(data)
  Logger.Proto("RoleResponse:OnSyncAwakerFavorLvUpGrade: data =", table.tostring(data))
  self:Dispatch("OnSyncAwakerFavorLvUpGrade", data)
end

RPC("T")

function RoleResponse:OnSyncEquips(data)
  Logger.Proto("RoleResponse:OnSyncEquips: data =", table.tostring(data))
  self:Dispatch("OnSyncEquips", data)
end

RPC("T")

function RoleResponse:OnSyncStageInfos(data)
  Logger.Proto("RoleResponse:OnSyncStageInfo: data =", table.tostring(data))
  self:Dispatch("OnSyncStageInfos", data)
end

RPC("T")

function RoleResponse:OnSyncWeekBossData(data)
  Logger.Proto("RoleResponse:OnSyncWeekBossData: data =", table.tostring(data))
  self:Dispatch("OnSyncWeekBossData", data)
end

RPC("T")

function RoleResponse:OnSyncTaskData(data)
  self:Dispatch("OnSyncTaskData", data)
end

RPC("T")

function RoleResponse:OnSyncGuideNoteData(data)
  Logger.Proto("RoleResponse:OnSyncGuideNoteData: data = %s", table.tostring(data))
  self:Dispatch("OnSyncGuideNoteData", data)
end

RPC("I", "T")

function RoleResponse:UpdateInviteeFinishTask(playerUid, taskMap)
  Logger.Proto("RoleResponse:UpdateInviteeFinishTask: playerUid = %s, taskList =", playerUid, table.tostring(taskMap))
  self:Dispatch("UpdateInviteeFinishTask", playerUid, taskMap, true)
end

RPC("T")

function RoleResponse:OnSyncCollectionChange(data)
  Logger.Proto("RoleResponse:OnSyncCollectionChange: data =", table.tostring(data))
  self:Dispatch("OnSyncCollectionChange", data)
end

RPC("T")

function RoleResponse:SyncActivityData(data)
  Logger.Proto("RoleResponse:SyncActivityData: data =", table.tostring(data))
  self:Dispatch("SyncActivityData", data)
end

RPC("T")

function RoleResponse:SyncActivityWorldBossPass(data)
  Logger.Proto("RoleResponse:SyncActivityWorldBossPass: data =", table.tostring(data))
  self:Dispatch("SyncActivityWorldBossPass", data)
end

RPC("I")

function RoleResponse:OnSyncShareData(data)
  Logger.Proto("RoleResponse:OnSyncShareData: data =", data)
  self:Dispatch("OnSyncShareData", data)
end

RPC("T")

function RoleResponse:OnSyncTutorialEntry(data)
  Logger.Proto("RoleResponse:OnSyncTutorialEntry: data =", data)
  self:Dispatch("OnSyncTutorialEntry", data)
end

RPC("T")

function RoleResponse:OnUnlockDailyChallengeTalent(data)
  Logger.Proto("%s:OnUnlockDailyChallengeTalent: data =", self.__name, table.tostring(data))
end

RPC("T")

function RoleResponse:OnSyncPools(data)
  Logger.Proto("%s:OnSyncPools: data =%s", self.__name, table.tostring(data))
  self:Dispatch("OnSyncPools", data)
end

RPC("T")

function RoleResponse:OnSyncEmail(data)
  Logger.Proto("%s:OnSyncEmail: data =%s", self.__name, table.tostring(data))
  self:Dispatch("OnSyncEmail", data)
end

RPC("T")

function RoleResponse:OnGmNotice(data)
  Logger.Info("RoleResponse:OnGmNotice: data = %s", table.tostring(data))
  if data.cmd and data.cmd == "GmTrainTrinket" and data.data and data.data.showMsg then
    Alert.Show(20003, nil, nil, data.data.title or "洗练统计", data.data.showMsg)
  end
end

RPC("T")

function RoleResponse:OnSyncBPData(data)
  Logger.Info("RoleResponse:OnSyncBPData: data = %s", table.tostring(data))
  self:Dispatch("OnSyncBPData", data)
end

RPC("T")

function RoleResponse:OnUpdatePvpSeasonCollectTimes(data)
  Logger.Info("RoleResponse:OnUpdatePvpSeasonCollectTimes : data = %s", table.tostring(data))
  PvPSeasonDataUtils.InitPvpCollectTimesList(data[1])
  self:Dispatch("OnUpdatePvpSeasonCollectTimes ", data)
end

RPC("T")

function RoleResponse:OnOverseaCommitEvent(data)
  Logger.Info("RoleResponse:OnOverseaCommitEvent: data = %s", table.tostring(data))
  self:Dispatch("OnOverseaCommitEvent", data)
end

RPC("S")

function RoleResponse:EnterBattleReview(battleDat)
  Logger.Proto("EnterBattleReview receive server data =%s", table.tostring(battleDat))
  local battleReview = MsgPack.unpack(Lz4.decompress(battleDat))
  BattleManager.Instance:EnterSimulateBattle(battleReview.battleDat, nil)
end

RPC("T")

function RoleResponse:OnSyncExpiredItems(data)
  Logger.Proto("RoleResponse:OnSyncExpiredItems: data = %s", table.tostring(data))
  self:Dispatch("OnSyncExpiredItems", data)
end

RPC("T")

function RoleResponse:OnSyncBacktrack(data)
  self:Dispatch("OnSyncBacktrack", data)
end

RPC("T")

function RoleResponse:OnSyncMainShopGoodsRefresh(data)
  Logger.Proto("RoleResponse:OnSyncMainShopGoodsRefresh: data = %s", table.tostring(data))
  self:Dispatch("OnSyncMainShopGoodsRefresh", data)
end

RPC("T")

function RoleResponse:PvpDraftChoices(data)
  Logger.Proto("RoleResponse:PvpDraftChoices: data = %s", table.tostring(data))
  self:Dispatch("PvpDraftChoices", data)
end

RPC("T")

function RoleResponse:OnSyncPvpMatchRst(data)
  Logger.Proto("RoleResponse:OnSyncPvpMatchRst: data = %s", table.tostring(data))
  self:Dispatch("OnSyncPvpMatchRst", data)
end

RPC("T")

function RoleResponse:OnSyncMatchRejects(data)
  Logger.Proto("RoleResponse:OnSyncMatchRejects: data = %s", table.tostring(data))
  self:Dispatch("OnSyncMatchRejects", data)
end

RPC("T")

function RoleResponse:OnSyncPvpBattleSettleData(data)
  Logger.Proto("RoleResponse:OnSyncPvpBattleSettleData: data = %s", table.tostring(data))
  self:Dispatch("OnSyncPvpBattleSettleData", data)
end

RPC("T")

function RoleResponse:OnSyncPasswordData(data)
  Logger.Proto("RoleResponse:OnSyncPasswordData: data = %s", table.tostring(data))
  self:Dispatch("OnSyncPasswordData", data)
end

RPC("T")

function RoleResponse:OnPvpRankChange(data)
  Logger.Proto("RoleResponse:OnPvpRankChange: data = %s", table.tostring(data))
end

RPC("T")

function RoleResponse:OnCancelMatch(data)
  Logger.Proto("RoleResponse:OnCancelMatch: data = %s", table.tostring(data))
  self:Dispatch("OnCancelMatch", data)
end

RPC("T")

function RoleResponse:OnReceiveGood(data)
  Logger.Proto("RoleResponse:OnReceiveGood: data = %s", table.tostring(data))
  self:Dispatch("OnReceiveGood", data)
end

RPC("T")

function RoleResponse:OnSyncStatistics(data)
  Logger.Proto("RoleResponse:OnSyncStatistics: data = %s", table.tostring(data))
  for key, value in pairs(data) do
    PlayerDataUtils.SetStatsDataByKey(key, value)
  end
end

RPC("T")

function RoleResponse:OnSyncOneStat(data)
  Logger.Proto("RoleResponse:OnSyncOneStat: data = %s", table.tostring(data))
  for type, tbl in pairs(data) do
    for key, val in pairs(tbl) do
      PlayerDataUtils.SetStatsDataByKeyType(key, type, val)
    end
  end
end

RPC("T")

function RoleResponse:SyncProduceBox(data)
  self:Dispatch("SyncProduceBox", data)
end

RPC("T")

function RoleResponse:OnSyncLotteryPools(data)
  Logger.Proto("RoleResponse:OnSyncLotteryPools: data = %s", table.tostring(data))
  self:Dispatch("OnSyncLotteryPools", data)
end

RPC("B")

function RoleResponse:OnMoreGameResp(boolVal)
  Logger.Proto("RoleResponse:OnMoreGameResp: boolVal = %s", table.tostring(boolVal))
  self:Dispatch("OnMoreGameResp", boolVal)
end

RPC("T")

function RoleResponse:OnCancelMoreGameInvite(data)
  Logger.Proto("RoleResponse:OnCancelMoreGameInvite: data = %s", table.tostring(data))
  self:Dispatch("OnCancelMoreGameInvite", data)
end

RPC("T")

function RoleResponse:OnNewDialog(data)
  Logger.Proto("RoleResponse:OnNewDialog: data = %s", table.tostring(data))
  AwakerChatDataUtils.OnNewDialog(data)
end

RPC("T")

function RoleResponse:OnSyncFriendGameData(data)
  Logger.Proto("RoleResponse:OnSyncFriendGameData: data = %s", table.tostring(data))
  FriendMatchMgr.Instance:SyncFriendGameData(data)
end

RPC("T")

function RoleResponse:OnSyncCareerLevel(data)
  Logger.Proto("RoleResponse:OnSyncCareerLevel: data = %s", table.tostring(data))
  CareerLevelModel.Instance:UpdateByResponse(data)
end

RPC("T")

function RoleResponse:OnSyncHomeConversionRemainCount(data)
  Logger.Proto("RoleResponse:OnSyncHomeConversionRemainCount: data = %s", table.tostring(data))
  AlchemyCompositeExtModel.Instance:UpdateCompositeRemainCountInfo(data)
end

return RoleResponse
