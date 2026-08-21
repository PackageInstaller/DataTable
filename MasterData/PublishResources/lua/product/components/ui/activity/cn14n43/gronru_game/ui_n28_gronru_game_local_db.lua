_class("UIN28GronruGameLocalDb", Object)
UIN28GronruGameLocalDb = UIN28GronruGameLocalDb

function UIN28GronruGameLocalDb:Constructor()
  local campaignModule = self:GetModule(CampaignModule)
  self._localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N28_MINI_GAME)
  self._missionComponent = self._localProcess:GetComponent(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  self._dbNew = self:PrivateNewLoadDB()
  self._dbPlot = self:PrivatePlotLoadDB()
end

function UIN28GronruGameLocalDb:GetModule(gameModuleProto)
  return GameGlobal.GetModule(gameModuleProto)
end

function UIN28GronruGameLocalDb:NewDBKey()
  local dbKey = "UIN28GronruGameLocalDb.dbNew"
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. dbKey
  return key
end

function UIN28GronruGameLocalDb:PlotDBKey()
  local dbKey = "UIN28GronruGameLocalDb.dbPlot"
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. dbKey
  return key
end

function UIN28GronruGameLocalDb:ClearDB()
  self._dbNew = {}
  self._dbPlot = 0
  local key = self:NewDBKey()
  LocalDB.SetString(key, "")
  local key = self:PlotDBKey()
  LocalDB.SetString(key, "")
end

function UIN28GronruGameLocalDb:PrivateNewSaveDB()
  local key = self:NewDBKey()
  local content = ""
  for k, v in pairs(self._dbNew) do
    content = content .. string.format("%d, ", v)
  end
  LocalDB.SetString(key, content)
end

function UIN28GronruGameLocalDb:PrivateNewLoadDB()
  local key = self:NewDBKey()
  local content = LocalDB.GetString(key, "")
  local fnString = string.format("return {%s}", content)
  local fnTable = load(fnString)
  local dbData = fnTable()
  local value = {}
  for k, v in pairs(dbData) do
    value[v] = v
  end
  return value
end

function UIN28GronruGameLocalDb:AllUnlockMission()
  local passMission = {}
  local componentInfo = self._missionComponent:GetComponentInfo()
  if componentInfo ~= nil and componentInfo.m_pass_mission_info ~= nil then
    passMission = componentInfo.m_pass_mission_info
  end
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local unlockMission = {}
  local allCfg = Cfg.cfg_component_bounce_mission({})
  for k, v in pairs(allCfg) do
    local chkMission = false
    if v.NeedMissionId == nil then
      chkMission = true
    elseif v.NeedMissionId == 0 then
      chkMission = true
    elseif passMission[v.NeedMissionId] ~= nil then
      chkMission = true
    end
    local chkTime = false
    local beginTime = loginModule:GetTimeStampByTimeStr(v.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    if curTime >= beginTime then
      chkTime = true
    end
    if chkMission and chkTime then
      unlockMission[v.CampaignMissionId] = v.CampaignMissionId
    end
  end
  return unlockMission
end

function UIN28GronruGameLocalDb:CheckNew()
  if self._dbNew == nil then
    return true
  end
  local showNew = false
  if self._dbNew[0] == nil then
    showNew = true
  else
    local unlockMission = self:AllUnlockMission()
    for k, v in pairs(unlockMission) do
      if self._dbNew[v] == nil then
        showNew = true
        break
      end
    end
  end
  return showNew
end

function UIN28GronruGameLocalDb:CheckReddot()
  return self._missionComponent:MissionCanRecvReward()
end

function UIN28GronruGameLocalDb:ViewedPlatform()
  self._dbNew[0] = 0
  self:PrivateNewSaveDB()
end

function UIN28GronruGameLocalDb:ViewedMission(idMission)
  local cfg = Cfg.cfg_component_bounce_mission[idMission]
  if cfg ~= nil then
    self._dbNew[cfg.CampaignMissionId] = cfg.CampaignMissionId
    self:PrivateNewSaveDB()
  end
end

function UIN28GronruGameLocalDb:PrivatePlotSaveDB()
  local key = self:PlotDBKey()
  if self._dbPlot then
    LocalDB.SetString(key, "1")
  else
    LocalDB.SetString(key, "0")
  end
end

function UIN28GronruGameLocalDb:PrivatePlotLoadDB()
  local key = self:PlotDBKey()
  local content = LocalDB.GetString(key, "")
  return tonumber(content) == 1
end

function UIN28GronruGameLocalDb:IsViewedPlot()
  return self._dbPlot
end

function UIN28GronruGameLocalDb:ViewedPlot()
  self._dbPlot = true
  self:PrivatePlotSaveDB()
end
