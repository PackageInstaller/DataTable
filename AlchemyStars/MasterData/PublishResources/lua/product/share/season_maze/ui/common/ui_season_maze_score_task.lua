_class("UISeasonMazeScoreTask", UIController)
UISeasonMazeScoreTask = UISeasonMazeScoreTask

function UISeasonMazeScoreTask:OnShow(uiParams)
  self:InitWidget()
  self:OnValue()
  self:Lock("UISeasonMazeScoreTask_EnterAni")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:UnLock("UISeasonMazeScoreTask_EnterAni")
    self:_CheckGuide()
  end)
end

function UISeasonMazeScoreTask:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeScoreTask)
end

function UISeasonMazeScoreTask:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, function()
    UISeasonMazeModule.OpenHelpUI(UISeasonMazeHelperTabIndex.Temp2, 2)
  end, nil, false, nil, false, nil)
  self.scoreRewardPool = self:GetUIComponent("UISelectObjectPath", "ScoreRewardPool")
  self.scoreRewardRect = self:GetUIComponent("RectTransform", "ScoreRewardPool")
  self.viewportRect = self:GetUIComponent("RectTransform", "Viewport")
  self.ScoreTaskPool = self:GetUIComponent("UISelectObjectPath", "ScoreTaskPool")
  self.bigRewardPool = self:GetUIComponent("UISelectObjectPath", "bigReward")
  self.bigRewardObj = self:GetGameObject("BigReward")
  self.scrollRect = self:GetUIComponent("ScrollRect", "scrollRect")
  self.bigRewardScore = self:GetUIComponent("UILocalizationText", "bigRewardScore")
  self.curScore = self:GetUIComponent("UILocalizationText", "curScore")
  self.curScoreCircleoutline = self:GetUIComponent("UILocalizationText", "curScoreCircleoutline")
  self.slider = self:GetUIComponent("Image", "slider")
  self.scoreHandler = self:GetUIComponent("RectTransform", "scoreHandler")
  local s = self:GetUIComponent("UISelectObjectPath", "tips")
  self.lockText = self:GetUIComponent("UILocalizationText", "LockText")
  self.lockState = self:GetGameObject("LockState")
  self._tips = s:SpawnObject("UISelectInfo")
end

function UISeasonMazeScoreTask:OnValue()
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self._progressComponent = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.TOTAL_PROCESS)
  self._progressComponentInfo = self._progressComponent:GetComponentInfo()
  local itemID = self._progressComponent:GetItemId()
  local itemModule = GameGlobal.GetModule(ItemModule)
  self._scoreItemCount = itemModule:GetItemCount(itemID)
  self.curScore:SetText(self._scoreItemCount)
  self.curScoreCircleoutline:SetText(self._scoreItemCount)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:CheckUnlockScore()
  self:ShowSpecialTaskProgress()
  self:ShowRewardProgress()
  self:RefreshBigReward()
end

function UISeasonMazeScoreTask:OnUIGetItemCloseInQuest()
  self:ShowRewardProgress()
end

