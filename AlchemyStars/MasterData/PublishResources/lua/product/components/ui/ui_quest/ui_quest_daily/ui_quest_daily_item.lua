_class("UIQuestDailyItem", UICustomWidget)
UIQuestDailyItem = UIQuestDailyItem

function UIQuestDailyItem:OnShow(uiParams)
  self.rootAnim = self:GetUIComponent("Animation", "UIQuestDailyItem")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "UIQuestDailyItem")
  self._canvasGroup.blocksRaycasts = false
  self._itemCountPerRow = 1
  self._isFirst = true
  self.needMoveIndex = false
  self._dispatchTypeQuest = QuestType.QT_Daily
  self._dispatchTypeActive = QuestType.QT_Daily + 100
  self._dispatchTypeAll = QuestType.QT_Daily + 10000
  self._atlas = self:GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
  self._curPoint = 0
  self:AttachEvents()
end

function UIQuestDailyItem:UIQuestDailyReset()
  self:ShowDialog("UIRugueLikeResetMsgBoxController", StringTable.Get("str_quest_base_daily_reset_tips"))
  self:ShowActivityTitle()
end

function UIQuestDailyItem:RefreshDailyQuestList()
  self:RefrenshList()
end

function UIQuestDailyItem:SetData(type)
  self._canvasGroup.blocksRaycasts = true
  self._isOpen = true
  self:_GetComponents()
  self._type = type
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._questModule = GameGlobal.GetModule(QuestModule)
  if self._questModule == nil then
    Log.fatal("[quest] error --> questModule is nil !")
    return
  end
  self._questList = self:_GetTaskList()
  self._taskCount = table.count(self._questList)
  self:_OnValue()
  self.rootAnim:Play("uieff_UIQuestController_dailyTypePool_in")
  self._canvasGroup.alpha = 1
end

function UIQuestDailyItem:_GetTaskList()
  local taskList = self._questModule:GetQuestByQuestType(self._type)
  local taskListT = {}
  for i = 1, #taskList do
    local quest = taskList[i]:QuestInfo()
    if quest.status ~= QuestStatus.QUEST_NotStart then
      table.insert(taskListT, taskList[i])
    end
  end
  return taskListT
end

function UIQuestDailyItem:RefrenshList()
  self._questList = self:_GetTaskList()
  self._taskCount = table.count(self._questList)
  local contentPos = self._list.ScrollRect.content.localPosition
  self._list:SetListItemCount(self._taskCount)
  self._list:MovePanelToItemIndex(0, 0)
  self._list:ResetListView()
  self:StartTask(self.RefrenshListAndPlay, self)
  if not self._list.gameObject.activeInHierarchy then
    self.needMoveIndex = true
    if self.taskRefreshMove then
      TaskManager:GetInstance():KillTask(self.taskRefreshMove)
      self.taskRefreshMove = nil
    end
    self.taskRefreshMove = TaskManager:GetInstance():StartStoppableTask(self.TaskRefreshMoveIndex, self)
  end
  self:_ShowActivePoint()
  self:DailyQuestTimeRefresh()
  self:ShowWeekAwards()
end

function UIQuestDailyItem:RefrenshListAndPlay(TT)
  if not self._list.gameObject.activeInHierarchy then
    self:UnLock("UIQuestDailyItem:RefrenshListAndPlay")
    return
  end
  self:Lock("UIQuestDailyItem:RefrenshListAndPlay")
  local yieldTime = 0
  local questCount = #self._questList
  if 5 < questCount then
    questCount = 5
  end
  for i = 1, questCount do
    local quest = self._questList[i]:QuestInfo()
    for j = 1, #self.items do
      local item = self.items[j]
      if quest.quest_id == item._quest.quest_id then
        yieldTime = (i - 1) * 50
        item:InitAnim()
        GameGlobal.Timer():AddEvent(yieldTime, function()
          if self._list.gameObject.activeInHierarchy then
            item:PlayAnim()
          end
        end)
      end
    end
  end
  YIELD(TT, yieldTime)
  local totalTime = questCount * 50
  GameGlobal.Timer():AddEvent(totalTime, function()
    self:UnLock("UIQuestDailyItem:RefrenshListAndPlay")
  end)
end

