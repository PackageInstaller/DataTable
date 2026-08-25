local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local GuideNoteExtra = CommonDefine.ItemReason.GuideNoteExtra
local BattlePassDoubleEx = CommonDefine.ItemReason.BattlePassDoubleEx
local BP_EXP_ITEM_TID = DT.GetConstant("BPExpItemTid")
local GuideNoteTaskViewBase, Super = NewClass("GuideNoteTaskViewBase", BaseView)
GuideNoteTaskViewBase.uiResCls = "UI/UI_GuideNote/UI_GuideNote_Prefab/UI_GuideNote_Panel_Task.prefab"

function GuideNoteTaskViewBase:ctor()
  Super.ctor(self)
  self._tierRewardItems = nil
  self._livenessRewardCfgCache = nil
  self._sidebarTierRewardCfgCache = nil
  self._resetCountDownTimerId = nil
  self._pendingBpLevelUpLevel = nil
  self._waitShowRewardCloseRegistered = false
  self._waitShowRewardCloseCb = nil
end

function GuideNoteTaskViewBase:OnBuildView()
  Super.OnBuildView(self)
  self:_InitTaskItemGroupView()
  if self.ui.UI_GuideNote_Item_Reward then
    self:SetActive(self.ui.UI_GuideNote_Item_Reward, false)
  end
end

function GuideNoteTaskViewBase:RegisterEvents()
  local closeBtn = self:FindChildRecursively(self.ui.uiNode, "Btn_Close")
  if closeBtn then
    self:AddButtonClickListener(closeBtn, System.fn(self, self._OnClose))
  end
  if self.ui.Btn_ActivityItem then
    self:AddButtonClickListener(self.ui.Btn_ActivityItem, System.fn(self, self._OnClickActivityItem))
  end
  self:BindEvent(EventMgr.Instance.TaskViewUpdate, System.fn(self, self._OnTaskViewUpdate))
  self:BindEvent(EventMgr.Instance.BpSyncData, function()
    local curLevel = BattlePassDataUtils.GetLevel()
    local lastLevel = self._bpObservedLevel or curLevel
    self._bpObservedLevel = curLevel
    self._isBpLevelUp = lastLevel ~= curLevel
    self:_ClearBpLevelUpTimer()
    self._bpLevelUpTimer = self.binder:BindTimer(0.2, -1, function()
      self:_TryShowBpLevelUpTips()
    end)
  end)
end

function GuideNoteTaskViewBase:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
  self:RegisterLocalNotify(NotifyId.OnGuideNoteDataChanged, self._OnGuideNoteDataChanged, self)
end

function GuideNoteTaskViewBase:OnEnterView()
  Super.OnEnterView(self)
  self._bpObservedLevel = BattlePassDataUtils.GetLevel()
  BpTaskModel.Instance:SetCurSelectTab(self:_GetTaskServerIndex())
  self:_ReqOpenGuideNote()
  self:_RefreshView()
  self:_StartResetCountDownTimer()
end

function GuideNoteTaskViewBase:_TryShowBpLevelUpTips()
  if UIManager.Instance:GetWindow(Urls.ShowRewardPanel) then
    return
  end
  if not self._isBpLevelUp then
    return
  end
  self._isBpLevelUp = false
  self:_ClearBpLevelUpTimer()
  BattlePassDataUtils.OpenLevelUpTips(self._bpObservedLevel)
end

function GuideNoteTaskViewBase:_ClearBpLevelUpTimer()
  if self._bpLevelUpTimer then
    self:StopTimer(self._bpLevelUpTimer)
    self._bpLevelUpTimer = nil
  end
end

function GuideNoteTaskViewBase:RefreshOnRendered()
  BpTaskModel.Instance:SetCurSelectTab(self:_GetTaskServerIndex())
  if self.ui.TaskView then
    self:PlayTableViewFadeInAnim(self.ui.TaskView)
  end
end

function GuideNoteTaskViewBase:_OnTaskViewUpdate(taskSvrIdx)
  if taskSvrIdx and taskSvrIdx ~= self:_GetTaskServerIndex() then
    return
  end
  BpTaskModel.Instance:SetCurTaskList(self:_GetTaskServerIndex())
  self:_RefreshView()
end

function GuideNoteTaskViewBase:_RefreshView()
  if self.taskItemGroupView then
    self.taskItemGroupView:ReloadData()
  end
  self:_RefreshActivityItemIcon()
  self:_RefreshActivityRewardView()
  self:_RefreshSidebarRedDot()
