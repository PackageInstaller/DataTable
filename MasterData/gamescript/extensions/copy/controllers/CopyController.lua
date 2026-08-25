local CopyController = NewClass("CopyController", BaseController)

function CopyController:OnInit()
  self._isFirstEnterTown = true
  self:RegisterNotify(NotifyId.OnEnterTown, self.OnEnterTown, self)
end

function CopyController:OnReset()
  self._isFirstEnterTown = true
end

function CopyController:OnEnterTown()
  if self._isFirstEnterTown then
    self:OnFirstEnterTown()
  end
  self._isFirstEnterTown = false
end

function CopyController:OnFirstEnterTown()
  self:ReqSpecialSubplotGroupList()
end

function CopyController:GetBattleFinishJumper(stageGroupTid, jumpActivityTid)
  if not stageGroupTid then
    return
  end
  local groupType = CopyDataUtils.GetStageGroupType(stageGroupTid)
  local indexMap = CopyDataUtils.StageGroupType2SubplotGroupCopyPage
  local page = indexMap[groupType]
  local pendingReturnStageGroupTid = CopyStoryGuideModel.Instance:GetPendingReturnStageGroupTid()
  local pendingMatches = pendingReturnStageGroupTid and pendingReturnStageGroupTid == stageGroupTid
  local isGuideNoteWindowOpen = UIManager.Instance:GetWindow(Urls.GuideNoteMainView)
  local guideNoteCurPage = GuideNoteModel.Instance and GuideNoteModel.Instance:GetCurPage()
  local isGuideNoteStoryTab = guideNoteCurPage == GuideNoteDefine.Page.StoryGuide
  if pendingMatches or isGuideNoteWindowOpen and isGuideNoteStoryTab then
    if pendingMatches then
      CopyStoryGuideModel.Instance:ClearPendingReturnStageGroupTid()
    end
    return function()
      if page then
        UIManager.Instance:Reopen(Urls.SubplotGroupView, stageGroupTid, jumpActivityTid)
      elseif groupType == CommonDefine.StageGroupType.MainCopy then
        UIManager.Instance:Reopen(Urls.MainCopyChapterPanel, stageGroupTid, nil, model)
      elseif groupType == CommonDefine.StageGroupType.Prologue then
        UIManager.Instance:Reopen(Urls.MainCopyChapterPanel, stageGroupTid, nil, model)
      end
    end
  end
  if page then
    return function()
      if UIManager.Instance:GetWindow(Urls.SubplotGroupView) then
        GlobalDispatcher:Dispatch(NotifyId.OnCopySubplotViewRefresh)
        return
      end
      if jumpActivityTid and ActivityManager.Instance:IsActivityOpenedByTid(jumpActivityTid) then
        local data = {
          targetActivityTid = jumpActivityTid,
          params = {audioPlay = false}
        }
        if not UIManager.Instance:GetWindow(Urls.ActivityMainPanel) then
          UIManager.Instance:Reopen(Urls.ActivityMainPanel, data)
        end
      else
        UIManager.Instance:Reopen(Urls.CopyMainView, page)
      end
      if page ~= CommonDefine.MainCopyPanelPage.Vindicate and not UIManager.Instance:GetWindow(Urls.SubplotGroupView) then
        UIManager.Instance:Reopen(Urls.SubplotGroupView, stageGroupTid, jumpActivityTid)
      end
    end
  else
    if groupType == CommonDefine.StageGroupType.Prologue then
      do return self.GetPrologueBattleFinishJumper, self end
      return self.GetPrologueBattleFinishJumper, self, stageGroupTid, nil
    end
    if groupType == CommonDefine.StageGroupType.MainCopy then
      do return self.GetMainCopyBattleFinishJumper, self, stageGroupTid end
      return self.GetMainCopyBattleFinishJumper, self, stageGroupTid, CommonDefine.Difficulty.Normal
    end
    if groupType == CommonDefine.StageGroupType.MainCopyHard then
      do return self.GetMainCopyBattleFinishJumper, self, stageGroupTid end
      return self.GetMainCopyBattleFinishJumper, self, stageGroupTid, CommonDefine.Difficulty.Hard
    end
    if groupType == CommonDefine.StageGroupType.MainCopyCrazy then
      do return self.GetMainCopyBattleFinishJumper, self, stageGroupTid end
      return self.GetMainCopyBattleFinishJumper, self, stageGroupTid, CommonDefine.Difficulty.Super
    end
    return function()
      UIManager.Instance:Reopen(Urls.MainPanel)
    end
  end
end

function CopyController:GetMainCopyBattleFinishJumper(stageGroupTid, difficulty)
  return function()
    local copyMainView = UIManager.Instance:Reopen(Urls.CopyMainView, CommonDefine.MainCopyPanelPage.MainChapter, difficulty)
    local model = copyMainView.binder:createModel(MainCopyModel)
    model:SetStageGroupID(stageGroupTid)
    model:SetHardMode(difficulty)
    UIManager.Instance:Reopen(Urls.MainCopyChapterPanel, stageGroupTid, nil, model)
  end
end

function CopyController:GetPrologueBattleFinishJumper(stageGroupTid)
  return function()
    if not NewbieGuideManager:IsGuideFinished(81502) then
      UIManager.Instance:Reopen(Urls.MainPanel)
    else
      CopyMainModel.Instance:SetExitBattleGroupTid(stageGroupTid)
      CopyMainModel.Instance:SetCurDifficulty(CommonDefine.Difficulty.Normal)
      local copyMainView = UIManager.Instance:Reopen(Urls.CopyMainView, CommonDefine.MainCopyPanelPage.MainChapter, CommonDefine.Difficulty.Normal)
      local model = copyMainView.binder:createModel(MainCopyModel)
      model:SetStageGroupID(stageGroupTid)
      model:SetHardMode(CommonDefine.Difficulty.Normal)
    end
  end
