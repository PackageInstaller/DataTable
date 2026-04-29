_class("SeasonOnceMissionData", UIController)
SeasonOnceMissionData = SeasonOnceMissionData
SeasonOnceMissionData.ComState_NotOpen = 1
SeasonOnceMissionData.ComState_OpenButLock = 2
SeasonOnceMissionData.ComState_Normal = 3
SeasonOnceMissionData.ComState_Closed = 4

function SeasonOnceMissionData:Constructor()
  self._missionCpts = {}
end

function SeasonOnceMissionData:GetMissionComponents()
  return self._missionCpts
end

function SeasonOnceMissionData:AnyComponentOpening()
  if not self._missionCpts then
    return false
  end
  for _, lineMissionComponent in pairs(self._missionCpts) do
    local state = self:GetCompState(lineMissionComponent)
    if state == SeasonOnceMissionData.ComState_Normal then
      return true
    end
  end
  return false
end

function SeasonOnceMissionData:IsComponentOpening(lineMissionComponent)
  return self:GetCompState(lineMissionComponent) == SeasonOnceMissionData.ComState_Normal
end

function SeasonOnceMissionData:GetCompState(cmpt)
  local cInfo = cmpt:GetComponentInfo()
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return SeasonOnceMissionData.ComState_NotOpen
  elseif nowTimestamp > cInfo.m_close_time then
    return SeasonOnceMissionData.ComState_Closed
  elseif cInfo.m_b_unlock then
    return SeasonOnceMissionData.ComState_Normal
  elseif cInfo.m_need_mission_id > 0 then
    return SeasonOnceMissionData.ComState_OpenButLock
  else
    return SeasonOnceMissionData.ComState_Normal
  end
end

function SeasonOnceMissionData:HasEntryNew()
  if not self._missionCpts then
    return false
  end
  for _, lineMissionComponent in pairs(self._missionCpts) do
    local info = lineMissionComponent:GetComponentInfo()
    if self:IsComponentOpening(lineMissionComponent) then
      local compId = info.m_campaign_id .. info.m_component_id
      if not self:_HasReadNew(compId) then
        return true
      end
    end
  end
  return false
end

function SeasonOnceMissionData:HasNewByComp(comp)
  if self:IsComponentOpening(comp) then
    local info = comp:GetComponentInfo()
    local compId = info.m_campaign_id .. info.m_component_id
    if not self:_HasReadNew(compId) then
      return true
    end
  end
  return false
end

function SeasonOnceMissionData:SetNewAsReadBy(comp)
  local info = comp:GetComponentInfo()
  local compId = info.m_campaign_id .. info.m_component_id
  self:_SetReadNew(compId)
end

function SeasonOnceMissionData:_HasReadNew(componentId)
  local key = self:_GetEntryNewKey(componentId)
  local hasRead = UnityEngine.PlayerPrefs.HasKey(key)
  return hasRead
end

function SeasonOnceMissionData:_SetReadNew(componentId)
  local key = self:_GetEntryNewKey(componentId)
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function SeasonOnceMissionData:_GetEntryNewKey(componentId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = "season_once_entry_" .. pstId .. componentId
  return key
end

function SeasonOnceMissionData:ForceLoadData(TT)
  GameGlobal.GetModule(SeasonModule):ForceRequestCurSeasonData(TT)
end

function SeasonOnceMissionData:RefreshData()
  self._missionCpts = {}
  local obj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  if not obj then
    return
  end
  local cpts = {
    ECCampaignSeasonComponentID.LINE_MISSION_POPSTAR,
    ECCampaignSeasonComponentID.LINE_MISSION_BLACKFIST,
    ECCampaignSeasonComponentID.LINE_MISSION_TALEN
  }
  for _, cptID in pairs(cpts) do
    local cpt = obj:GetComponent(cptID)
    if cpt then
      local missions = Cfg.cfg_component_line_mission({
        ComponentID = cpt:GetComponentCfgId()
      })
      if missions and 0 < #missions then
        table.insert(self._missionCpts, cpt)
      end
    end
  end
  if #self._missionCpts == 0 then
    return
  end
  table.sort(self._missionCpts, function(a, b)
    local aTime = a:GetComponentInfo().m_unlock_time
    local bTime = b:GetComponentInfo().m_unlock_time
    if aTime ~= bTime then
      return aTime < bTime
    end
    return a:GetComponentCfgId() < b:GetComponentCfgId()
  end)
end
