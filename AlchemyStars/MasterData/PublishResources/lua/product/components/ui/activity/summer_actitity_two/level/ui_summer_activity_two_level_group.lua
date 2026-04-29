_class("UISummerActivityTwoLevelGroup", UICustomWidget)
UISummerActivityTwoLevelGroup = UISummerActivityTwoLevelGroup

function UISummerActivityTwoLevelGroup:OnShow()
  self._spawnObj = self:GetUIComponent("UISelectObjectPath", "spawnobj")
  self._timerLabel = self:GetUIComponent("UILocalizationText", "Timer")
  self._timerGo = self:GetGameObject("Timer")
  self._unLock = self:GetGameObject("UnLock")
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._timerHandler = nil
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UISummerActivityTwoLevelGroup:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UISummerActivityTwoLevelGroup:Refresh(levelGroupData, index)
  self:PlayAnim(index)
  self._spawnObj:SpawnObjects("UISummerActivityTwoLevelItem", #levelGroupData)
  self._levelIems = self._spawnObj:GetAllSpawnList()
  for i = 1, #levelGroupData do
    self._levelIems[i]:Refresh(levelGroupData[i])
  end
  if #levelGroupData <= 0 then
    self._unLock:SetActive(false)
    return
  end
  self._levelGroupData = levelGroupData
  self._levelData = levelGroupData[1]
  if self._levelData:GetStatus() == UISummerActivityTwoLevelStatus.UnOpen then
    self._unLock:SetActive(true)
    if self._levelData:IsPreLevelCondition() then
      self._timerGo:SetActive(false)
    else
      self._timerGo:SetActive(true)
      self._timerLabel.text = StringTable.Get("str_summer_activity_two_normal_level_unopen_tips", self:RefreshRemainTime())
      self._timerHandler = GameGlobal.Timer():AddEventTimes(10, TimerTriggerCount.Infinite, function()
        self._timerLabel.text = StringTable.Get("str_summer_activity_two_normal_level_unopen_tips", self:RefreshRemainTime())
      end)
    end
  else
    self._unLock:SetActive(false)
  end
end

function UISummerActivityTwoLevelGroup:PlayAnim(index)
  GameGlobal.TaskManager():StartTask(self.PlayAnimCoro, self, index)
end

function UISummerActivityTwoLevelGroup:PlayAnimCoro(TT, index)
  self:Lock("UISummerActivityTwoLevelGroup_PlayAnimCoro")
  YIELD(TT, index * 40)
  self._anim:Play("uieff_Summer2_LevelGroup_In")
  self:UnLock("UISummerActivityTwoLevelGroup_PlayAnimCoro")
end

function UISummerActivityTwoLevelGroup:RefreshRemainTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(self._levelData:GetTimes() - nowTime)
  if seconds < 0 then
    seconds = 0
    self._unLock:SetActive(false)
    self._levelData:CalStatus()
    self._levelIems[1]:Refresh(self._levelData)
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
    return
  end
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_summer_activity_two_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_summer_activity_two_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_summer_activity_two_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_summer_activity_two_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_summer_activity_two_less_minus")
  end
  return timeStr
end
