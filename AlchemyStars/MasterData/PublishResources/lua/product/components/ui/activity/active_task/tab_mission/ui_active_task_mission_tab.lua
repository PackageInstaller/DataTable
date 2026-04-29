_class("UIActiveTaskMissionTab", UICustomWidget)
UIActiveTaskMissionTab = UIActiveTaskMissionTab

function UIActiveTaskMissionTab:OnShow()
  self._timerName = "CountDown"
  self:AddListener()
  self:_GetComponent()
end

function UIActiveTaskMissionTab:OnHide()
  self:RemoveListener()
  self._timerHolder:Dispose()
end

function UIActiveTaskMissionTab:AddListener()
  self._refreshActiveTaskRedCallback = GameHelper:GetInstance():CreateCallback(self.Refresh, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.RefreshActiveTaskRed, self._refreshActiveTaskRedCallback)
  self._itemChangeCallback = GameHelper:GetInstance():CreateCallback(self.OnItemCountChanged, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ItemCountChanged, self._itemChangeCallback)
end

function UIActiveTaskMissionTab:RemoveListener()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.RefreshActiveTaskRed, self._refreshActiveTaskRedCallback)
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.ItemCountChanged, self._itemChangeCallback)
end

function UIActiveTaskMissionTab:_GetComponent()
  self._diffTime = self:GetUIComponent("UILocalizationText", "DiffTime")
  self._dailyMissionContent = self:GetUIComponent("UISelectObjectPath", "dailyMissionContent")
  self._accumMissionContent = self:GetUIComponent("UISelectObjectPath", "accumMissionContent")
  self._selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._gameObj = self:GetGameObject("anim")
  self._timerHolder = UITimerHolder:New()
  self._moneyIcon = self:GetUIComponent("RawImageLoader", "moneyIcon")
  self._moneyNum = self:GetUIComponent("UILocalizationText", "moneyNum")
  self._moneyIconObj = self:GetGameObject("moneyIcon")
end

function UIActiveTaskMissionTab:SetData(data)
  self._data = data
  self._turnCardCfg = self._data:GetTurnCardCfg()
  self:InitComponent()
  self:RefreshCountdown()
end

function UIActiveTaskMissionTab:Refresh()
  self:RefreshExchangeNum()
  self:RefreshMission()
  self:RefreshCountdown()
end

function UIActiveTaskMissionTab:OnItemCountChanged()
  self:RefreshExchangeNum()
end

function UIActiveTaskMissionTab:RefreshExchangeNum()
  self._CostItem = self._turnCardCfg.CostItem[1]
  local moneyId = self._CostItem[1]
  local moneyCfg = Cfg.cfg_item[moneyId]
  local itemModule = GameGlobal.GetModule(ItemModule)
  local num = itemModule:GetItemCount(moneyId)
  self._moneyIcon:LoadImage(moneyCfg.Icon)
  self._moneyNum:SetText(num)
end

function UIActiveTaskMissionTab:Close(isAnim)
  if self._selectInfo then
    self._selectInfo:closeOnClick()
  end
  self._timerHolder:StopTimer(self._timerName)
  if isAnim then
    self:StartTask(function(TT)
      self:Lock("UIActiveTaskMissionTab_Close")
      self._anim:Play("uieff_UIActiveTaskMissionTab_out")
      YIELD(TT, 333)
      self._gameObj:SetActive(false)
      for _, v in pairs(self._dailyTask) do
        v:Close()
      end
      for _, v in pairs(self._accumTask) do
        v:Close()
      end
      self:UnLock("UIActiveTaskMissionTab_Close")
    end, self)
  else
    self._gameObj:SetActive(false)
  end
end

function UIActiveTaskMissionTab:Open()
  self._gameObj:SetActive(true)
  self:Refresh()
  for i, v in pairs(self._dailyTask) do
    v:Open(i)
  end
  for i, v in pairs(self._accumTask) do
    v:Open(i)
  end
end

