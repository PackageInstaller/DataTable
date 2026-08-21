require("main_lobby_center_camp_data")
_class("PerfectPuzzleEnter", MainLobbyCenterCampData)
PerfectPuzzleEnter = PerfectPuzzleEnter

function PerfectPuzzleEnter:LoadData(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE, ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE)
  local localProcess = self._campaign:GetLocalProcess()
  self._component = localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE)
  self._componentInfo = localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE)
  self.personProcess = localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
  self.personProcessInfo = localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
  self._questComponent = localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
  self.questcmptInfo = localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
  self._lineDatas = {}
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function PerfectPuzzleEnter:CheckNew()
  return UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign) and 1 or 0
end

function PerfectPuzzleEnter:CheckRed()
  self._lineDatas = {}
  local questList = self._questComponent:GetQuestInfo()
  local questRed = false
  if self._questComponent:HasQuestCanClaim(questList) then
    return 1
  end
  local planRed = self.personProcess:HasCanGetReward()
  if planRed then
    return 1
  end
  local cfgs = Cfg.cfg_component_perfect_puzzle({
    ComponentID = self._component:GetComponentCfgId()
  })
  if cfgs then
    for _, cfg in pairs(cfgs) do
      table.insert(self._lineDatas, cfg)
    end
  end
  table.sort(self._lineDatas, function(a, b)
    return a.MissionID < b.MissionID
  end)
  if self._componentInfo.m_pass_mission_info ~= nil and table.count(self._componentInfo.m_pass_mission_info) < 5 then
    local count = table.count(self._componentInfo.m_pass_mission_info) + 1
    local curMissionCfg = self._lineDatas[count]
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(curMissionCfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local endTime = time
    if curTime < endTime then
      return 0
    else
      local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
      local timeStr = "PerfectPuzzle_RedCheck" .. day .. curMissionCfg.MissionID
      if UIActivityHelper.HasLocalDB(timeStr) then
        return 0
      end
    end
    return 1
  end
  return 0
end

function PerfectPuzzleEnter:IsUnlock(cfg)
  local preMissionUnlock = false
  local timeUnlock = false
  if cfg then
    preMissionUnlock = cfg.NeedMissionId <= 0 or self._componentInfo.m_pass_mission_info[cfg.NeedMissionId] ~= nil
    timeUnlock = self:_IsUnlock(cfg.UnlockTime)
  end
  return preMissionUnlock and timeUnlock
end

function PerfectPuzzleEnter:_IsUnlock(UnlockTime)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local unlockTime = loginModule:GetTimeStampByTimeStr(UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local curTime = svrTimeModule:GetServerTime() * 0.001
  return unlockTime <= curTime
end
