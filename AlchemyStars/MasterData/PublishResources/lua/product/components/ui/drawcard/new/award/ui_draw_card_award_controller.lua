_class("UIDrawCardAwardController", UIController)
UIDrawCardAwardController = UIDrawCardAwardController

function UIDrawCardAwardController:Constructor()
end

function UIDrawCardAwardController:OnShow(uiParams)
  self._questList = uiParams[1]
  self._comp = uiParams[2]
  self:_GetComponent()
  self:InitComponent()
end

function UIDrawCardAwardController:OnHide()
  if self._countTimer then
    GameGlobal.Timer():CancelEvent(self._countTimer)
    self._countTimer = nil
  end
end

function UIDrawCardAwardController:_GetComponent()
  self:AttachEvent(GameEventType.OnDrawCardGetAward, self.InitComponent)
  self._awardArea = self:GetUIComponent("UISelectObjectPath", "awardArea")
  self._leftTime = self:GetUIComponent("UILocalizationText", "leftTime")
  self._curTimeTxt = self:GetUIComponent("UILocalizationText", "curTimeTxt")
  self._finalAward = self:GetUIComponent("UISelectObjectPath", "finalAward")
  self._scrollRect = self:GetUIComponent("ScrollRect", "Scroll View")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIDrawCardAwardController:InitComponent()
  if not self.finalAward then
    local len = table.count(self._questList)
    self.finalAward = self._questList[len]
    table.remove(self._questList, len)
  end
  local finalAwardItem = self._finalAward:SpawnObject("UIDrawCardAwardItem")
  finalAwardItem:SetData(self.finalAward, 1, true, function(id, pos)
    self:OnItemSelect(id, pos)
  end, function()
    self:StartTask(function(TT)
      local res = AsyncRequestRes:New()
      local ret, rewards = self._comp:HandleOneKeyTakeQuest(TT, res)
      if res:GetSucc() then
        self:ShowDialog("UIGetItemController", rewards, function()
          GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDrawCardGetAward)
        end)
      else
        Log.fatal("一键领取所有奖励失败：", res:GetResult())
      end
    end)
  end)
  self._quests = self._awardArea:SpawnObjects("UIDrawCardAwardItem", #self._questList)
  for i, award in pairs(self._quests) do
    award:SetData(self._questList[i], i, false, function(id, pos)
      self:OnItemSelect(id, pos)
    end, function()
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        local ret, rewards = self._comp:HandleOneKeyTakeQuest(TT, res)
        if res:GetSucc() then
          self:ShowDialog("UIGetItemController", rewards, function()
            self:InitComponent()
            GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDrawCardGetAward)
          end)
        else
          Log.fatal("一键领取所有奖励失败：", res:GetResult())
        end
      end)
    end)
  end
  local questList = self._comp:GetQuestInfo()
  local finalQuest = questList[table.count(questList)]
  if finalQuest._questInfo.cur_progress >= finalQuest._questInfo.total_progress then
    self._curTimeTxt:SetText(StringTable.Get("str_aircraft_tactic_rank_btn_finish"))
  else
    self._curTimeTxt:SetText(StringTable.Get("str_draw_card_award_time_info1", finalQuest._questInfo.cur_progress))
  end
  self:CountDown()
  self._countTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:CountDown()
  end)
  local curQuest, index = self:GetCurQuest()
  local percent = index / table.count(self._questList)
  self._scrollRect.horizontalNormalizedPosition = percent
  self:StartTask(function(TT)
    local time = 18 * table.count(self._questList)
    self:Lock("UIDrawCardAwardController_Enter")
    YIELD(TT, time)
    self:UnLock("UIDrawCardAwardController_Enter")
  end)
end

function UIDrawCardAwardController:CountDown()
  if not tolua.isnull(self._anim) then
    local endTime = self._comp.m_component_info.m_close_time
    local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    local timeTxt = StringTable.Get("str_draw_card_award_time_info2", self:GetTimeString(endTime - curTime))
    self._leftTime:SetText(timeTxt)
    if endTime - curTime <= 0 then
      self:SwitchState(UIStateType.UIMain)
      ToastManager.ShowToast(StringTable.Get("str_junior_skin_draw_common_main_end"))
      return
    end
  end
end

function UIDrawCardAwardController:OnItemSelect(id, pos)
  if not self._selectInfo then
    local selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
    self._selectInfo = selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._selectInfo:SetData(id, pos)
end

function UIDrawCardAwardController:FullBtnOnClick()
  self:CloseDialog()
end

function UIDrawCardAwardController:GetCurQuest()
  local curQuest
  local questList = self._comp:GetQuestInfo()
  local index = 0
  for i, quest in pairs(questList) do
    if quest._questInfo.status < QuestStatus.QUEST_Completed then
      curQuest = quest
      index = i
      break
    elseif quest._questInfo.status == QuestStatus.QUEST_Completed then
      curQuest = quest
      index = i
      break
    end
  end
  if not curQuest then
    local len = table.count(questList)
    curQuest = questList[len]
    index = len
  end
  index = index == 1 and 0 or index
  return curQuest, index
end

function UIDrawCardAwardController:GetTimeString(seconds, dayStr, hourStr, minusStr, lessOneMinusStr)
  if seconds < 0 then
    seconds = 0
  end
  dayStr = dayStr or "str_activity_common_day"
  hourStr = hourStr or "str_activity_common_hour"
  minusStr = minusStr or "str_activity_common_minute"
  lessOneMinusStr = lessOneMinusStr or "str_activity_common_less_minute"
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = day .. StringTable.Get(dayStr)
    if 0 < hour then
      timeStr = timeStr .. hour .. StringTable.Get(hourStr)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = hour .. StringTable.Get(hourStr)
    end
    local minus = math.floor(seconds / 60)
    if minus ~= 0 then
      timeStr = timeStr .. minus .. StringTable.Get(minusStr)
    end
  else
    timeStr = StringTable.Get(lessOneMinusStr)
  end
  return timeStr
end
