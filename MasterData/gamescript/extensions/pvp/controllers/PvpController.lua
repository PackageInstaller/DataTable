local PvpController = NewClass("PvpController", BaseController)

function PvpController:OnInit()
  self:RegisterNotify(NotifyId.OnEnterScene, System.fn(self, self._OnEnterScene))
end

function PvpController:OnReset()
end

function PvpController:_OnEnterScene(sceneType)
  if sceneType == CommonDefine.SceneType.Town then
    return
  end
  self:ClearCacheData()
end

function PvpController:ClearCacheData()
  PvPSeasonDataUtils.ClearOpenPvpCache()
  RankModel.Instance:ResetRankType(RankDefine.RankType.SeasonRoPvpPrebuilt)
  RankModel.Instance:ResetRankType(RankDefine.RankType.SeasonRoPvpDraft)
end

function PvpController:OpenPvpHistoryLevelView(type)
  UIManager.Instance:Reopen(Urls.PvpHistoryLevelView, type)
end

function PvpController:OpenPvpTaskView()
  UIManager.Instance:Reopen(Urls.PvpTaskView)
end

function PvpController:OnPvpDraftDataUpdate()
  if UIManager.Instance:GetWindow(Urls.PvPMatchingPanel) then
    return
  end
  local curPhase = PvpDraftModel.Instance:GetDraftPvpPhase()
  if curPhase == PvpDefine.PvpDraftPhase.Draft or curPhase == PvpDefine.PvpDraftPhase.Start then
    if PvPMatchDataUtils.GetIsPvpPreparing() and not UIManager.Instance:GetWindow(Urls.MainPanel) then
      return
    end
    if not UIManager.Instance:GetWindow(Urls.PvpDraftView) then
      PvpController.Instance:OpenPvpDraftView()
      UIManager.Instance:CloseAllExcept({
        Urls.PvpDraftView
      })
      PvPMatchDataUtils.SetIsPvpPreparing(false)
      BattleManager.Instance:DisposeCurrentBattle()
    end
  elseif not UIManager.Instance:GetWindow(Urls.PvpDraftAdjustTeamView) then
    PvpController.Instance:OpenPvpDraftAdjustTeamView()
    UIManager.Instance:CloseAllExcept({
      Urls.PvpDraftAdjustTeamView
    })
    PvPMatchDataUtils.SetIsPvpPreparing(false)
    BattleManager.Instance:DisposeCurrentBattle()
  end
end

function PvpController:OnPvpDraftResult()
  local settleReason = PvPSettleDataUtils.GetSettleReason()
  if settleReason == CommonDefine.PvpSettleReason.GiveUpPrepare then
    self:OpenPvpSettlePanels()
  end
end

function PvpController:OpenPvpSettlePanels()
  local isWin = PvPSettleDataUtils.GetWin()
  local url = isWin and Urls.WorldStageBattleWinTip or Urls.WorldStageBattleFailTip
  if UIManager.Instance:GetWindow(url) then
    return
  end
  UIManager.Instance:Reopen(url, function()
    if PvPSettleDataUtils.GetIsPasswordGame() or PvPSettleDataUtils.GetIsFriendGame() then
      SceneMgr.Instance:EnterNull()
      UIManager.Instance:Reopen(Urls.MainPanelPVP)
      return
    end
    PvPSettleDataUtils.OpenPvPBattleRankSettlePanel(isWin, function()
      SceneMgr.Instance:EnterNull()
      UIManager.Instance:Reopen(Urls.MainPanelPVP)
    end)
  end)
end

function PvpController:OnPvpDraftRecover()
  local isPvpPreparing = PvPMatchDataUtils.GetIsPvpPreparing()
  if isPvpPreparing then
    self:TryRecoverPrepare()
  end
end

function PvpController:OpenPvpFriendSelectGameModeView(playerUid)
  UIManager.Instance:Reopen(Urls.PvpFriendSelectGameModeView, playerUid)
end

function PvpController:OpenPvpDraftView()
  PvpDraftModel.Instance:ClearViewData()
  UIManager.Instance:Reopen(Urls.PvpDraftView)
end

function PvpController:OpenPvpDraftAdjustTeamView()
  PvpDraftModel.Instance:ClearViewData()
  UIManager.Instance:Reopen(Urls.PvpDraftAdjustTeamView)
end

function PvpController:OpenPvPTeamBuildMainOnlyEditPanel()
  local PVPTeamBuildData = PvPTeamBuildDataUtils.GetPvpTeamBuildData()
  if PVPTeamBuildData.teamDataGroup and not table.next(PVPTeamBuildData.teamDataGroup) then
    PvPTeamBuildDataUtils.ReqOnOpenTeam(function()
      UIManager.Instance:Reopen(Urls.PvPTeamBuildMainOnlyEditPanel)
    end)
    return
  end
  PvPTeamBuildDataUtils.ReqOnOpenTeam()
  UIManager.Instance:Reopen(Urls.PvPTeamBuildMainOnlyEditPanel)
