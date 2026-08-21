_class("UIActivityN27HardLevel", Object)
UIActivityN27HardLevel = UIActivityN27HardLevel

function UIActivityN27HardLevel:Constructor(main)
  self._main = main
  self._missionModule = GameGlobal.GetModule(MissionModule)
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self._go = self._main:GetGameObject("Hard")
  self._time = self._main:GetUIComponent("UILocalizationText", "HardTime")
  self._timerHolder = UITimerHolder:New()
  self._nodesPool = self._main:GetUIComponent("UISelectObjectPath", "HardNodes")
end

function UIActivityN27HardLevel:Destroy()
  self._timerHolder:Dispose()
end

function UIActivityN27HardLevel:SetData(campaign, component, componentInfo)
  self._campaign = campaign
  self._levelHardComponent = component
  self._levelHardCompInfo = componentInfo
  self:RefreshCountdown()
  self:FlushNodes()
end

function UIActivityN27HardLevel:SetActive(status, playAnim)
  self._go:SetActive(status)
  if status and playAnim then
    self:FlushNodes()
  end
end

function UIActivityN27HardLevel:RefreshCountdown()
  local closeTime = self._levelHardCompInfo.m_close_time
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

function UIActivityN27HardLevel:GetFormatTimerStr(time, id)
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

function UIActivityN27HardLevel:FlushNodes()
  self._main:StartTask(self.CreateItems, self)
end

function UIActivityN27HardLevel:CreateItems(TT)
  self._main:Lock("UIActivityN27HardLevel_CreateItems")
  local cmpID = self._levelHardComponent:GetComponentCfgId()
  local missionCfgs = Cfg.cfg_component_line_mission({ComponentID = cmpID})
  local count = table.count(missionCfgs)
  self._nodesPool:SpawnObjects("UIActivityN27NHardLevelNode", count)
  local nodes = self._nodesPool:GetAllSpawnList()
  for i = 1, #nodes do
    nodes[i]:SetVisible(false)
  end
  local index = 1
  for _, cfg in ipairs(missionCfgs) do
    local uiNode = nodes[index]
    index = index + 1
    local isOpen = false
    local hasPass = self._levelHardCompInfo.m_pass_mission_info[cfg.CampaignMissionId] ~= nil
    if cfg.NeedMissionId and cfg.NeedMissionId ~= 0 then
      if self._levelHardCompInfo.m_pass_mission_info[cfg.NeedMissionId] ~= nil then
        isOpen = true
      end
    else
      isOpen = true
    end
    uiNode:SetData(cfg, isOpen, hasPass, function(stageId, isStory, worldPos)
      self:OnNodeClick(stageId, isStory, worldPos)
    end)
    YIELD(TT)
    YIELD(TT)
    YIELD(TT)
    YIELD(TT)
  end
  self._main:UnLock("UIActivityN27HardLevel_CreateItems")
end

function UIActivityN27HardLevel:OnNodeClick(stageId, isStory, worldPos)
  if isStory then
    local missionCfg = Cfg.cfg_campaign_mission[stageId]
    local titleId = StringTable.Get(missionCfg.Title)
    local titleName = StringTable.Get(missionCfg.Name)
    local storyId = self._missionModule:GetStoryByStageIdStoryType(stageId, StoryTriggerType.Node)
    if not storyId then
      Log.exception("配置错误,找不到剧情,关卡id:", stageId)
      return
    end
    self._main:ShowDialog("UIActivityPlotEnter", titleId, titleName, storyId, function()
      self:PlotEndCallback(stageId)
    end)
    return
  end
  self:EnterStage(stageId, worldPos)
end

function UIActivityN27HardLevel:EnterStage(stageId, worldPos)
  local autoFightShow = false
  self._main:ShowDialog("UIActivityLevelStageNew", stageId, self._levelHardCompInfo.m_pass_mission_info[stageId], self._levelHardComponent, autoFightShow, nil)
end

function UIActivityN27HardLevel:PlotEndCallback(stageId)
  local isActive = self._levelHardComponent:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  self._main:StartTask(function(TT)
    self._levelHardComponent:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = self._levelHardComponent:HandleCompleteStoryMission(TT, res, stageId)
    if not res:GetSucc() then
      self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    elseif table.count(award) ~= 0 then
      self._main:ShowDialog("UIGetItemController", award, function()
        self:FlushNodes()
      end)
    else
      self:FlushNodes()
    end
  end, self)
end