function UIQuestDailyItem:TaskRefreshMoveIndex(TT)
  while not self._list.gameObject.activeInHierarchy do
    YIELD(TT)
  end
  self:Lock("TaskRefreshMoveIndex")
  while self.needMoveIndex do
    YIELD(TT)
    if self._list == nil or self._list.gameObject == nil then
      self.taskRefreshMove = nil
      self:UnLock("TaskRefreshMoveIndex")
      return
    end
    if self._list.gameObject.activeInHierarchy then
      self.needMoveIndex = false
    end
  end
  self._list:MovePanelToItemIndex(0, 0)
  self.taskRefreshMove = nil
  for j = 1, #self.items do
    local item = self.items[j]
    if self._list.gameObject.activeInHierarchy then
      Log.debug("[FX] 重置隐藏后的动画状态!")
    end
  end
  self:UnLock("TaskRefreshMoveIndex")
end

function UIQuestDailyItem:RefrenshActivePoint()
  self:_ShowActivePoint()
end

function UIQuestDailyItem:GetFillAmount(val)
  local cst = {
    0.099,
    0.327,
    0.554,
    0.782,
    1
  }
  local idx = math.modf(val / 20)
  if idx >= #cst then
    return 1
  end
  local rate = cst[idx] or 0
  local next = cst[idx + 1]
  local min = rate
  local max = next
  local ret = (val - idx * 20) / 20 * (max - min) + min
  return ret
end

function UIQuestDailyItem:_ShowActivePoint()
  self._activePoint = self._questModule:GetDailyQuestVigorous()
  Log.debug("###[UIQuestDailyItem] _ShowActivePoint --> ", self._activePoint)
  self._cfg_vigorous_reward = Cfg.cfg_vigorous_reward({})
  if self._cfg_vigorous_reward == nil then
    Log.fatal("[quest] error --> _cfg_vigorous_reward is nil ! name --> cfg_vigorous_reward")
    return
  end
  self:Lock("_ShowActivePoint")
  local count = table.count(self._cfg_vigorous_reward)
  local upper = self._cfg_vigorous_reward[count].VigPoint
  local rate = self._activePoint / upper
  if 1 < rate then
    rate = 1
  end
  self._activePointValue:SetText("<size=80>" .. self._activePoint .. "</size>")
  if self._curPoint ~= rate then
    local phase1Rate = 0.85
    local phase1Time = 0.5
    local phase2Time = 1.25
    self._activePointImg.fillAmount = 0
    local phase1 = rate * phase1Rate
    self._activePointImg:DOFillAmount(phase1, phase1Time)
    GameGlobal.Timer():AddEvent(phase1Time * 1000, function()
      if self._activePointImg.gameObject ~= nil and self._activePointImg.gameObject.activeInHierarchy then
        self._activePointImg:DOFillAmount(rate, phase2Time):SetEase(DG.Tweening.Ease.OutCirc)
      end
      self:UnLock("_ShowActivePoint")
    end)
    local initX = self._activeImgLeftAnchor.anchoredPosition.x
    local maxX = self._activeImgRightAnchor.anchoredPosition.x
    local curX = initX + (maxX - initX) * self._curPoint
    local tarX = initX + (maxX - initX) * rate
    local tarXPhase1 = initX + (maxX - initX) * rate * phase1Rate
    self._effObj.transform:DOAnchorPosX(curX, 0)
    self._effObj:SetActive(false)
    if rate ~= 0 then
      self._effObj:SetActive(true)
      self._effObj.transform:DOAnchorPosX(tarXPhase1, phase1Time)
      GameGlobal.Timer():AddEvent(phase1Time * 1000, function()
        if self._effObj ~= nil and self._effObj.activeInHierarchy then
          self._effObj.transform:DOAnchorPosX(tarX, phase2Time):SetEase(DG.Tweening.Ease.OutCirc)
        end
        self:UnLock("_ShowActivePoint")
      end)
    else
      self:UnLock("_ShowActivePoint")
    end
    self._curPoint = rate
  else
    self._activePointImg.fillAmount = rate
    self:UnLock("_ShowActivePoint")
  end
  local huoValue = upper * rate
  local highLightIndex = 0
  for i = 1, count do
    local point = self._cfg_vigorous_reward[i]
    if huoValue >= point.VigPoint then
      highLightIndex = i
    end
  end
  local width = self._activePointPoolRect.sizeDelta.x
  self._activePointPool:SpawnObjects("UIQuestDailyActivePointItem", count)
  local aps = self._activePointPool:GetAllSpawnList()
  for i = 1, count do
    local high = false
    if i == highLightIndex then
      high = true
    end
    local _posX = self._cfg_vigorous_reward[i].VigPoint / upper * width
    aps[i]:SetData(i, self._cfg_vigorous_reward, self._activePoint, _posX, function(idx)
      self:ActivePointItemClick(idx)
    end, function(items, pos)
      self._awardPool:SpawnObjects("UIQuestSideAwardItem", #items)
      local pools = self._awardPool:GetAllSpawnList()
      self.rewadItems = {}
      for i = 1, #items do
        local award = pools[i]
        self.rewadItems[i] = award
      end
      if #items == 2 then
        self._checkAwadeImage.sprite = self._atlas:GetSprite("task_daily_jianglidi1")
        self._checkAwadeRectTf.sizeDelta = Vector2(360, 216)
        self._awardPoolRect.anchoredPosition = Vector2(-58.5, -25.1)
        pos = pos + Vector2(-126, 176)
      elseif #items == 3 then
        self._checkAwadeImage.sprite = self._atlas:GetSprite("task_daily_jianglidi2")
        self._checkAwadeRectTf.sizeDelta = Vector2(528, 215)
        self._awardPoolRect.anchoredPosition = Vector2(-136.5, -25.1)
        pos = pos + Vector2(-213, 176)
      end
      self._checkAwade:SetActive(true)
      self._checkAwadeRectTf.anchoredPosition = pos
      for i = 1, #items do
        local rew = self.rewadItems[i]
        local id = items[i].assetid
        local cfg_item = Cfg.cfg_item[id]
        local params = {}
        params.quality = cfg_item.Color
        params.icon = cfg_item.Icon
        params.text = items[i].count
        rew:SetData(id, params, function(matid, pos)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, matid, pos)
        end)
      end
    end, high)
  end
