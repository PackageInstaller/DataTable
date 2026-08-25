local WorldRecoveryManager, Super = System.NewClass("WorldRecoveryManager", Manager)

function WorldRecoveryManager:ctor()
  Super.ctor(self)
  Logger.Debug("WorldRecoveryManager")
  self.isWaitingAbyssResetConfirm = false
  self.isStageExpiredByServer = false
end

function WorldRecoveryManager:Awake(binder)
  Super.Awake(self)
  binder:BindResponse(self, "World", "OnRecoverWorld", System.fn(self, self.OnHandleRecoverWorldData))
  binder:BindResponse(self, "World", "OnClearByStageExpire", System.fn(self, self._OnClearByStageExpire))
  binder:BindEvent(EventMgr.Instance.OnWorldExit, System.fn(self, self._OnWorldExit))
  binder:BindEvent(EventMgr.Instance.OnEnterScene, System.fn(self, self._OnEnterSceneClearWaiting))
end

function WorldRecoveryManager:OnDestroy()
  Super.OnDestroy(self)
  self:ClearRecoverData(true)
end

function WorldRecoveryManager:GetWorldTid()
  return self.worldTid or 0
end

WorldRecoveryManager.RecoverType = {Copies = "Copies", Tower = "Tower"}

function WorldRecoveryManager:SetRecoverData(tid, recoverType)
  Logger.ReportApusInfo("SetRecoverData {tid} {recoverType}", tid, recoverType)
  self.worldTid = tid
  self.recoverType = recoverType
  self.isRecover = true
end

function WorldRecoveryManager:ClearRecoverData(isClearCopies)
  if isClearCopies then
    self.worldTid = 0
    RailWayDataUtils.ResetSeasonSwitchState()
  end
  self.recoverType = nil
  self.isRecover = false
  self.curEventData = nil
  self.cmdData = nil
  self.itemsData = nil
  self.stateData = nil
  self.recoverData = nil
  self.isStageExpiredByServer = false
end

function WorldRecoveryManager:_ClearWaitingAbyssResetConfirm(reason)
  if not self.isWaitingAbyssResetConfirm then
    return
  end
  Logger.Info("[AbyssReset] clear isWaitingAbyssResetConfirm, reason=%s", tostring(reason))
  self.isWaitingAbyssResetConfirm = false
end

function WorldRecoveryManager:_OnEnterSceneClearWaiting(sceneType)
  if sceneType == CommonDefine.SceneType.Town or sceneType == CommonDefine.SceneType.Login or sceneType == CommonDefine.SceneType.Null then
    self:_ClearWaitingAbyssResetConfirm("OnEnterScene:" .. tostring(sceneType))
  end
end

function WorldRecoveryManager:_InvalidateBattleRecoverData()
  Logger.Info("[AbyssReset] invalidate battle recover data")
  self.worldTid = 0
  self.recoverType = nil
  self.isRecover = false
  self.curEventData = nil
  self.cmdData = nil
  self.itemsData = nil
  self.stateData = nil
  self.recoverData = nil
end

function WorldRecoveryManager:IsRecovery()
  return self.isRecover
end

function WorldRecoveryManager:OnRecovery(exitCur)
  if not self.worldTid or self.worldTid <= 0 or not self.recoverType then
    return
  end
  local data, ret = ProtoManager.Instance.GameRequest:OnWorldRecover(self.worldTid)
  if ret.code == ErrorMsg.SUCCESS and 0 == data.worldTid then
    return
  end
  return true
end

function WorldRecoveryManager:IsWaitingAbyssResetConfirm()
  return self.isWaitingAbyssResetConfirm
end

function WorldRecoveryManager:IsStageExpiredByServer()
  return self.isStageExpiredByServer
end

function WorldRecoveryManager:SetStageExpiredByServer(value)
  Logger.Info("[AbyssReset] SetStageExpiredByServer old=%s, new=%s", tostring(self.isStageExpiredByServer), tostring(value))
  self.isStageExpiredByServer = value
end

function WorldRecoveryManager:ShowAbyssResetTipsByStageGroupId(stageGroupId)
  self:_ShowAbyssResetTipsByGroupId(stageGroupId)
end

function WorldRecoveryManager:OnHandleRecoverWorldData(data)
  if data and data.copiesTid and self:_IsAbyssStageTid(data.copiesTid) and (self.isStageExpiredByServer or self.isWaitingAbyssResetConfirm) then
    local stageCfg = DT.Stage[data.copiesTid]
    local stageGroupId = stageCfg and stageCfg.BelongGroup or data.copiesTid
    Logger.Info("[AbyssReset] OnHandleRecoverWorldData: stage expired/waiting reset, skip recover stage, stageId=%s", tostring(data.copiesTid))
    self:_ShowAbyssResetTipsByGroupId(stageGroupId)
    self.notHandleRecover = false
    return
  end
  self.recoverData = data
  if self.notHandleRecover then
    self.notHandleRecover = false
    return
  end
  WorldStageManager.Instance:OnRecoveryStage(data.copiesTid, data)
  if data.curEvent then
    self.curEventData = table.deepclone(data.curEvent)
    Logger.Debug("OnHandleRecoverWorldData: curEvent=%s", table.tostring(data.curEvent))
  end
  if data.itemsData then
    self.itemsData = table.deepclone(data.itemsData)
  end
  if data.stateData then
    StateDataUtils.OnSyncStateData(data.stateData)
  end
  Logger.Debug("OnHandleRecoverWorldData: GearData=%s", table.tostring(data.gears))