end

function PvpController:ReqOnGainAllLevelReward(careerLevelType, callback)
  ProtoManager.Instance:ReqServer("PvpRewardRequest", "OnGainAllLevelReward", function(data)
    Logger.Info("OnGainAllLevelReward Successful", table.tostring(data or {}))
    if callback then
      callback()
    end
    EventMgr.Instance.OnGainAllPvpLevelReward:Dispatch()
  end, function(data)
    Logger.Info("OnGainAllLevelReward failed", table.tostring(data or {}))
  end, careerLevelType)
end

function PvpController:TryRecoverPrepare(callback)
  ProtoManager.Instance:ReqServer("PvpRequest", "TryRecoverPrepare", function(data)
    Logger.Info("========== 恢复轮选阶段成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 恢复轮选阶段失败 ==========\n", table.tostring(data or {}))
  end)
end

function PvpController:ReqOnMatch(param, callback)
  PvpDraftModel.Instance:ClearData()
  ProtoManager.Instance:ReqServer("PvpRequest", "OnMatch", function(data)
    Logger.Info("========== 发起匹配成功 ==========\n", table.tostring(data or {}))
    PvPMatchDataUtils.SetIsMatching(true)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 发起匹配失败 ==========\n", table.tostring(data or {}))
  end, param)
end

function PvpController:ReqOnCancel(callback)
  ProtoManager.Instance:ReqServer("PvpRequest", "OnCancel", function(data)
    Logger.Info("========== 取消匹配成功 ==========\n", table.tostring(data or {}))
    PvPMatchDataUtils.SetIsMatching(false)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 取消匹配失败 ==========\n", table.tostring(data or {}))
  end)
end

function PvpController:ReqInviteFriendGame(uid, pvpType, callback)
  ProtoManager.Instance:ReqServer("PvpRequest", "InviteFriendGame", function(data)
    Logger.Info("========== 邀请好友赛成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 邀请好友赛失败 ==========\n", table.tostring(data or {}))
  end, uid, pvpType)
end

function PvpController:ReqDraftAdjustTeam(fieldName, idxFrom, idxTo, ready, callback)
  ProtoManager.Instance:ReqServer("PvpRequest", "DraftAdjustTeam", function(data)
    Logger.Info("========== 调整阵容成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 调整阵容失败 ==========\n", table.tostring(data or {}))
  end, fieldName, idxFrom, idxTo, ready)
end

function PvpController:ReqDraftChooseCollect(collectTid, isConfirm, callback)
  ProtoManager.Instance:ReqServer("PvpRequest", "DraftChooseCollect", function(data)
    Logger.Info("========== 选择阵容成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 选择阵容失败 ==========\n", table.tostring(data or {}))
  end, collectTid, isConfirm)
end

function PvpController:ReqOnWatchPvpReplay(battleUuid, stageGroupTid)
  ProtoManager.Instance:ReqServer("PvpRequest", "OnWatchPvpReplay", function(data)
    Logger.Info("========== OnWatchPvpReplay Successful ==========\n", table.tostring(data or {}))
  end, function(data)
    Logger.Info("========== OnWatchPvpReplay Failed ==========\n", table.tostring(data or {}))
  end, battleUuid, stageGroupTid)
end

function PvpController:ReqOnCopyOpponentDeck(stageGroupTid)
  ProtoManager.Instance:ReqServer("PvpRequest", "OnCopyOpponentDeck", function(data)
    Logger.Info("========== OnCopyOpponentDeck Successful ==========\n", table.tostring(data or {}))
  end, function(data)
    Logger.Info("========== OnCopyOpponentDeck Failed ==========\n", table.tostring(data or {}))
  end, stageGroupTid)
end

function PvpController:ReqOnTrialDefeatAwaker(unitUid)
  ProtoManager.Instance:ReqServer("PvpRequest", "OnTrialDefeatAwaker", function(data)
    Logger.Info("========== OnTrialDefeatAwaker Successful ==========\n", table.tostring(data or {}))
  end, function(data)
    Logger.Info("========== OnTrialDefeatAwaker Failed ==========\n", table.tostring(data or {}))
  end, unitUid)
end

function PvpController:ReqGoodAi(uid, callback)
  ProtoManager.Instance:ReqServer("PvpRequest", "Good", function(data)
    Logger.Info("========== Good Successful ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== Good Failed ==========\n", table.tostring(data or {}))
  end, uid)
end

return PvpController