end

function UIQuestDailyItem:ActivePointItemClick(idx)
  self:Lock("UIQuestGet")
  self:StartTask(self.OnActivePointItemClick, self, -1)
end

function UIQuestDailyItem:OnActivePointItemClick(TT, idx)
  local res, msg = self._questModule:TakeVigReward(TT, idx)
  self:UnLock("UIQuestGet")
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local rewards = msg.rewards
    self:ShowDialog("UIGetItemController", rewards, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, self._dispatchTypeActive)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestUpdate)
    end)
  end
end

function UIQuestDailyItem:DailyQuestTimeRefresh()
  self._timeStrColor = "ffe701"
  self:ShowSurTime()
  self:OpenSurSecond()
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tips)
end

function UIQuestDailyItem:CalSurSecond()
  if self._svrTimeModule == nil then
    self._svrTimeModule = self:GetModule(SvrTimeModule)
  end
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if self._questModule == nil then
    self._questModule = self:GetModule(QuestModule)
  end
  local questModule = self._questModule
  local resetTime = questModule:GetQuestDailyRefreshTime(svrTime)
  self._surSecond = resetTime - svrTime
end

function UIQuestDailyItem:Second2TimeStr(second)
  local sec = math.floor(second % 60)
  local min = math.floor(second / 60 % 60)
  local hour = math.floor(second / 60 / 60)
  local secStr
  if sec < 10 then
    secStr = "0" .. sec
  else
    secStr = sec
  end
  local minStr
  if min < 10 then
    minStr = "0" .. min
  else
    minStr = min
  end
  local hourStr
  if hour < 10 then
    hourStr = "0" .. hour
  else
    hourStr = hour
  end
  local str = hourStr .. ":" .. minStr .. ":" .. secStr
  return str
end

function UIQuestDailyItem:OpenSurSecond()
  if self._surTimeEvent then
    GameGlobal.Timer():CancelEvent(self._surTimeEvent)
    self._surTimeEvent = nil
  end
  self._surTimeEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:ShowSurTime()
  end)
end

function UIQuestDailyItem:ShowSurTime()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local resetTime = self._questModule:GetQuestDailyRefreshTime(svrTime)
  local timeStamp = resetTime - svrTime
  if 0 < timeStamp then
    local timeStr = self:Second2TimeStr(timeStamp)
    local showStr = "<color=#" .. self._timeStrColor .. ">" .. timeStr .. "</color>"
    self._refreshTipTex:SetText(string.format(StringTable.Get("str_quest_base_daily_refresh_tip"), showStr))
  else
  end
