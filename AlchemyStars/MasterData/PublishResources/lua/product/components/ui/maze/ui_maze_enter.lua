_class("UIMazeEnter", UIController)
UIMazeEnter = UIMazeEnter

function UIMazeEnter:OnShow(uiParams)
  local module = self:GetModule(MissionModule)
  local data = module:GetDiscoveryData()
  self:UnLock("UIMazeEnterShowDialog")
  self._txtTime = self:GetUIComponent("UILocalizationText", "txtTime")
  self._btn = self:GetUIComponent("UISelectObjectPath", "btn")
  self._backBtns = self._btn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil)
  self:CountDown()
  self._countTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:CountDown()
  end)
  self._btnEnterGo = self:GetGameObject("btnEnter")
end

function UIMazeEnter:OnHide()
  if self._countTimer then
    GameGlobal.Timer():CancelEvent(self._countTimer)
    self._countTimer = nil
  end
end

function UIMazeEnter:btnEnterOnClick(go)
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Maze_Enter, "mj_01")
end

function UIMazeEnter:CountDown()
  self._mazeModule = GameGlobal.GetModule(MazeModule)
  local time = math.floor(self._mazeModule:GetSecToFinish())
  self._txtTime:SetText(StringTable.Get("str_discovery_maze_end_time", self:Time2Str(time)))
  if time <= 0 then
    GameGlobal.TaskManager():StartTask(self.RequestUpdateMazeInfo, self)
  end
end

function UIMazeEnter:RequestUpdateMazeInfo(TT)
  local res = self._mazeModule:RequestMazeVersion(TT)
  if res:GetSucc() then
  else
    Log.fatal("[Maze] update maze info error:", res:GetResult())
  end
end

function UIMazeEnter:Time2Str(time)
  local returnStr = ""
  if 86400 < time then
    local day = math.floor(time / 60 / 60 / 24)
    day = day .. StringTable.Get("str_maze_open_time_day_str")
    local hour = math.floor(time / 60 / 60) % 24
    if hour < 10 then
      hour = "0" .. hour .. StringTable.Get("str_maze_open_time_hour_str")
    else
      hour = hour .. StringTable.Get("str_maze_open_time_hour_str")
    end
    returnStr = day .. hour
  else
    returnStr = HelperProxy:GetInstance():FormatTime(time)
  end
  return returnStr
end