end

function GuideNoteTaskViewBase:_OnBagItemDataChanged(_, tid)
  if tid ~= self:_GetActivityItemTid() then
    return
  end
  self:_RefreshActivityRewardView()
  self:_RefreshSidebarRedDot()
end

function GuideNoteTaskViewBase:_OnGuideNoteDataChanged()
  BpTaskModel.Instance:SetCurTaskList(self:_GetTaskServerIndex())
  self:_RefreshView()
end

function GuideNoteTaskViewBase:_GetActivityItemImageNode()
  if not self.ui then
    return nil
  end
  return self.ui.Image_ActivityItem or self.ui.Iamge_ActivityItem
end

function GuideNoteTaskViewBase:_GetActivityItemNum()
  do return self._GetActivityExpValue end
  return self._GetActivityExpValue, self
end

function GuideNoteTaskViewBase:_RefreshActivityItemIcon()
  local imageNode = self:_GetActivityItemImageNode()
  if not imageNode then
    return
  end
  local tid = self:_GetActivityItemTid()
  local isValidTid = tid and tid > 0
  self:SetActive(imageNode, isValidTid)
  if not isValidTid then
    return
  end
  self:SetImage(imageNode, ItemDataUtils.GetItemIcon(tid))
end

function GuideNoteTaskViewBase:_ReqOpenGuideNote()
  if GuideNoteController and GuideNoteController.Instance then
    GuideNoteController.Instance:ReqOnOpenGuideNote()
  end
end

function GuideNoteTaskViewBase:_GetLivenessRewardCfg()
  if self._livenessRewardCfgCache then
    return self._livenessRewardCfgCache
  end
  self._livenessRewardCfgCache = self:_BuildLivenessRewardCfg()
  return self._livenessRewardCfgCache
end

function GuideNoteTaskViewBase:_GetSidebarTierRewardCfg()
  if self._sidebarTierRewardCfgCache then
    return self._sidebarTierRewardCfgCache
  end
  self._sidebarTierRewardCfgCache = self:_BuildSidebarTierRewardCfg()
  return self._sidebarTierRewardCfgCache
end

function GuideNoteTaskViewBase:_RefreshActivityRewardView()
  local activityItemNum = self:_GetActivityItemNum()
  local livenessRewardCfg = self:_GetLivenessRewardCfg()
  if self.ui.Text_ActivityItem_Num then
    self:SetText(self.ui.Text_ActivityItem_Num, tostring(activityItemNum))
  end
  local maxNeed = #livenessRewardCfg > 0 and livenessRewardCfg[#livenessRewardCfg].need or 0
  local ratio = maxNeed > 0 and math.max(0, math.min(1, activityItemNum / maxNeed)) or 0
  if self.ui.Image_ProgressBar then
    self:SetImageFillAmount(self.ui.Image_ProgressBar, ratio)
  end
  self:_ClearTierRewardItems()
  if not self.ui.Group_RewardsCon or not self.ui.UI_GuideNote_Item_Reward then
    return
  end
  if 0 == #livenessRewardCfg then
    self:SetActive(self.ui.Group_RewardsCon, false)
    return
  end
  self:SetActive(self.ui.Group_RewardsCon, true)
  local parentTf = self.ui.Group_RewardsCon.transform
  local rewardTemplateGo = self.ui.UI_GuideNote_Item_Reward.gameObject
  local items = {}
  local rewardLevelType = self:_GetRewardLevelType()
  for _, rewardCfg in ipairs(livenessRewardCfg) do
    local itemGo = self:Instantiate(rewardTemplateGo, parentTf)
    local itemRes = UIBaseResource(itemGo)
    self:SetActive(itemGo, true)
    local rewardLevel = rewardCfg.need
    local isReceived = GuideNoteModel.Instance:IsRewardReceived(rewardLevelType, rewardLevel)
    local isAvailable = activityItemNum >= rewardCfg.need and not isReceived
    self:SetActive(itemRes.Group_UnDone, not isAvailable and not isReceived)
    self:SetActive(itemRes.Group_Receive, isAvailable and not isReceived)
    self:SetActive(itemRes.Group_Done, isReceived)
    if itemRes.RedPoint then
      self:AddRedPoint(itemRes.RedPoint, RedDotDefine.DynamicRedDotID.GuideNoteTierReward, {
        show = isAvailable and not isReceived
      })
    end
    self:SetText(itemRes.Text_Count, tostring(rewardCfg.need))
    self:_SetRewardNodeHint(itemRes.Btn_Click, isAvailable)
    local rewardList = self:_BuildTierRewardList(rewardCfg.rewards)
    if itemRes.Btn_Click then
      self:AddButtonClickListener(itemRes.Btn_Click, function()
        if isAvailable and not isReceived then
          self:_ReqGetGuideNoteReward(rewardLevel)
          return
        end
        self:_ShowTierRewardTips(itemRes.Btn_Click, rewardList, 0, 50)
      end)
    end
    table.insert(items, itemGo)
  end
  self._tierRewardItems = items