end

function WorldRecoveryManager:_OnWorldExit(data)
  if not data or 2 ~= data.exitReason then
    return
  end
  local stageTid = data.worldTid or 0
  if stageTid <= 0 then
    return
  end
  if self:_IsAbyssStageTid(stageTid) then
    self:SetStageExpiredByServer(true)
    self:_ShowAbyssResetTips(stageTid)
  end
end

function WorldRecoveryManager:_OnClearByStageExpire(data)
  if not data or not data.stageTid then
    return
  end
  if self:_IsAbyssStageTid(data.stageTid) then
    self:SetStageExpiredByServer(true)
    self:_ShowAbyssResetTips(data.stageTid)
  end
end

function WorldRecoveryManager:_ShowAbyssResetTips(stageTid)
  local stageCfg = DT.Stage[stageTid]
  local stageGroupId = stageCfg and stageCfg.BelongGroup
  if not stageGroupId then
    Logger.Error("_ShowAbyssResetTips: Failed to get stageGroupId for stageTid=%s", stageTid)
    return
  end
  self:_ShowAbyssResetTipsByGroupId(stageGroupId)
end

function WorldRecoveryManager:_StopBattleStartRetry()
  local battleManager = BattleManager.Instance
  if not battleManager then
    return
  end
  local loader = battleManager.battleSceneLoader
  if loader and loader._StopSafeTimer then
    loader:_StopSafeTimer()
  end
end

function WorldRecoveryManager:_CloseBattleRecoverAlert()
  local tipIds = {
    ["100020"] = true
  }
  local uiMgr = UIManager.Instance
  if not uiMgr.panelList then
    return
  end
  local toClose = {}
  for _, panel in ipairs(uiMgr.panelList) do
    if panel.url == Urls.AlertConfirm2Panel and panel.data and tipIds[tostring(panel.data.tipTid)] then
      table.insert(toClose, panel)
    end
  end
  for _, panel in ipairs(toClose) do
    Logger.Info("[AbyssReset] close battle recover alert tipTid=%s", tostring(panel.data and panel.data.tipTid))
    panel.closeWithoutAnim = true
    panel:Close()
  end
end

function WorldRecoveryManager:_ShowAbyssResetTipsByGroupId(stageGroupId)
  if not stageGroupId then
    Logger.Error("_ShowAbyssResetTipsByGroupId: stageGroupId is nil")
    return
  end
  if self.isWaitingAbyssResetConfirm then
    Logger.Info("[AbyssReset] Already showing reset tips, skip duplicate, stageGroupId=%s", tostring(stageGroupId))
    return
  end
  self.isWaitingAbyssResetConfirm = true
  Logger.Info("[AbyssReset] Show reset tips, stageGroupId=%s, cleanup before alert", tostring(stageGroupId))
  self:_InvalidateBattleRecoverData()
  self:_StopBattleStartRetry()
  if BattleManager.Instance then
    BattleManager.Instance:DisposeCurrentBattle()
  end
  DataCenter.barrierData.InBattle = false
  if StageExitPanelManager.Instance then
    StageExitPanelManager.Instance:Clear()
  end
  self:_CloseBattleRecoverAlert()
  Alert.Show("AbyssChallengeResetTips", nil, function()
    Logger.Info("[AbyssReset] User confirmed reset tips, EnterTown, stageGroupId=%s", tostring(stageGroupId))
    self:_CloseBattleRecoverAlert()
    self:_ClearWaitingAbyssResetConfirm("tips confirm")
    self:ClearRecoverData(true)
    SceneMgr.Instance:EnterTown(true)
  end)
end

function WorldRecoveryManager:_IsAbyssStageTid(stageTid)
  if not stageTid or stageTid <= 0 then
    return false
  end
  local stageCfg = DT.Stage[stageTid]
  if not stageCfg or not stageCfg.BelongGroup then
    return false
  end
  local stageGroupCfg = DT.StageGroup[stageCfg.BelongGroup]
  return stageGroupCfg and stageGroupCfg.Type == CommonDefine.StageGroupType.AbyssChallenge
end

function WorldRecoveryManager:GetRecoverData()
  return self.recoverData
end

function WorldRecoveryManager:GetItemsData()
  return self.itemsData
end

function WorldRecoveryManager:GetRecoverEventData()
  return self.curEventData
end

function WorldRecoveryManager:ClearRecoverEventData()
  self.curEventData = nil
  self.cmdData = nil
  self.itemsData = nil
  self.recoverData = nil
end

function WorldRecoveryManager:GetCmdData()
  return self.cmdData
end

return WorldRecoveryManager