function UISeasonMazeScoreTask:RefreshBigReward()
  local itemHeight = 117
  local maxShowItemCount = 5
  local maxItemCount = #self.scoreTaskSpawnList
  local freshFunc
  
  function freshFunc()
    local curPosY = self.scoreRewardRect.anchoredPosition.y
    if not self.unlockAll then
      local isBottom = self.scoreRewardRect.anchoredPosition.y + self.viewportRect.rect.height >= math.floor(self.scoreRewardRect.sizeDelta.y)
      self.lockState:SetActive(isBottom)
    end
    local curPorgress = self._progressComponent:GetCurrentProgress()
    local curItem = self:GetItemWithProgress(curPorgress)
    local posY = 0
    if curItem then
      posY = curItem:GetBottomPosY()
    end
    local contentY = math.abs(curPosY)
    local viewportH = self.viewportRect.rect.height
    local sliderValue = (posY - contentY) / viewportH
    sliderValue = 1 < sliderValue and 1 or sliderValue
    sliderValue = sliderValue < 0 and 0 or sliderValue
    self.slider.fillAmount = sliderValue
    local shY = viewportH * (1 - sliderValue) - viewportH / 2
    self.scoreHandler.anchoredPosition = Vector2(self.scoreHandler.anchoredPosition.x, shY)
    local curLastIndex = math.floor(curPosY / itemHeight) + maxShowItemCount + 1
    curLastIndex = curLastIndex > maxItemCount and maxItemCount or curLastIndex
    for i = curLastIndex, #self.scoreTaskSpawnList do
      local item = self.scoreTaskSpawnList[i]
      if not item then
        break
      end
      local progress = item:GetProgress()
      if self._progressComponent:IsSpecialRewards(progress) then
        if self.curBigReward == progress then
          return
        end
        self.curBigReward = progress
        self:ShowBigReward(progress)
        break
      end
    end
    if self.curBigReward == nil then
      for i = #self.scoreTaskSpawnList, 1, -1 do
        local item = self.scoreTaskSpawnList[i]
        if not item then
          break
        end
        local progress = item:GetProgress()
        if self._progressComponent:IsSpecialRewards(progress) then
          if self.curBigReward == progress then
            return
          end
          self.curBigReward = progress
          self:ShowBigReward(progress)
          break
        end
      end
    end
  end
  
  self:Lock("UISeasonMazeScoreTask_fillAmountAnim")
  self:StartTask(function(TT)
    YIELD(TT)
    local viewportH = self.viewportRect.rect.height
    local maxY = self.scoreRewardRect.sizeDelta.y - viewportH
    local y, posY = self:GetLocationResetY()
    local hv = 0
    local sv = 0
    if y == 0 then
      hv = viewportH / 2 - posY
      sv = posY / viewportH
    elseif math.floor(y) == math.floor(maxY) then
      local v = viewportH - (self.scoreRewardRect.sizeDelta.y - posY)
      hv = viewportH / 2 - v
      sv = v / viewportH
    else
      hv = 0
      sv = 0.5
    end
    self.scoreRewardRect.anchoredPosition = Vector2(self.scoreRewardRect.anchoredPosition.x, y)
    freshFunc()
    self.slider.fillAmount = 0
    self.scoreHandler.anchoredPosition = Vector2(self.scoreHandler.anchoredPosition.x, viewportH / 2)
    self.scoreHandler:DOAnchorPosY(hv, 0.4):SetEase(DG.Tweening.Ease.OutQuad)
    self.slider:DOFillAmount(sv, 0.4):SetEase(DG.Tweening.Ease.OutQuad)
    YIELD(TT, 400)
    self:UnLock("UISeasonMazeScoreTask_fillAmountAnim")
    self.scrollRect.onValueChanged:AddListener(freshFunc)
  end)
end