function UIActiveTaskMissionTab:RefreshMission()
  self:StartTask(function(TT)
    self:Lock("UIActiveTaskMissionTab RefreshMission")
    self._anim:Play("uieff_UIActiveTaskMissionTab_in")
    local dailyTask = self._data:GetDailyTask()
    local accumTask = self._data:GetAccumTask()
    for i, v in pairs(self._dailyTask) do
      local task = dailyTask[i]
      v:SetData(task, self._data, function(id, pos)
        self:OnItemSelect(id, pos)
      end)
    end
    for i, v in pairs(self._accumTask) do
      local task = accumTask[i]
      v:SetData(task, self._data, function(id, pos)
        self:OnItemSelect(id, pos)
      end)
    end
    YIELD(TT, 400)
    self:UnLock("UIActiveTaskMissionTab RefreshMission")
  end)
end

function UIActiveTaskMissionTab:InitComponent()
  local dailyTask = self._data:GetDailyTask()
  local accumTask = self._data:GetAccumTask()
  self._dailyTask = self._dailyMissionContent:SpawnObjects("UIActiveTaskMissionItem", #dailyTask)
  self._accumTask = self._accumMissionContent:SpawnObjects("UIActiveTaskMissionItem", #accumTask)
  for i, v in pairs(self._dailyTask) do
    local task = dailyTask[i]
    v:SetData(task, self._data, function(id, pos)
      self:OnItemSelect(id, pos)
    end)
  end
  for i, v in pairs(self._accumTask) do
    local task = accumTask[i]
    v:SetData(task, self._data, function(id, pos)
      self:OnItemSelect(id, pos)
    end)
  end
end

function UIActiveTaskMissionTab:RefreshCountdown()
  local closeTime = self._data:GetDailyTaskEndTime()
  
  local function countDown()
    local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(closeTime - now)
    local timeStr = self:GetFormatTimerStr(time)
    if self._timeString ~= timeStr then
      self._diffTime:SetText(timeStr)
      self._timeString = timeStr
    end
    if time < 0 then
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        local comp = self._data:GetMissionComp()
        comp:HandleCamQuestDailyReset(TT, res)
        if res:GetSucc() then
          ToastManager.ShowToast(StringTable.Get("str_n32_turn_card_daily_mission_refresh"))
          GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshActiveTaskRed)
          self:Refresh()
        else
          Log.fatal("请求更新每日任务失败")
        end
      end, self)
      self._timerHolder:StopTimer(self._timerName)
    end
  end
  
  countDown()
  self._timerHolder:StartTimerInfinite(self._timerName, 1000, countDown)
end

function UIActiveTaskMissionTab:GetFormatTimerStr(time, id)
  local default_id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  id = id or default_id
  local timeStr = StringTable.Get(id.over)
  if time < 0 then
    return timeStr
  end
  local day, hour, min, second = UIActivityHelper.Time2Str(time)
  if 0 < day then
    timeStr = day .. StringTable.Get(id.day) .. hour .. StringTable.Get(id.hour)
  elseif 0 < hour then
    timeStr = hour .. StringTable.Get(id.hour) .. min .. StringTable.Get(id.min)
  elseif 0 < min then
    timeStr = min .. StringTable.Get(id.min)
  else
    timeStr = StringTable.Get(id.zero)
  end
  return StringTable.Get(self:GetTimeDownString(), timeStr)
end

function UIActiveTaskMissionTab:GetTimeDownString()
  return "str_n32_turn_card_refresh_time"
end

function UIActiveTaskMissionTab:OnItemSelect(id, pos)
  if not self._selectInfo then
    self._selectInfo = self._selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._selectInfo:SetData(id, pos)
end

function UIActiveTaskMissionTab:AwardBtnOnClick()
  local isOver = self._data:CheckFlipIsOver()
  if isOver then
    return
  end
  self._itemList, self._maskList = self._data:GetTurnCardInfo()
  self:ShowDialog("UIActiveTaskAwardShowController", self._itemList)
end

function UIActiveTaskMissionTab:MoneyIconBtnOnClick()
  local moneyId = self._CostItem[1]
  self:OnItemSelect(moneyId, self._moneyIconObj.transform.position)
end
