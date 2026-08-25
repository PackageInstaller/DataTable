local PvPSettleData = DataCenter.pvpSettleData
local PvPSettleDataUtils = {}

function PvPSettleDataUtils.Reset()
  PvPSettleData.win = nil
  PvPSettleData.settleData = nil
  PvPSettleData.settleRewards = {}
  PvPSettleData.rankRewards = {}
  PvPSettleData.statsData = {}
  PvPSettleData.finalScore = 0
  PvPSettleData.opponentScore = 0
  PvPSettleData.pvpType = nil
  PvPSettleData.noMoreGame = nil
  PvPSettleData.isFriendGame = nil
  Logger.ReportApusInfo("Reset PvpBattleSettleData {traceback}", debug.traceback())
end

function PvPSettleDataUtils.InitByServerData(svrData)
  PvPSettleDataUtils.SetSettleData(svrData)
  PvPSettleDataUtils.SetPvpType(svrData.pvpType)
  PvPSettleDataUtils.SetSettleRewards(svrData.settleRewards)
  PvPSettleDataUtils.SetRankRewards(svrData.rankRewards)
  PvPSettleDataUtils.SetStatsData(svrData.statsData)
  PvPSettleDataUtils.SetWin(svrData.winnerId == PlayerDataUtils.GetPlayerUid())
  PvPSettleDataUtils.SetNoMoreGame(svrData.noMoreGame)
  PvPSettleDataUtils.SetIsFriendGame(svrData.isFriendGame)
  PvPSettleDataUtils.SetSettleReason(svrData.settleReason)
  PvPSettleDataUtils.SetMatchType(svrData.matchType)
end

function PvPSettleDataUtils.SetMatchType(matchType)
  PvPSettleData.matchType = matchType
end

function PvPSettleDataUtils.GetMatchType()
  return PvPSettleData.matchType
end

function PvPSettleDataUtils.GetWin()
  return PvPSettleData.win
end

function PvPSettleDataUtils.IsHaveSettleData()
  return table.next(PvPSettleData.statsData) ~= nil
end

function PvPSettleDataUtils.SetPreScore(score)
  PvPSettleData.preScore = score
end

function PvPSettleDataUtils.GetPvpPreScore()
  if PvPSettleDataUtils.GetPvpType() == PvpDefine.PvpType.Draft then
    return PvPSettleData.preDraftScore
  end
  return PvPSettleData.preScore
end

function PvPSettleDataUtils.GetSettleReason()
  return PvPSettleData.settleReason
end

function PvPSettleDataUtils.SetSettleReason(reason)
  PvPSettleData.settleReason = reason
end

function PvPSettleDataUtils.SetPreDraftScore(score)
  PvPSettleData.preDraftScore = score
end

function PvPSettleDataUtils.SetPvpType(pvpType)
  PvPSettleData.pvpType = pvpType
end

function PvPSettleDataUtils.SetSettleData(tbl)
  PvPSettleData.settleData = tbl
end

function PvPSettleDataUtils.ReqLaunchMoreGame(uid, name, callBack, failCB)
  ProtoManager.Instance:ReqServer("GameRequest", "OnLaunchMoreGame", function(data)
    Logger.Info("========== 邀请对方PVP再来一局成功 ==========\n", table.tostring(data or {}))
    PvPSettleDataUtils.OpenPvPMoreGameInviteTips(name)
    if callBack then
      callBack()
    end
  end, function(data)
    Logger.Info("========== 邀请对方PVP再来一局失败 ==========\n", table.tostring(data or {}))
    if failCB then
      failCB()
    end
  end, uid)
end

function PvPSettleDataUtils.ReqCancelMoreGame(callBack)
  ProtoManager.Instance:ReqServer("GameRequest", "OnCancelLaunchMoreGame", function(data)
    Logger.Info("========== 取消再来一局成功 ==========\n", table.tostring(data or {}))
    if callBack then
      callBack()
    end
  end, function(data)
    Logger.Info("========== 取消再来一局失败 ==========\n", table.tostring(data or {}))
  end)
end

function PvPSettleDataUtils.ReqHandleMoreGameInvite(isAccept, callBack)
  ProtoManager.Instance:ReqServer("GameRequest", "OnHandleMoreGameInvite", function(data)
    Logger.Info("========== 接受/拒绝再来一局邀请协议成功 ==========\n", table.tostring(data or {}))
    if callBack then
      callBack()
    end
  end, function(data)
    Logger.Info("========== 接受/拒绝再来一局邀请协议失败 ==========\n", table.tostring(data or {}))
  end, isAccept)
end

function PvPSettleDataUtils.ReqExitPvpSettlePanel(callBack)
  ProtoManager.Instance:ReqServer("GameRequest", "OnCancelMoreGame", function(data)
    Logger.Info("========== 退出PVP结算界面成功 ==========\n", table.tostring(data or {}))
    if callBack then
      callBack()
    end
  end, function(data)
    Logger.Info("========== 退出PVP结算界面失败 ==========\n", table.tostring(data or {}))
  end)
end

function PvPSettleDataUtils.OpenPvPMoreGameInviteTips(enermyName)
  local tipsId = 100002
  local tipsCfg = DT.TipsType[tipsId]
  local desc = LT.Textf(tipsCfg.Desc, enermyName or "")
  Alert.Show(tipsId, nil, function()
    PvPSettleDataUtils.ReqCancelMoreGame()
  end, nil, desc)
end

