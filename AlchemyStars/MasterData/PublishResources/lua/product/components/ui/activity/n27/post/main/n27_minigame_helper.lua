_class("N27MinigameHelper", Object)
N27MinigameHelper = N27MinigameHelper

function N27MinigameHelper:Constructor()
end

function N27MinigameHelper:LoadData(TT, res)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N27, ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  if res and not res:GetSucc() then
    return
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._component = self._campaign:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  self._componentInfo = self._campaign:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_POSTSTATON)
  local cmpID = self._component:GetComponentCfgId()
  self._cfg_stage = Cfg.cfg_component_post_station_game_mission({ComponentID = cmpID})
  table.sort(self._cfg_stage, function(a, b)
    return a.ID < b.ID
  end)
  local cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._name = StringTable.Get(cfg_campaign.CampaignName)
  self._subName = StringTable.Get(cfg_campaign.CampaignSubtitle)
  local plotIdList = cfg_campaign.FirstEnterStoryID
  self._plotId = nil
  if plotIdList and 0 < #plotIdList then
    self._plotId = plotIdList[1]
  end
  local sample = self._campaign:GetSample()
  if not sample then
    return
  end
  local nowTime = self._svrTimeModule:GetServerTime() / 1000
  self._activeEndTime = sample.end_time
  if nowTime > self._activeEndTime then
    Log.error("Time error!")
    return
  end
end

function N27MinigameHelper:ForceReLoad(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
end

function N27MinigameHelper:GetCampaign()
  return self._campaign
end

function N27MinigameHelper:GetCampaignId()
  return self._campaign._id
end

function N27MinigameHelper:GetName()
  return self._name
end

function N27MinigameHelper:GetSubName()
  return self._subName
end

function N27MinigameHelper:GetActiveEndTime()
  return self._activeEndTime
end

function N27MinigameHelper:GetPlotId()
  return self._plotId
end

function N27MinigameHelper:IsActivityEnd()
  if not self._activeEndTime then
    return true
  end
  local nowTime = self._svrTimeModule:GetServerTime() / 1000
  local seconds = math.floor(self._activeEndTime - nowTime)
  if seconds <= 0 then
    return true
  end
  return false
end

function N27MinigameHelper:GetMiniGameComponent()
  return self._component
end

function N27MinigameHelper:GetMiniGameComponentInfo()
  return self._componentInfo
end

function N27MinigameHelper:GetMiniGameComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return self:CheckComponentStatus(self._component)
end

function N27MinigameHelper:CheckComponentStatus(component)
  if not component then
    return ActivityComponentStatus.Close, 0
  end
  local info = component:GetComponentInfo()
  if not info then
    return ActivityComponentStatus.Close, 0
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if curTime >= info.m_close_time then
    return ActivityComponentStatus.Close, 0
  end
  local opentTime = info.m_open_time
  local unLockTime = info.m_unlock_time
  local time = opentTime
  if unLockTime > time then
    time = unLockTime
  end
  if curTime > time then
    if not info.m_b_unlock then
      return ActivityComponentStatus.MissionLock, 0
    end
    return ActivityComponentStatus.Open, info.m_close_time - curTime
  end
  return ActivityComponentStatus.TimeLock, curTime - time
end

function N27MinigameHelper:GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. id
  return key
end

function N27MinigameHelper:IsShowEntryNewOrRed()
  local isNew, isRed = false, false
  if self:IsActivityEnd() then
    return false
  end
  if self:IsShowMiniGameRed() then
    isRed = true
  end
  if self:IsShowMiniGameNew() then
    isRed = false
    isNew = true
  end
  return isNew, isRed
end

function N27MinigameHelper:IsShowMiniGameRed()
  if not self._componentInfo.mission_infos then
    return false
  end
  for key, value in pairs(self._componentInfo.mission_infos) do
    if #value.can_get_target_list > 0 then
      return true
    end
  end
  return false
end

function N27MinigameHelper:IsShowMiniGameNew()
  for index, value in pairs(self._cfg_stage) do
    local nowTime = self._svrTimeModule:GetServerTime() * 0.001
    local cfg = value
    local unlockTime = self._loginModule:GetTimeStampByTimeStr(cfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    if nowTime >= unlockTime then
      local key = self:GetNewFlagKey(index)
      local hasNew = LocalDB.GetInt("UIN42MiniGameWayPoint" .. key)
      if hasNew == 0 and self:CheckPreMission(index) and not self:CheckMissionPass(index) then
        return true
      end
    end
  end
  return false
end

function N27MinigameHelper:CheckPreMission(index)
  if index == 1 then
    return true
  end
  return self._componentInfo.mission_infos[self._cfg_stage[index - 1].ID] and self._componentInfo.mission_infos[self._cfg_stage[index - 1].ID].suc > 0
end

function N27MinigameHelper:CheckMissionPass(index)
  return self._componentInfo.mission_infos[self._cfg_stage[index].ID] and self._componentInfo.mission_infos[self._cfg_stage[index].ID].suc > 0
end
