require("main_lobby_center_camp_data")
_class("LuckLandEnter", MainLobbyCenterCampData)
LuckLandEnter = LuckLandEnter

function LuckLandEnter:LoadData(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_LUCKLAND, ECampaignN11CenterComponentID.ECAMPAIGN_N11_LUCK_LAND)
  local localProcess = self._campaign:GetLocalProcess()
  self._component = localProcess:GetComponent(ECampaignN11CenterComponentID.ECAMPAIGN_N11_LUCK_LAND)
  self._componentInfo = localProcess:GetComponentInfo(ECampaignN11CenterComponentID.ECAMPAIGN_N11_LUCK_LAND)
end

function LuckLandEnter:CheckNew()
  return UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign) and 1 or 0
end

function LuckLandEnter:CheckRed()
  if not self._component then
    return 0
  end
  self._lineDatas = {}
  local cfgs = Cfg.cfg_component_luck_land({
    ComponentID = self._component:GetComponentCfgId()
  })
  if cfgs then
    for _, cfg in pairs(cfgs) do
      if not self._lineDatas[cfg.Line] then
        self._lineDatas[cfg.Line] = {}
      end
      table.insert(self._lineDatas[cfg.Line], cfg)
    end
  end
  for _, lineDatas in pairs(self._lineDatas) do
    table.sort(lineDatas, function(a, b)
      return a.MissionID < b.MissionID
    end)
  end
  for i = 1, #self._lineDatas do
    local r1 = self:IsUnlock(self._lineDatas[i][1])
    local r2 = 0 >= LocalDB.GetInt("LuckLandLevel_Unlock_Line_" .. GameGlobal.GetModule(RoleModule):GetPstId() .. i, 0)
    if r1 and r2 then
      return 1
    end
  end
  return 0
end

function LuckLandEnter:IsUnlock(cfg)
  local preMissionUnlock = false
  local timeUnlock = false
  if cfg then
    preMissionUnlock = cfg.NeedMissionId <= 0 or self._componentInfo.m_pass_mission_info[cfg.NeedMissionId] ~= nil
    timeUnlock = self:_IsUnlock(cfg.UnlockTime)
  end
  return preMissionUnlock and timeUnlock
end

function LuckLandEnter:_IsUnlock(UnlockTime)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local unlockTime = loginModule:GetTimeStampByTimeStr(UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local curTime = svrTimeModule:GetServerTime() * 0.001
  return unlockTime <= curTime
end
