_class("UIQuestDailyWeekAwards", UIController)
UIQuestDailyWeekAwards = UIQuestDailyWeekAwards

function UIQuestDailyWeekAwards:OnShow(uiParams)
  self._awards = uiParams[1]
  self._endTime = uiParams[2]
  self._maxValue = uiParams[3]
  self:GetComponents()
  self:OnValue()
end

function UIQuestDailyWeekAwards:GetComponents()
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = self._itemInfo:SpawnObject("UISelectInfo")
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._titleNameTex = self:GetUIComponent("UILocalizationText", "titleName")
  self._timerTex = self:GetUIComponent("UILocalizationText", "timerTex")
  self._tipsTex = self:GetUIComponent("UILocalizationText", "tipsTex")
end

function UIQuestDailyWeekAwards:OnValue()
  local count = #self._awards
  if self._titleName then
    self._titleNameTex:SetText(StringTable.Get(self._titleName))
  end
  local scrollView = self:GetGameObject("itemScrollView")
  local content = self:GetGameObject("pool")
  self._pool:SpawnObjects("UIQuestDailyWeekAwardsItem", count)
  self._items = self._pool:GetAllSpawnList()
  for i = 1, count do
    local item = self._items[i]
    local data = self._awards[i]
    item:SetData(i, data, function(id, pos)
      self:OnItemClick(id, pos)
    end)
  end
  self:InitTimer()
  self:Tips()
end

function UIQuestDailyWeekAwards:Tips()
  local WeekQuestResetDay = Cfg.cfg_global.WeekQuestResetDay.IntValue
  local weekDayStr
  if WeekQuestResetDay == 1 then
    weekDayStr = StringTable.Get("str_quest_base_week_Monday")
  elseif WeekQuestResetDay == 2 then
    weekDayStr = StringTable.Get("str_quest_base_week_Tuesday")
  elseif WeekQuestResetDay == 3 then
    weekDayStr = StringTable.Get("str_quest_base_week_Wednesday")
  elseif WeekQuestResetDay == 4 then
    weekDayStr = StringTable.Get("str_quest_base_week_Thursday")
  elseif WeekQuestResetDay == 5 then
    weekDayStr = StringTable.Get("str_quest_base_week_Friday")
  elseif WeekQuestResetDay == 6 then
    weekDayStr = StringTable.Get("str_quest_base_week_Saturday")
  elseif WeekQuestResetDay == 7 then
    weekDayStr = StringTable.Get("str_quest_base_week_Sunday")
  end
  local hourStr = StringTable.Get("str_quest_base_week_hour")
  local tips = StringTable.Get("str_quest_base_week_awards_tips", self._maxValue, weekDayStr, hourStr)
  self._tipsTex:SetText(tips)
end

function UIQuestDailyWeekAwards:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
  end
end

function UIQuestDailyWeekAwards:InitTimer()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
  end
  self._event = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetTimerTex()
  end)
  self:SetTimerTex()
end

function UIQuestDailyWeekAwards:SetTimerTex()
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  local sec = math.floor(self._endTime - nowTime)
  if sec < 0 then
    sec = 0
  end
  local tex = HelperProxy:GetInstance():Time2Tex(sec)
  self._timerTex:SetText(StringTable.Get("str_quest_base_week_awards_timer", tex))
end

function UIQuestDailyWeekAwards:OnItemClick(id, pos)
  if self._selectInfo then
    self._selectInfo:SetData(id, pos)
  end
end

function UIQuestDailyWeekAwards:BgOnClick(go)
  self:CloseDialog()
end
