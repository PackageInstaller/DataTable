local LoginPVDataUtils = require("GameScript.Data.LoginPVDataUtils")
local Town, Super = System.NewClass("Town", Entity)

function Town:ctor(id)
  Super.ctor(self)
  self.id = id
  self.queueDelay = 0
end

function Town:Awake()
  self.CheckRecoverSettlePanel(System.fn(self, self.Enter))
end

function Town:Enter()
  if self:CheckPvpFighting() then
    return
  end
  self.queue = Z1QueueMgr.Instance:CreateQueue()
  if not UIManager.Instance:GetWindow(Urls.MainPanel) then
    UIManager.Instance:Reopen(Urls.MainPanel)
  end
  CS.UnityEngine.RenderSettings.fog = false
  self:CheckPvpMatching()
  EventMgr.Instance.EnterMainCity:Dispatch()
  EventMgr.Instance.GameEvent:Dispatch(CommonDefine.GameEvent.EnterMainPanel)
  self.binder:onDestroy(function()
    EventMgr.Instance.GameEvent:Dispatch(CommonDefine.GameEvent.ExitMainPanel)
  end)
  UIAudioManager.Instance:SetMainSceneMusicState(true)
  self.binder:BindTimer(1, 0, nil, function()
    PopupQueManager.Instance:SetEnabled(true)
  end)
  WorldStageManager.Instance:ClearAllStage()
  self:BindToSetLoginPV()
  self:CheckRecoverPvpRoom()
end

function Town:BindToSetLoginPV()
  self.binder:BindToRaw(function(_, pvCfg)
    if pvCfg then
      local _, PvVideo, PvMusic, PvCaption = table.unpack(pvCfg)
      local autoInfo = LoginPVDataUtils.GetAutoLoginPVInfo()
      local preVideo = autoInfo and autoInfo.video
      if PvVideo == preVideo then
        return
      end
      LoginPVDataUtils.SetAutoLoginPV(PvVideo, PvMusic, PvCaption, true)
      Logger.Info("Save Login Video", PvVideo, PvMusic)
    end
  end, function()
    for i = 20, 1, -1 do
      local pvCfg = DT.GetOriginalConstant("LoginPV" .. i)
      if pvCfg then
        local pvStageId = pvCfg[1]
        if 0 == pvStageId or CopyDataUtils.IsFirstRewardDraw(pvStageId) then
          return pvCfg
        end
      end
    end
  end)
  self.binder:BindToRaw(function(_, avgId)
    if avgId then
      local preAvgId = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.BeforeLoginAvgId)
      if preAvgId == avgId then
        return
      end
      MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.BeforeLoginAvgId, avgId)
      MobileFileDataManager.Instance:OnSaveCommInfo()
    end
  end, function()
    for i = 20, 1, -1 do
      local pvCfg = DT.GetOriginalConstant("BeforLoginPV" .. i)
      if pvCfg then
        local pvStageId = pvCfg[1]
        if 0 == pvStageId or CopyDataUtils.IsFirstRewardDraw(pvStageId) then
          return pvCfg[2]
        end
      end
    end
  end)
  self.binder:BindToRaw(function(_, stageId)
    if stageId then
      local preStageId = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.LastPassedStageId)
      if preStageId == stageId then
        return
      end
      MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.LastPassedStageId, stageId, true)
    end
  end, function()
    do return end
    return MainCopyDataUtils.GetLatestPassedStoryLineId, nil
  end)
end

function Town:CheckPvpMatching()
  if PvPMatchDataUtils.GetIsMatching() then
    local queueTag = "QueuePvP"
    self.queue:Insert(queueTag, function()
      PvPMatchDataUtils.OpenPvPMatchingPanel()
    end, 999, 0)
  end
end

function Town:CheckRecoverPvpRoom()
  PvpPasswordController.Instance:CheckRecoverRoomOnTown()
end

function Town:CheckPvpFighting()
  local pvpBattleInfo = PvPMatchDataUtils.GetPvpBattleInfo()
  if pvpBattleInfo then
    BattleManager.Instance:EnterBattle(pvpBattleInfo)
    PvPMatchDataUtils.SetPvpBattleInfo(nil)
    return true
  end
  return false
end

function Town:ShowFeatureUnlockTips()
end

function Town.CheckRecoverSettlePanel(callback)
  local saveKey = CommonDefine.LocalSaveKey.CopyRecoverSettleData
  local settleData = MobileFileDataManager.Instance:GetPlayerFileValue(saveKey)
  if settleData then
    DataCenter.copiesData.copiesSettleData = settleData
    local stageTypeKey = CommonDefine.LocalSaveKey.CopyRecoverType
    local stageType = MobileFileDataManager.Instance:GetPlayerFileValue(stageTypeKey)
    local stageId = settleData.stageId
    local stageCfg = DT.Stage[stageId]
    if not stageCfg or not stageCfg.Map then
      callback()
      return
    end
    local storyId = AvgStoryManager.Instance:GetRecoverStoryId()
    if storyId then
      AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
        CopiesDataUtils.ShowSettlement(callback, stageType)
      end)
    else
      CopiesDataUtils.ShowSettlement(callback, stageType)
    end
  else
    callback()
  end
end

function Town:BindFeatrueUnlock()
  self.binder:BindToRaw(function(childBinder, nVal, oVal)
    if nVal and false == oVal then
      self:InsertBpOpenTips(childBinder)
    end
  end, function()
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.BattlePass, PlayerDataUtils.GetFeatureMainTypeKey())
    return unlocked
  end)
end

function Town:Destroy()
  Super.Destroy(self)
  if PopupQueManager.Instance then
    PopupQueManager.Instance:SetEnabled(false)
  end
  if self.queue then
    Z1QueueMgr.Instance:DestroyQueue(self.queue)
  end
  NewbieGuideManager.Instance:SetEnabled(false, "Leave Town")
  UIAudioManager.Instance:SetMainSceneMusicState(false)
end

return Town
