_class("UIActivityDiffLevel", Object)
UIActivityDiffLevel = UIActivityDiffLevel

function UIActivityDiffLevel:Constructor(controller)
  self._controller = controller
  self._missionModule = GameGlobal.GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self._go = self._controller:GetGameObject("Diff")
  self._time = self._controller:GetUIComponent("UILocalizationText", "DiffTime")
  self._timerHolder = UITimerHolder:New()
  self._nodesPool = self._controller:GetUIComponent("UISelectObjectPath", "DiffNodes")
  self._campaign = nil
  self._blackHardComponent = nil
  self._blackHardCompInfo = nil
  self._levelDatas = {}
  self:OnInit()
end

function UIActivityDiffLevel:Destroy()
  self._timerHolder:Dispose()
end

function UIActivityDiffLevel:SetData(campaign, component, componentInfo)
  self._campaign = campaign
  self._blackHardComponent = component
  self._blackHardCompInfo = componentInfo
  self:InitLevelData()
  self:RefreshCountdown()
  self:FlushNodes()
end

function UIActivityDiffLevel:Refresh(campaign, component, componentInfo)
  self._campaign = campaign
  self._blackHardComponent = component
  self._blackHardCompInfo = componentInfo
  self:RefreshLevelData()
  self:RefreshCountdown()
  self:FlushNodes()
end

function UIActivityDiffLevel:InitLevelData()
  local cfgs = Cfg.cfg_difficulty_parent_mission({
    ComponentID = self._blackHardComponent:GetComponentCfgId()
  })
  if cfgs ~= nil then
    for k, cfg in pairs(cfgs) do
      local data = UIActivityDiffLevelData:New()
      data:InitParentLevel(self._blackHardComponent, self._blackHardCompInfo, cfg)
      self._levelDatas[#self._levelDatas + 1] = data
    end
  end
end

function UIActivityDiffLevel:RefreshLevelData()
  for i = 1, #self._levelDatas do
    self._levelDatas[i]:RefreshParentLevel(self._blackHardComponent, self._blackHardCompInfo)
  end
end

function UIActivityDiffLevel:SetActive(status, playAnim)
  self._go:SetActive(status)
  if status and playAnim then
    self:FlushNodes()
  end
end

function UIActivityDiffLevel:RefreshCountdown()
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

function UIActivityDiffLevel:GetFormatTimerStr(time, id)
  local default_id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  id = id or default_id
  local timeStr = ""
  if time < 0 then
    timeStr = StringTable.Get(id.over)
    return timeStr
  end
  local day = math.floor(time / 3600 / 24)
  if 0 < day then
    time = time - day * 3600 * 24
    local hour = math.floor(time / 3600)
    timeStr = day .. StringTable.Get(id.day)
    if 0 < hour then
      timeStr = timeStr .. hour .. StringTable.Get(id.hour)
    end
  elseif 60 <= time then
    local hour = math.floor(time / 3600)
    time = time - hour * 3600
    if 0 < hour then
      timeStr = hour .. StringTable.Get(id.hour)
    end
    local minus = math.floor(time / 60)
    if 0 < minus then
      timeStr = timeStr .. minus .. StringTable.Get(id.min)
    end
  else
    timeStr = StringTable.Get(id.zero)
  end
  return StringTable.Get(self:GetTimeDownString(), timeStr)
end

function UIActivityDiffLevel:BtnInfoOnClick()
  self._controller:ShowDialog("UIIntroLoader", self:GetIntroName())
end

function UIActivityDiffLevel:FlushNodes()
  self._controller:StartTask(self.CreateItems, self)
end

function UIActivityDiffLevel:CreateItems(TT)
  self._controller:Lock("UIActivityN27DiffLevel_CreateItems")
  local nodeName = self:GetLevelNodeName()
  self._nodesPool:SpawnObjects(nodeName, #self._levelDatas)
  local nodes = self._nodesPool:GetAllSpawnList()
  for i = 1, #nodes do
    nodes[i]:SetData(self._levelDatas[i], function(data)
      self:OnNodeClick(data)
    end)
  end
  self:NodePlayAnimationInterval(TT)
  self._controller:UnLock("UIActivityN27DiffLevel_CreateItems")
end

function UIActivityDiffLevel:OnNodeClick(data)
  self._controller:ShowDialog("UIActivityDiffLevelDetail", data, self._blackHardComponent)
end

function UIActivityDiffLevel:ClickNodeByID(id)
  for _, data in ipairs(self._levelDatas) do
    if data:GetMissionId() == id then
      self:OnNodeClick(data)
      return true
    end
  end
  Log.error("[N27DiffLevel]找不到目标id:", id)
  return false
end

function UIActivityDiffLevel:OnInit()
end

function UIActivityDiffLevel:GetTimeDownString()
  return ""
end

function UIActivityDiffLevel:NodePlayAnimationInterval(TT)
end

function UIActivityDiffLevel:GetIntroName()
  return ""
end

function UIActivityDiffLevel:GetLevelNodeName()
  return "UIActivityN29DiffLevelNode"
end
