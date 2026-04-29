_class("UIActivityN27DiffLevel", Object)
UIActivityN27DiffLevel = UIActivityN27DiffLevel

function UIActivityN27DiffLevel:Constructor(main)
  self._main = main
  self._missionModule = GameGlobal.GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self._go = self._main:GetGameObject("Diff")
  self._time = self._main:GetUIComponent("UILocalizationText", "DiffTime")
  self._timerHolder = UITimerHolder:New()
  self._nodesPool = self._main:GetUIComponent("UISelectObjectPath", "DiffNodes")
  self._campaign = nil
  self._blackHardComponent = nil
  self._blackHardCompInfo = nil
  self._levelDatas = {}
end

function UIActivityN27DiffLevel:Destroy()
  self._timerHolder:Dispose()
end

function UIActivityN27DiffLevel:SetData(campaign, component, componentInfo)
  self._campaign = campaign
  self._blackHardComponent = component
  self._blackHardCompInfo = componentInfo
  self:InitLevelData()
  self:RefreshCountdown()
  self:FlushNodes()
end

function UIActivityN27DiffLevel:Refresh(campaign, component, componentInfo)
  self._campaign = campaign
  self._blackHardComponent = component
  self._blackHardCompInfo = componentInfo
  self:RefreshLevelData()
  self:RefreshCountdown()
  self:FlushNodes()
end

function UIActivityN27DiffLevel:InitLevelData()
  local cfgs = Cfg.cfg_difficulty_parent_mission({
    ComponentID = self._blackHardComponent:GetComponentCfgId()
  })
  if cfgs ~= nil then
    for k, cfg in pairs(cfgs) do
      local data = UIActivityN27DiffLevelData:New()
      data:InitParentLevel(self._blackHardComponent, self._blackHardCompInfo, cfg)
      self._levelDatas[#self._levelDatas + 1] = data
    end
  end
end

function UIActivityN27DiffLevel:RefreshLevelData()
  for i = 1, #self._levelDatas do
    self._levelDatas[i]:RefreshParentLevel(self._blackHardComponent, self._blackHardCompInfo)
  end
end

function UIActivityN27DiffLevel:SetActive(status, playAnim)
  self._go:SetActive(status)
  if status and playAnim then
    self:FlushNodes()
  end
end

function UIActivityN27DiffLevel:RefreshCountdown()
  local closeTime = self._blackHardCompInfo.m_close_time
  self._isValid = true
  local timerName = "CountDown"
  
  local function countDown()
    local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(closeTime - now)
    local timeStr = self:GetFormatTimerStr(time)
    if self._timeString ~= timeStr then
      self._time:SetText(timeStr)
      self._timeString = timeStr
    end
    if time < 0 then
      self._isValid = false
      self._timerHolder:StopTimer(timerName)
    end
  end
  
  countDown()
  self._timerHolder:StartTimerInfinite(timerName, 1000, countDown)
end

function UIActivityN27DiffLevel:GetFormatTimerStr(time, id)
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
  return StringTable.Get("str_n27_level_remain_time_tips", timeStr)
end

function UIActivityN27DiffLevel:BtnInfoOnClick()
  self._main:ShowDialog("UIIntroLoader", "UIN27DiffLevelIntro")
end

function UIActivityN27DiffLevel:FlushNodes()
  self._main:StartTask(self.CreateItems, self)
end

function UIActivityN27DiffLevel:CreateItems(TT)
  self._main:Lock("UIActivityN27DiffLevel_CreateItems")
  self._nodesPool:SpawnObjects("UIActivityN27DiffLevelNode", #self._levelDatas)
  local nodes = self._nodesPool:GetAllSpawnList()
  for i = 1, #nodes do
    nodes[i]:SetData(self._levelDatas[i], function(data)
      self:OnNodeClick(data)
    end)
  end
  self._main:UnLock("UIActivityN27DiffLevel_CreateItems")
end

function UIActivityN27DiffLevel:OnNodeClick(data)
  self._main:ShowDialog("UIActivityN27DiffLevelDetail", data, self._blackHardComponent)
end

function UIActivityN27DiffLevel:ClickNodeByID(id)
  for _, data in ipairs(self._levelDatas) do
    if data:GetMissionId() == id then
      self:OnNodeClick(data)
      return true
    end
  end
  Log.error("[N27DiffLevel]找不到目标id:", id)
  return false
end