function PvPSettleDataUtils.OpenPvPMoreGameInvitedTips(enermyName, playerUid)
  local tipsId = 100003
  local tipsCfg = DT.TipsType[tipsId]
  local desc = LT.Textf(tipsCfg.Desc, enermyName or "")
  Alert.Show(tipsId, function()
    PvPSettleDataUtils.ReqHandleMoreGameInvite(false)
    EventMgr.Instance.PvpMoreGameClickRefuse:Dispatch(playerUid)
  end, function()
    PvPSettleDataUtils.ReqHandleMoreGameInvite(true)
  end, nil, desc)
end

function PvPSettleDataUtils.OpenPvPBattleDefeatPanel(closeCb)
  UIManager.Instance:Reopen(Urls.PvPBattleDefeatPanel, closeCb)
end

function PvPSettleDataUtils.OpenPvPBattleVictoryPanel(closeCb)
  UIManager.Instance:Reopen(Urls.PvPBattleVictoryPanel, closeCb)
end

function PvPSettleDataUtils.OpenPvPBattleRankSettlePanel(isWin, closeCb)
  UIManager.Instance:Reopen(Urls.PvPBattleRankSettlePanel, isWin, closeCb)
end

function PvPSettleDataUtils.OpenPvPBattleDataSettlePanel(closeCb, battleRst, battleRecordData)
  UIManager.Instance:Reopen(Urls.PVPBattleDataSettlePanel, closeCb, battleRst, battleRecordData)
end

function PvPSettleDataUtils.GetPvpType()
  return PvPSettleData.pvpType
end

function PvPSettleDataUtils.GetSettleRewards()
  return PvPSettleData.settleRewards
end

function PvPSettleDataUtils.GetRankRewards()
  return PvPSettleData.rankRewards
end

function PvPSettleDataUtils.GetWin()
  return PvPSettleData.win
end

function PvPSettleDataUtils.GetNoMoreGame()
  return PvPSettleData.noMoreGame
end

function PvPSettleDataUtils.GetIsFriendGame()
  return PvPSettleData.isFriendGame
end

function PvPSettleDataUtils.IsGotoTown()
  if not PvPSettleData.settleData then
    return false
  end
  if PvPSettleData.settleData.matchType == PvpDefine.PVPMatchType.Friend then
    return true
  end
  return false
end

function PvPSettleDataUtils.GetIsPasswordGame()
  return PvPSettleData.matchType == PvpDefine.PVPMatchType.Password
end

function PvPSettleDataUtils.GetStatsData()
  do return table.deepclone end
  return table.deepclone, PvPSettleData.statsData
end

function PvPSettleDataUtils.GetSettleData()
  return PvPSettleData.settleData
end

function PvPSettleDataUtils.GetSettleRewardByType(type)
  local rst
  for _, tbl in pairs(PvPSettleData.settleRewards) do
    if tbl.type == type then
      rst = tbl
      break
    end
  end
  return rst
end

function PvPSettleDataUtils.GetSettleRewardByTid(tid)
  local rst = {}
  for _, tbl in pairs(PvPSettleData.settleRewards) do
    if tbl.tid == tid then
      table.insert(rst, tbl)
    end
  end
  return rst
end

function PvPSettleDataUtils.GetRankRewardByType(type)
  local rst
  for _, tbl in pairs(PvPSettleData.rankRewards) do
    if tbl.type == type then
      rst = tbl.num
      break
    end
  end
  return rst
end

function PvPSettleDataUtils.SetSettleRewards(tbl)
  if not table.next(tbl) then
    PvPSettleData.settleRewards = {
      [1] = {
        tid = DT.GetConstant("GoldItemTid"),
        reason = "PVP",
        num = 0,
        type = "PVP"
      },
      [2] = {
        tid = DT.GetConstant("AccountExpItemTid"),
        reason = "PVP",
        num = 0,
        type = "PVP"
      },
      [3] = {
        tid = CommonDefine.CurrencyType.AwakerLike,
        reason = "PVP",
        num = 0,
        type = "PVP"
      },
      [4] = {
        tid = DT.GetConstant("GoldItemTid"),
        reason = "PVPStyle",
        num = 0,
        type = "PVPStyle"
      },
      [5] = {
        tid = DT.GetConstant("AccountExpItemTid"),
        reason = "PVPStyle",
        num = 0,
        type = "PVPStyle"
      },
      [6] = {
        tid = CommonDefine.CurrencyType.AwakerLike,
        reason = "PVPStyle",
        num = 0,
        type = "PVPStyle"
      }
    }
  else
    PvPSettleData.settleRewards = tbl
  end
end

function PvPSettleDataUtils.SetRankRewards(tbl)
  PvPSettleData.rankRewards = tbl
end

function PvPSettleDataUtils.SetWin(uid)
  PvPSettleData.win = uid
end

function PvPSettleDataUtils.SetNoMoreGame(isNoMoreGame)
  PvPSettleData.noMoreGame = isNoMoreGame
end

function PvPSettleDataUtils.SetIsFriendGame(isFriendGame)
  PvPSettleData.isFriendGame = isFriendGame
end

function PvPSettleDataUtils.SetStatsData(stateData)
  PvPSettleData.statsData = stateData
  for uid, data in pairs(stateData or {}) do
    if uid == PlayerDataUtils.GetPlayerUid() then
      PvPSettleData.finalScore = data.finalScore
      PvPSettleData.lastFinalScore = data.score
    else
      PvPSettleData.opponentScore = data.finalScore
      PvPSettleData.lastOpponentScore = data.score
    end
  end
end

return PvPSettleDataUtils