end

function UIQuestDailyItem:Time2Day(unixTime)
  local tb = {}
  tb.year = tonumber(os.date("%Y", unixTime))
  tb.month = tonumber(os.date("%m", unixTime))
  tb.day = tonumber(os.date("%d", unixTime))
  tb.hour = tonumber(os.date("%H", unixTime))
  tb.minute = tonumber(os.date("%M", unixTime))
  tb.second = tonumber(os.date("%S", unixTime))
  return tb
end

function UIQuestDailyItem:OnClose()
  self._isOpen = false
  self.rootAnim:Stop()
  self._canvasGroup.alpha = 0
  if self._surTimeEvent then
    GameGlobal.Timer():CancelEvent(self._surTimeEvent)
    self._surTimeEvent = nil
  end
  self._canvasGroup.blocksRaycasts = false
end

function UIQuestDailyItem:OnHide()
  if self.taskRefreshMove then
    TaskManager:GetInstance():KillTask(self.taskRefreshMove)
    self.taskRefreshMove = nil
  end
  if self._surTimeEvent then
    GameGlobal.Timer():CancelEvent(self._surTimeEvent)
    self._surTimeEvent = nil
  end
  self:RemoveEvents()
end

function UIQuestDailyItem:_GetComponents()
  self._list = self:GetUIComponent("UIDynamicScrollView", "taskList")
  self._activePointPool = self:GetUIComponent("UISelectObjectPath", "activePoint")
  self._activePointPoolRect = self:GetUIComponent("RectTransform", "activePoint")
  self._activePointImg = self:GetUIComponent("Image", "activePointImg")
  self._activePointValue = self:GetUIComponent("UILocalizationText", "activePointValue")
  self._refreshTipTex = self:GetUIComponent("UILocalizationText", "refreshTipTex")
  self._activityTitle = self:GetGameObject("activityTitle")
  self._weekAwards = self:GetUIComponent("Image", "WeekAwards")
  self._weekAwardsTex = self:GetUIComponent("UILocalizationText", "weekAwardsTex")
  self._weekAwardRoot = self:GetGameObject("weekAwardRoot")
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
  self._checkAwade = self:GetGameObject("CheckAwade")
  self._checkAwade:SetActive(false)
  self._checkAwadeRectTf = self:GetUIComponent("RectTransform", "CheckAwadeRt")
  self._checkAwadeImage = self:GetUIComponent("Image", "CheckAwadeRt")
  self._effObj = self:GetGameObject("eff")
  self._effObj:SetActive(false)
  self._activeImgLeftAnchor = self:GetUIComponent("RectTransform", "activeImgLeftAnchor")
  self._activeImgRightAnchor = self:GetUIComponent("RectTransform", "activeImgRightAnchor")
  self._awardPool = self:GetUIComponent("UISelectObjectPath", "awardPool")
  self._tips = self:GetUIComponent("RectTransform", "tips")
  self._awardPoolRect = self:GetUIComponent("RectTransform", "awardPool")
  self.items = {}
end

function UIQuestDailyItem:_OnValue()
  if self._isFirst then
    self._list:InitListView(self._taskCount, function(scrollView, index)
      return self:_InitDailyTaskList(scrollView, index)
    end)
    self._isFirst = false
    self:_ShowActivePoint()
    self:DailyQuestTimeRefresh()
    self:StartTask(self.RefrenshListAndPlay, self)
  else
    self._curPoint = 0
    self:RefrenshList()
  end
  self:ShowActivityTitle()
  self:ShowWeekAwards()
end

