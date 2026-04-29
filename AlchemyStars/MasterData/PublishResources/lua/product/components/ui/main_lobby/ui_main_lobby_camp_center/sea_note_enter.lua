require("main_lobby_center_camp_data")
_class("SeaNoteEnter", MainLobbyCenterCampData)
SeaNoteEnter = SeaNoteEnter

function SeaNoteEnter:LoadData(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_N9_ASHEEP, ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  local localProcess = self._campaign:GetLocalProcess()
  self._component = localProcess:GetComponent(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  self._componentInfo = localProcess:GetComponentInfo(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  self._lineDatas = {}
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function SeaNoteEnter:CheckNew()
  return UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign) and 1 or 0
end

function SeaNoteEnter:CheckRed()
  self._lineDatas = {}
  local cfgs = Cfg.cfg_component_asheep_mission({
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
  local subkey = 3011
  local curPass = 0
  for key, value in pairs(self._componentInfo.m_info.m_pass_mission_info) do
    if key ~= subkey then
      curPass = curPass + 1
    end
  end
  if self._componentInfo.m_info.m_pass_mission_info ~= nil then
    if curPass < 10 then
      local count = curPass + 1
      local curMissionCfg = self._lineDatas[count]
      local curTime = self._svrTimeModule:GetServerTime() * 0.001
      if curMissionCfg.OpenTime ~= nil then
        local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(curMissionCfg.OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
        local endTime = time
        if curTime < endTime then
          return 0
        else
          local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
          local timeStr = "SeaNoteEnter_RedCheck" .. day .. curMissionCfg.MissionID
          if UIActivityHelper.HasLocalDB(timeStr) then
            return 0
          end
        end
        return 1
      end
    else
      return 0
    end
  end
  local count = curPass + 1
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
  local timeStr = "SeaNoteEnter_RedCheck" .. day .. self._lineDatas[count].MissionID
  if not UIActivityHelper.HasLocalDB(timeStr) then
    return 1
  end
  return 0
end