end

function GuideNoteTaskViewBase:_SendGuideNoteRewardRequest(level, rewardLevelType)
  if GuideNoteController and GuideNoteController.Instance then
    GuideNoteController.Instance:ReqOnGetGuideNoteReward(rewardLevelType, level)
  end
end

function GuideNoteTaskViewBase:_CollectClaimableRewardLevels(rewardLevelType, clickedLevel)
  if not GuideNoteModel or not GuideNoteModel.Instance then
    return {}
  end
  local levelList = {}
  local levelMap = {}
  local activityValue = self:_GetActivityExpValue()
  local livenessRewardCfg = self:_GetLivenessRewardCfg()
  for idx, rewardCfg in ipairs(livenessRewardCfg) do
    local level = tonumber(rewardCfg.need) or idx
    local isReceived = GuideNoteModel.Instance:IsRewardReceived(rewardLevelType, level)
    if not isReceived and activityValue >= (rewardCfg.need or 0) then
      levelMap[level] = true
    end
  end
  if clickedLevel and levelMap[clickedLevel] then
    table.insert(levelList, clickedLevel)
    levelMap[clickedLevel] = nil
  end
  for _, rewardCfg in ipairs(livenessRewardCfg) do
    local level = tonumber(rewardCfg.need) or 0
    if levelMap[level] then
      table.insert(levelList, level)
      levelMap[level] = nil
    end
  end
  return levelList
end

function GuideNoteTaskViewBase:_CollectRewardsByLevel(levelList)
  local rewardsByLevel = {}
  local livenessRewardCfg = self:_GetLivenessRewardCfg()
  local cfgMap = {}
  for idx, rewardCfg in ipairs(livenessRewardCfg) do
    cfgMap[tonumber(rewardCfg.need) or idx] = rewardCfg
  end
  for _, level in ipairs(levelList or {}) do
    local cfg = cfgMap[level]
    rewardsByLevel[level] = cfg and cfg.rewards or nil
  end
  return rewardsByLevel
end