function UIQuestDailyItem:ShowWeekAwards()
  local weekQuestList = self._questModule:GetQuestByQuestType(QuestType.QT_Week)
  if weekQuestList and 0 < #weekQuestList then
    self._weekAwardRoot:SetActive(true)
    self._weekQuest = weekQuestList[1]
    Log.debug("###[UIQuestDailyItem] ShowWeekAwards get quest succ !")
    self._weekQuestInfo = self._weekQuest:QuestInfo()
    local weekActiveVal = self._weekQuestInfo.cur_progress
    local weekActiveGetVal = self._weekQuestInfo.total_progress
    self._weekAwardStatus = self._weekQuestInfo.status
    Log.debug("###[UIQuestDailyItem] ShowWeekAwards _weekAwardStatus:", self._weekAwardStatus)
    local sprite
    if self._weekAwardStatus == QuestStatus.QUEST_Taken then
      sprite = "task_week_icon3"
    elseif self._weekAwardStatus == QuestStatus.QUEST_Completed then
      sprite = "task_week_icon2"
    else
      sprite = "task_week_icon1"
    end
    self._weekAwardsTex:SetText("<size=40>" .. weekActiveVal .. [[
</size>
/]] .. weekActiveGetVal)
    self._weekAwards.sprite = self._atlas:GetSprite(sprite)
  else
    Log.fatal("###[UIQuestDailyItem] 没有获取到周任务，查看任务配置")
    self._weekAwardRoot:SetActive(false)
  end
end

function UIQuestDailyItem:WeekAwardsOnClick(go)
  Log.debug("###[UIQuestDailyItem] WeekAwardsOnClick !")
  if self._weekAwardStatus == QuestStatus.QUEST_Completed then
    self:GetQuestItemAward(self._weekQuestInfo.quest_id)
  elseif self._weekAwardStatus == QuestStatus.QUEST_Taken then
    local tips = StringTable.Get("str_quest_base_dayli_tips_awards_got")
    ToastManager.ShowToast(tips)
  else
    local awards = self._weekQuestInfo.rewards
    local total = self._weekQuestInfo.total_progress
    local endTime = self._questModule:GetWeekRefreshTime()
    self:ShowDialog("UIQuestDailyWeekAwards", awards, endTime, total)
  end
end

function UIQuestDailyItem:CheckAwadeBtnOnClick(go)
  self._checkAwade:SetActive(false)
end