end

function CopyController:OnOpenCopySettleBaseView()
  UIManager.Instance:Reopen(Urls.CopySettleBaseView)
end

function CopyController:ReqUnlockStage(stageTid)
  ProtoManager.Instance:ReqServer("StageRequest", "UnlockStageByItem", function()
    Alert.Show(10907)
    self:Notify(NotifyId.OnStageUnlocked, stageTid)
  end, function()
  end, stageTid)
end

function CopyController:OnOpenCopyAbyssSettleView(data)
  UIManager.Instance:Reopen(Urls.CopyAbyssSettleView, data)
end

function CopyController:CheckShowOverflowTipsBySync(rewardItemList, params)
  local hasConvertion = false
  for _, itemData in pairs(rewardItemList) do
    if itemData.reason == cd.ItemReason.UseItem then
      return
    end
    if itemData.overflow and table.next(itemData.overflow) ~= nil then
      hasConvertion = true
      break
    end
  end
  if not hasConvertion then
    return
  end
  local convertResultList = CopyExtModel.Instance:CalcOverflowList(rewardItemList)
  for _, data in ipairs(convertResultList) do
    local tipsParams = {}
    local itemCfg = ItemDataUtils.GetItemConfig(data.tid) or {}
    for _, overflowTid in ipairs(itemCfg.Overflow or {}) do
      local overflowCfg = ItemDataUtils.GetItemOverflowConfig(overflowTid) or {}
      tipsParams[1] = ItemDataUtils.GetItemName(data.tid)
      tipsParams[2] = data.num
      local overflowItemDesc = ""
      for convertTid, convertNum in table.iteraDouble(overflowCfg.ConverseItem or {}) do
        local itemName = ItemDataUtils.GetItemName(convertTid)
        overflowItemDesc = string.format("%s%s ", overflowItemDesc, ItemNumUtils.GetStr(itemName, convertNum))
      end
      tipsParams[3] = overflowItemDesc
      Alert.ShowWithParams(20190, tipsParams)
    end
  end
end

function CopyController:CheckShowUnlockCompensateView(stageGroupTid)
  local showCompensate = CopyExtModel.Instance:IsShowUnlockCompensate(stageGroupTid)
  Logger.Debug("[ac] CheckShowUnlockCompensateView 1 stageGroupTid=%s, showCompensate=%s", stageGroupTid, showCompensate)
  if not showCompensate then
    return
  end
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  local stageGroupName = CopyDataUtils.GetStageGroupName(stageGroupTid)
  local tipTid = stageGroupConfig.UnlockCompensation[2]
  local desc = LT.Textf(DT.TipsType[tipTid].Desc, stageGroupName)
  local items = {}
  for i = 3, #stageGroupConfig.UnlockCompensation, 2 do
    local itemTid = stageGroupConfig.UnlockCompensation[i]
    local itemNum = stageGroupConfig.UnlockCompensation[i + 1]
    if itemTid and itemNum then
      table.insert(items, {tid = itemTid, num = itemNum})
    end
  end
  Logger.Debug("[ac] CheckShowUnlockCompensateView 2 stageGroupTid=%s, tipTid=%s, items=%s", stageGroupTid, tipTid, table.tostring(items))
  
  local function _OnConfirm()
    Logger.Debug("[ac] on click confirm, req server.")
    ProtoManager.Instance:ReqServer("StageRequest", "OnGainUnlockStageGroupReward", function()
    end, function()
    end, stageGroupTid)
  end
  
  local params = {
    tipTid = tipTid,
    desc = desc,
    items = items,
    callback = _OnConfirm
  }
  UIManager.Instance:Reopen(Urls.ItemObtainedTipPanel, params)
end

function CopyController:ReqSpecialSubplotGroupList()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.SpecialSubplotTab, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return
  end
  local stageGroupIdList = {}
  local linkageStageGroupList = CopyExtModel.Instance:GetLinkageActivityGroupListFromCfg()
  for _, stageGroupId in pairs(linkageStageGroupList) do
    table.insert(stageGroupIdList, stageGroupId)
  end
  local specialSubplotGroupList = CopyExtModel.Instance:GetSpecialSubplotGroupListFromCfg()
  for _, stageGroupId in pairs(specialSubplotGroupList) do
    table.insert(stageGroupIdList, stageGroupId)
  end
  CopyController.Instance:ReqSubplotBranchStageData(stageGroupIdList)
end

function CopyController:ReqSubplotBranchStageData(stageGroupIdList, callback)
  if not stageGroupIdList or 0 == #stageGroupIdList then
    if callback then
      callback()
    end
    return
  end
  local needRequestList = CopyDataUtils.CollectNeedRequestStageGroupIds(stageGroupIdList)
  CopyDataUtils.ReqCopyDataList(needRequestList, callback)
end

function CopyController:ReqBattleTeachingStageData(callback)
  local stageGroupList = StageGroupCfgUtils.GetDisplayStageGroupByType(CommonDefine.StageGroupType.BattleTeaching)
  local needRequestList = {}
  for _, stageGroupCfg in pairs(stageGroupList) do
    local stageGroupId = stageGroupCfg.ID
    if not CopySubplotGroupModel.Instance:IsHaveServerStageData(stageGroupId) then
      table.insert(needRequestList, stageGroupId)
    end
  end
  CopyDataUtils.ReqCopyDataList(needRequestList, callback)
end

return CopyController