function GuideNoteTaskViewBase:_MergeRawRewards(rewardDict)
  local merged = {}
  local rewardList = {}
  for _, rawRewards in pairs(rewardDict or {}) do
    for i = 1, #(rawRewards or {}), 2 do
      local tid = rawRewards[i]
      local num = rawRewards[i + 1] or 0
      if tid and tid > 0 and num > 0 then
        merged[tid] = (merged[tid] or 0) + num
      end
    end
  end
  for tid, num in pairs(merged) do
    rewardList[#rewardList + 1] = tid
    rewardList[#rewardList + 1] = num
  end
  return rewardList
end

function GuideNoteTaskViewBase:_GetCoreRewardMultiplier()
  if self:_GetTaskServerIndex() == CommonDefine.TaskServerIndex.Daily and BattlePassDataUtils.IsCore() then
    local cfg = DT.Constant.BPExtraRewardMagnification
    return cfg and cfg.Data and cfg.Data[1] or 3
  end
  return 1
end

function GuideNoteTaskViewBase:_IsExtraRewardItem(tid)
  if not tid or tid <= 0 then
    return false
  end
  local cfg = DT.Constant.BPSeniorDoubleDailyRewardItem
  local allowedList = cfg and cfg.Data
  if not allowedList then
    return false
  end
  for _, allowedTid in ipairs(allowedList) do
    if allowedTid == tid then
      return true
    end
  end
  return false
end

function GuideNoteTaskViewBase:_ScaleCompleteAward(rawRewards, multiplier)
  if not rawRewards then
    return rawRewards
  end
  local isDoubleEx = BattlePassDataUtils.IsDoubleEx()
  if multiplier <= 1 and not isDoubleEx then
    return rawRewards
  end
  local scaled = {}
  for i = 1, #rawRewards, 2 do
    local tid = rawRewards[i]
    local num = rawRewards[i + 1] or 0
    scaled[#scaled + 1] = tid
    if multiplier > 1 and self:_IsExtraRewardItem(tid) then
      scaled[#scaled + 1] = num * multiplier
    elseif isDoubleEx and tid == BP_EXP_ITEM_TID then
      scaled[#scaled + 1] = num * 2
    else
      scaled[#scaled + 1] = num
    end
  end
  return scaled
end

function GuideNoteTaskViewBase:_ReqGetGuideNoteReward(level)
  local rewardLevelType = self:_GetRewardLevelType()
  local claimableLevelList = self:_CollectClaimableRewardLevels(rewardLevelType, level)
  if 0 == #claimableLevelList then
    return
  end
  local rewardsByLevel = self:_CollectRewardsByLevel(claimableLevelList)
  local mergedRawRewards = self:_MergeRawRewards(rewardsByLevel)
  if not GuideNoteController or not GuideNoteController.Instance then
    return
  end
  local multiplier = self:_GetCoreRewardMultiplier()
  local actualRewards = self:_ScaleCompleteAward(mergedRawRewards, multiplier)
  
  local function sendRequest()
    for _, claimLevel in ipairs(claimableLevelList) do
      self:_SendGuideNoteRewardRequest(claimLevel, rewardLevelType)
    end
  end
  
  local function checkEnergyThenSend()
    local energyOver = actualRewards and GetEnergyCheckUtils.CompleteAwardCheckEnergyOver(actualRewards) or false
    if energyOver then
      GetEnergyCheckUtils.TipsShow(sendRequest)
      return
    end
    sendRequest()
  end
  
  local stageOver = actualRewards and TaskDataUtils.TryShowStageGroupUnlockItemOverLimitTipByAward(actualRewards, checkEnergyThenSend) or false
  if stageOver then
    return
  end
  checkEnergyThenSend()
end

function GuideNoteTaskViewBase:_BuildTierRewardList(rawRewards)
  local rst = {}
  for i = 1, #rawRewards, 2 do
    local tid = rawRewards[i]
    local count = rawRewards[i + 1] or 0
    if tid and tid > 0 and count > 0 then
      table.insert(rst, {
        tid = tid,
        uid = 0,
        changedNum = count,
        awardType = nil,
        reason = CommonDefine.ItemReason.Task
      })
    end
  end
  return rst
end

function GuideNoteTaskViewBase:_ShowTierRewardTips(anchorGo, rewardList, shiftX, shiftY)
  if not anchorGo or 0 == #rewardList then
    return
  end
  local showRewardList = table.clone(rewardList)
  local isDaily = self:_GetTaskServerIndex() == CommonDefine.TaskServerIndex.Daily
  local isCore = isDaily and BattlePassDataUtils.IsCore()
  local isDoubleEx = BattlePassDataUtils.IsDoubleEx()
  for _, reward in ipairs(rewardList) do
    local tid = reward and reward.tid or 0
    local changedNum = reward and reward.changedNum or 0
    if tid > 0 and changedNum > 0 then
      if isCore and self:_IsExtraRewardItem(tid) then
        local extraMultiplier = self:_GetCoreRewardMultiplier() - 1
        if extraMultiplier > 0 then
          local extraDescText, extraDescBg = ItemDataUtils.GetExtraDescByReason(GuideNoteExtra)
          table.insert(showRewardList, {
            tid = tid,
            uid = 0,
            changedNum = changedNum * extraMultiplier,
            awardType = nil,
            reason = GuideNoteExtra,
            extraDesc = extraDescText,
            extraDescBgType = extraDescBg
          })
        end
      elseif isDoubleEx and tid == BP_EXP_ITEM_TID then
        local extraDescText, extraDescBg = ItemDataUtils.GetExtraDescByReason(BattlePassDoubleEx)
        table.insert(showRewardList, {
          tid = tid,
          uid = 0,
          changedNum = changedNum,
          awardType = nil,
          reason = BattlePassDoubleEx,
          extraDesc = extraDescText,
          extraDescBgType = extraDescBg
        })
      end
    end
  end
  UIManager.Instance:Reopen(Urls.GuideNoteTierRewardTipView, anchorGo, showRewardList, shiftX, shiftY)
end

function GuideNoteTaskViewBase:_HideTierRewardTips()
  UIManager.Instance:CloseByUrl(Urls.GuideNoteTierRewardTipView)
end

function GuideNoteTaskViewBase:_ClearTierRewardItems()
  if not self._tierRewardItems then
    return
  end
  for _, itemGo in ipairs(self._tierRewardItems) do
    if itemGo then
      CS.UnityEngine.GameObject.Destroy(itemGo)
    end
  end
  self._tierRewardItems = nil
end

function GuideNoteTaskViewBase:_OnClickActivityItem()
  local tid = self:_GetActivityItemTid()
  if not tid or tid <= 0 then
    return
  end
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_ActivityItem, nil, tid, true, self:_GetActivityItemTipExtraParam())
end

function GuideNoteTaskViewBase:_InitTaskItemGroupView()
  if not self.ui.TaskView or not self.ui.UI_GuideNote_Item_Task then
    return
  end
  local cellRT = self.ui.UI_GuideNote_Item_Task:GetComponent(TYPEOF_RectTransform)
  if not cellRT then
    return
  end
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.taskItemGroupView = self:CreateTableview(self.ui.TaskView, function()
    if not BpTaskModel.Instance.curTaskList then
      return 0
    end
    return #BpTaskModel.Instance.curTaskList
  end, function(view, index)
    do return self._TaskItemCellAtIndex, self, view end
    return self._TaskItemCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  self:PlayTableViewFadeInAnim(self.ui.TaskView)
end

function GuideNoteTaskViewBase:_TaskItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_GuideNote_Item_Task)
  local taskData = BpTaskModel.Instance.curTaskList and BpTaskModel.Instance.curTaskList[index] or nil
  if taskData then
    self:AddViewComponentOnce(cell.gameObject, CompGuideNoteTaskItem, taskData.uid, self:_GetTaskServerIndex())
  end
  return cell
end

function GuideNoteTaskViewBase:_RefreshSidebarRedDot()
  if not GuideNoteModel or not GuideNoteModel.Instance then
    return
  end
  local taskServerIndex = self:_GetTaskServerIndex()
  local rewardLevelType = self:_GetRewardLevelType()
  local isActivityFull = self:_IsActivityExpFull()
  local hasTaskReceive = false
  if not isActivityFull then
    hasTaskReceive = RedPointDataUtils.IsShowTaskReceiveRedDot({taskServerIndex})
  end
  local activityValue = GuideNoteModel.Instance:GetActivityExp(rewardLevelType)
  local tierCfg = self:_GetSidebarTierRewardCfg()
  local hasTierRewardReceive = false
  for idx, tier in ipairs(tierCfg) do
    local level = tonumber(tier.need) or idx
    local isReceived = GuideNoteModel.Instance:IsRewardReceived(rewardLevelType, level)
    if not isReceived and activityValue >= (tier.need or 0) then
      hasTierRewardReceive = true
      break
    end
  end
  GuideNoteModel.Instance:SetSidebarRedDot(self:_GetSidebarModuleType(), hasTaskReceive or hasTierRewardReceive)
end

function GuideNoteTaskViewBase:_IsActivityExpFull()
  if not GuideNoteModel or not GuideNoteModel.Instance then
    return false
  end
  local maxNeed = 0
  local tierCfg = self:_GetLivenessRewardCfg()
  for _, rewardCfg in ipairs(tierCfg) do
    local need = tonumber(rewardCfg.need) or 0
    if maxNeed < need then
      maxNeed = need
    end
  end
  return maxNeed > 0 and maxNeed <= GuideNoteModel.Instance:GetActivityExp(self:_GetRewardLevelType())
end

function GuideNoteTaskViewBase:_OnClose()
  self:_HideTierRewardTips()
  self:Close()
end

function GuideNoteTaskViewBase:OnExitView()
  self:_StopResetCountDownTimer()
  self:_ClearWaitShowRewardCloseCb()
  self:_HideTierRewardTips()
  Super.OnExitView(self)
end

function GuideNoteTaskViewBase:_ClearWaitShowRewardCloseCb()
  if self._waitShowRewardCloseCb then
    UIManager.Instance:RemovePanelCloseCb(Urls.ShowRewardPanel, self._waitShowRewardCloseCb)
    self._waitShowRewardCloseCb = nil
  end
  self._waitShowRewardCloseRegistered = false
end

function GuideNoteTaskViewBase:_StopResetCountDownTimer()
  if self._resetCountDownTimerId then
    self:StopTimer(self._resetCountDownTimerId)
    self._resetCountDownTimerId = nil
  end
end

function GuideNoteTaskViewBase:_StartResetCountDownTimer()
  self:_StopResetCountDownTimer()
  self:_RefreshResetCountDown()
  self._resetCountDownTimerId = self:BindTimer(1, -1, System.fn(self, self._RefreshResetCountDown))
end

function GuideNoteTaskViewBase:_GetResetCountDownSeconds()
  local svrIdx = self:_GetTaskServerIndex()
  local now = TimeUtils.GetServerTime()
  if svrIdx == CommonDefine.TaskServerIndex.Daily then
    local refreshHour = DT.GetConstant("Server_Refresh_Time")
    local nextTs = TimeCfgUtils.Get_Future_DailyRefresh_TimeStamp(refreshHour, now)
    do return math.max, 0 end
    return math.max, 0, nextTs - now
  end
  if svrIdx == CommonDefine.TaskServerIndex.Weekly then
    do return math.max, 0, TimeCfgUtils.GetNextMonday() end
    return math.max, 0, TimeCfgUtils.GetNextMonday()
  end
  return 0
end

function GuideNoteTaskViewBase:_FormatResetCountDownSeconds(countDown)
  if not countDown or countDown <= 0 then
    return ""
  end
  local d, h, m = TimeUtils.ConvertTime(countDown)
  if countDown >= TimeUtils.OneDaySeconds then
    do return LT.Textf, "BattlePassLeftTimeMore", d end
    return LT.Textf, "BattlePassLeftTimeMore", d, h
  end
  do return LT.Textf, "BattlePassLeftTimeLess", h end
  return LT.Textf, "BattlePassLeftTimeLess", h, m
end

function GuideNoteTaskViewBase:_GetResetCountdownPrefixText()
  do return LT.Text end
  return LT.Text, "GuideNote_ResetTime"
end

function GuideNoteTaskViewBase:_RefreshResetCountDown()
  if not self.ui or not self.ui.Text_Time then
    return
  end
  local sec = self:_GetResetCountDownSeconds()
  local timeStr = self:_FormatResetCountDownSeconds(sec)
  local prefix = self:_GetResetCountdownPrefixText()
  local full
  if "" ~= prefix and "" ~= timeStr then
    full = prefix .. " " .. timeStr
  elseif "" ~= prefix then
    full = prefix
  else
    full = timeStr
  end
  self:SetText(self.ui.Text_Time, full)
  if self.ui.Group_Time then
    self:SetActive(self.ui.Group_Time, "" ~= full)
  end
end

function GuideNoteTaskViewBase:_GetTaskServerIndex()
  return CommonDefine.TaskServerIndex.Daily
end

function GuideNoteTaskViewBase:_GetRewardLevelType()
  return GuideNoteDefine.LevelType.Daily
end

function GuideNoteTaskViewBase:_GetActivityExpValue()
  do return GuideNoteModel.Instance.GetActivityExp, GuideNoteModel.Instance, self:_GetRewardLevelType() end
  return GuideNoteModel.Instance.GetActivityExp, GuideNoteModel.Instance, self:_GetRewardLevelType()
end

function GuideNoteTaskViewBase:_GetSidebarModuleType()
  return GuideNoteDefine.ModuleType.DailyActivity
end

function GuideNoteTaskViewBase:_GetActivityItemTid()
  return 0
end

function GuideNoteTaskViewBase:_BuildLivenessRewardCfg()
  return {}
end

function GuideNoteTaskViewBase:_BuildSidebarTierRewardCfg()
  do return self._BuildLivenessRewardCfg end
  return self._BuildLivenessRewardCfg, self
end

function GuideNoteTaskViewBase:_GetActivityItemTipExtraParam()
  return {posY = -400}
end

function GuideNoteTaskViewBase:_SetRewardNodeHint(btnGo, available)
  if not btnGo then
    return
  end
  if available then
    self:SetButtonState(btnGo, CommonDefine.Z1ButtonState.High)
  else
    self:SetButtonState(btnGo, CommonDefine.Z1ButtonState.Normal)
  end
end

return GuideNoteTaskViewBase