function UIQuestDailyItem:ShowActivityTitle()
  local isOpen = false
  local cfg = Cfg.cfg_quest_daily_extra_activity[1]
  if not cfg then
    Log.fatal("###[UIQuestDailyItem] cfg is nil ! id --> ", 1)
  else
    local loginModule = GameGlobal.GetModule(LoginModule)
    local svrTime = self._svrTimeModule:GetServerTime() * 0.001
    local startTimeStr = cfg.StartTime
    local endTimeStr = cfg.EndTime
    local openTime = loginModule:GetTimeStampByTimeStr(startTimeStr, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
    local closeTime = loginModule:GetTimeStampByTimeStr(endTimeStr, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
    if svrTime >= openTime and svrTime < closeTime then
      isOpen = true
    end
  end
  self._activityTitle:SetActive(isOpen)
end

function UIQuestDailyItem:_InitDailyTaskList(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIQuestDailyListItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    self:_ShowDailyItem(heartItem, itemIndex)
    local has = false
    for i = 0, #self.items do
      local item = self.items[i]
      if item == heartItem then
        has = true
      end
    end
    if not has then
      self.items[#self.items + 1] = heartItem
    end
  end
  return item
end

function UIQuestDailyItem:_ShowDailyItem(heartItem, index)
  if index == 1 then
    if not self.guideItems then
      self.guideItems = {}
    end
    self.guideItems[1] = heartItem
  elseif index == 2 then
    if not self.guideItems then
      self.guideItems = {}
    end
    self.guideItems[2] = heartItem
  end
  local quest = self._questList[index]
  heartItem:GetGameObject():SetActive(true)
  if quest ~= nil then
    heartItem:SetData(index, quest, function(questInfo)
      self:QuestItemClick(questInfo)
    end, function(matid, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, matid, pos)
    end)
  end
end

function UIQuestDailyItem:QuestItemClick(questInfo)
  if questInfo.status <= QuestStatus.QUEST_Accepted then
    local jumpModule = self._questModule.uiModule
    if jumpModule == nil then
      Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
      return
    end
    local fromParam = {}
    table.insert(fromParam, QuestType.QT_Daily)
    jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
    local jumpType = questInfo.JumpID
    local jumpParams = questInfo.JumpParam
    jumpModule:SetJumpUIData(jumpType, jumpParams)
    jumpModule:Jump()
  elseif questInfo.status == QuestStatus.QUEST_Completed then
    self:getAllBtnOnClick()
  end
end

function UIQuestDailyItem:GetQuestItemAward(id)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIQuestGet")
  self:StartTask(self._GetQuestItemAwardReq, self, id)
end

function UIQuestDailyItem:_GetQuestItemAwardReq(TT, id)
  local res, msg = self._questModule:TakeQuestReward(TT, id)
  self:UnLock("UIQuestGet")
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local tempPets = {}
    local pets = msg.rewards
    self._tempMsgRewards = msg.rewards
    if 0 < #pets then
      for i = 1, #pets do
        local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
        if ispet then
          table.insert(tempPets, pets[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, self._dispatchTypeQuest)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, self._dispatchTypeQuest)
      end)
    end
  end
end

function UIQuestDailyItem:AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
  self:AttachEvent(GameEventType.UIQuestDailyReset, self.UIQuestDailyReset)
  self:AttachEvent(GameEventType.UIQuestDailyVigorous, self.UIQuestDailyVigorous)
  self:AttachEvent(GameEventType.OnWeekRewardChanged, self.ShowWeekAwards)
end

function UIQuestDailyItem:RemoveEvents()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
  self:DetachEvent(GameEventType.UIQuestDailyReset, self.UIQuestDailyReset)
  self:DetachEvent(GameEventType.UIQuestDailyVigorous, self.UIQuestDailyVigorous)
  self:DetachEvent(GameEventType.OnWeekRewardChanged, self.ShowWeekAwards)
end

function UIQuestDailyItem:UIQuestDailyVigorous()
  Log.debug("###[UIQuestDailyItem] UIQuestDailyVigorous!")
  self:_ShowActivePoint()
end

function UIQuestDailyItem:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    if type == self._dispatchTypeQuest then
      self:RefrenshList()
    elseif type == self._dispatchTypeActive then
      self:RefrenshActivePoint()
    elseif type == self._dispatchTypeAll then
      self:RefrenshList()
    end
  end
end

function UIQuestDailyItem:OnUIPetObtainCloseInQuest(type)
  if self._isOpen then
    if type == self._dispatchTypeQuest then
      self:ShowDialog("UIGetItemController", self._tempMsgRewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, self._dispatchTypeQuest)
      end)
    elseif type == self._dispatchTypeAll then
      self:ShowDialog("UIGetItemController", self._tempMsgRewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, self._dispatchTypeAll)
      end)
    end
    self._list:MovePanelToItemIndex(0, 0)
  end
end

function UIQuestDailyItem:getAllBtnOnClick()
  local canClick = self:_CheckCanOneKeyReward()
  if canClick then
    self:Lock("UIQuestGet")
    self:StartTask(self.OngetAllBtnOnClick, self)
  end
end

function UIQuestDailyItem:_CheckCanOneKeyReward()
  local canClick = false
  for key, value in pairs(self._questList) do
    local questInfo = value
    if questInfo:QuestInfo().status == QuestStatus.QUEST_Completed then
      canClick = true
      break
    end
  end
  if not canClick then
    local aps = self._activePointPool:GetAllSpawnList()
    for i = 1, table.count(aps) do
      local canGetActive = aps[i]:GetActiveState()
      if canGetActive then
        canClick = true
        break
      end
    end
  end
  if not canClick and self._weekQuest and self._weekAwardStatus == QuestStatus.QUEST_Completed then
    canClick = true
  end
  return canClick
end

function UIQuestDailyItem:OngetAllBtnOnClick(TT)
  local res, msg = self._questModule:TakeOneKeyReward(TT, self._type)
  self:UnLock("UIQuestGet")
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local tempPets = {}
    local pets = msg.rewards
    self._tempMsgRewards = msg.rewards
    if 0 < #pets then
      for i = 1, #pets do
        local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
        if ispet then
          table.insert(tempPets, pets[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, self._dispatchTypeAll)
      end)
    elseif 0 < table.count(msg.rewards) then
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, self._dispatchTypeAll)
      end)
    else
      local tips = StringTable.Get("str_physicalpower_error_phy_add_full")
      ToastManager.ShowToast(tips)
    end
  end
end

function UIQuestDailyItem:GetGuideItemBtn(index)
  if self.guideItems then
    local item = self.guideItems[index]
    if item then
      return item:GetBtnObj()
    end
  end
end