function UISeasonMazeScoreTask:ShowBigReward(progress)
  local roleAssets = self._progressComponent:GetProgressRewards(progress)
  self.bigRewardPool:SpawnObjects("UISeasonMazeItem", #roleAssets)
  local spawnList = self.bigRewardPool:GetAllSpawnList()
  for i = 1, #roleAssets do
    local roleAsset = roleAssets[i]
    local obj = SeasonMazeEffect:New()
    obj.type = SeasonMazeEffectType.SMET_Once
    obj.id = roleAsset.assetid
    obj.value_min = roleAsset.count
    obj.value_max = roleAsset.count
    spawnList[i]:SetData(obj, self._tips, 1)
  end
  self.bigRewardScore:SetText(progress)
  local state = self._progressComponent:CheckItemStatus(progress)
  if state == CampaignPointProgressStatus.CPPS_Taken then
  end
end

function UISeasonMazeScoreTask:GetItemWithProgress(progress)
  for i = 1, #self.scoreTaskSpawnList do
    local item = self.scoreTaskSpawnList[i]
    if progress < item:GetProgress() then
      return self.scoreTaskSpawnList[i - 1]
    end
  end
  return self.scoreTaskSpawnList[#self.scoreTaskSpawnList]
end

function UISeasonMazeScoreTask:ShowRewardProgress()
  local progressList = {}
  local list = self._progressComponent:GetProgressList()
  for i = 1, #list do
    if list[i] <= self.scoreMax then
      table.insert(progressList, list[i])
    end
  end
  self.scoreRewardPool:SpawnObjects("UISeasonMazeScroreRewarditem", #progressList)
  self.scoreTaskSpawnList = self.scoreRewardPool:GetAllSpawnList()
  for i = 1, #progressList do
    local roleAssets = self._progressComponent:GetProgressRewards(progressList[i])
    roleAssets = roleAssets or {}
    local state = self._progressComponent:CheckItemStatus(progressList[i])
    self.scoreTaskSpawnList[i]:SetData(roleAssets, progressList[i], state, self._tips, self)
  end
end

function UISeasonMazeScoreTask:OnRewardProgressSelect(progress, state)
  for i = 1, #self.scoreTaskSpawnList do
    self.scoreTaskSpawnList[i]:SetSelect(progress)
  end
  if state == CampaignPointProgressStatus.CPPS_Completed then
    self:StartTask(self.GetListItemRewardReqProgress, self, progress)
  end
end

function UISeasonMazeScoreTask:CheckUnlockScore()
  self.unlockAll = true
  local timeMap = {}
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local seasonMazeCfgs = Cfg.cfg_component_season_maze({
    ComponentID = self.cmptId
  })
  for _, v in pairs(seasonMazeCfgs) do
    local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(v.LockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    timeMap[curTime - time] = v
  end
  local latestUnlock, nextUnlock
  for t, v in pairs(timeMap) do
    if 0 < t then
      latestUnlock = latestUnlock == nil and t or math.min(t, latestUnlock)
    end
    if t < 0 then
      self.unlockAll = false
      nextUnlock = nextUnlock == nil and t or math.max(t, nextUnlock)
    end
  end
  self.scoreMax = timeMap[latestUnlock].ScoreMax
  if not self.unlockAll then
    local remainTime = UIActivityHelper.GetFormatTimerStr(math.abs(nextUnlock))
    self.lockText:SetText(StringTable.Get("str_season_maze_save_unlock_limit", remainTime))
  end
end

function UISeasonMazeScoreTask:ShowSpecialTaskProgress()
  local finishScoreList = {}
  local noFinishScoreList = {}
  local finishHardList = {}
  local noFinishHardList = {}
  local taskList = {}
  local seasonMazeCfgs = Cfg.cfg_component_season_maze({
    ComponentID = self.cmptId
  })
  for _, v in pairs(seasonMazeCfgs) do
    taskList[v.Hard] = v.ClearingScore
  end
  for i = 1, #taskList do
    local hard = i
    local t = taskList[i]
    local hardInfo = self._componentInfo.hard_num[hard]
    if hardInfo then
      for j = 1, #t do
        local count = t[j][1]
        if count <= hardInfo.vic_count then
          table.insert(finishScoreList, t[j])
          table.insert(finishHardList, hard)
        else
          table.insert(noFinishScoreList, t[j])
          table.insert(noFinishHardList, hard)
        end
      end
    else
      for j = 1, #t do
        table.insert(noFinishScoreList, t[j])
        table.insert(noFinishHardList, hard)
      end
    end
  end
  local count = #finishScoreList + #noFinishScoreList
  self.ScoreTaskPool:SpawnObjects("UISeasonMazeSpecialScoreTaskitem", count)
  local spawnList = self.ScoreTaskPool:GetAllSpawnList()
  for i = 1, #spawnList do
    local finish = false
    local hard = noFinishHardList[i]
    local v = noFinishScoreList[i]
    if not v then
      hard = finishHardList[i - #noFinishHardList]
      v = finishScoreList[i - #noFinishScoreList]
      finish = true
    end
    spawnList[i]:SetData(v, hard, finish)
  end
end

function UISeasonMazeScoreTask:GetListItemRewardReqProgress(TT, param)
  self:Lock("UISeasonMazeScoreTask:GetListItemRewardReqProgress")
  local progress = param
  local res = AsyncRequestRes:New()
  local rewards = self._progressComponent:HandleOneKeyReceiveRewards(TT, res)
  self:UnLock("UISeasonMazeScoreTask:GetListItemRewardReqProgress")
  if res:GetSucc() then
    self:ShowUIGetItemController(rewards)
  elseif self._progressComponent:ComponentIsClose() then
    res:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
    self._seasonMazeModule:CheckSeasonMazeClose(res)
  end
end

function UISeasonMazeScoreTask:ShowUIGetItemController(rewards)
  if not rewards then
    return
  end
  
  local function cbFunc()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
  end
  
  self:ShowDialog("UIGetItemController", rewards, cbFunc)
end

function UISeasonMazeScoreTask:LocationBtnOnClick()
  local y = self:GetLocationResetY()
  self.scrollRect:StopMovement()
  self.scoreRewardRect.anchoredPosition = Vector2(self.scoreRewardRect.anchoredPosition.x, y)
end

function UISeasonMazeScoreTask:GetLocationResetY()
  local curPorgress = self._progressComponent:GetCurrentProgress()
  local curItem = self:GetItemWithProgress(curPorgress)
  local posY = 0
  if curItem then
    posY = curItem:GetBottomPosY()
  end
  local viewportH = self.viewportRect.rect.height
  local maxY = self.scoreRewardRect.sizeDelta.y - viewportH
  local y = posY - viewportH / 2
  y = y < 0 and 0 or y
  y = maxY < y and maxY or y
  return y, posY
end
