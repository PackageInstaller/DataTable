require("component_base")
_class("PerfectPuzzleComponent", ICampaignComponent)
PerfectPuzzleComponent = PerfectPuzzleComponent

function PerfectPuzzleComponent:Constructor()
  self.m_component_info = PerfectPuzzleComponentInfo:New()
end

function PerfectPuzzleComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = PerfectPuzzleComponentInfo:New()
  end
  return self.m_component_info
end

function PerfectPuzzleComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function PerfectPuzzleComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_PERFECT_PUZZLE
end

function PerfectPuzzleComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function PerfectPuzzleComponent:GetHasPassedDebris(missionId)
  local info = self.m_component_info.m_pass_mission_info[missionId]
  if info == nil then
    return false
  end
  local cfg = Cfg.cfg_component_perfect_puzzle({MissionID = missionId})
  if cfg == nil then
    return false
  end
  if #cfg == 0 then
    return false
  end
  return true
end

function PerfectPuzzleComponent:HandleCompletePerfectPuzzle(TT, asyncRes, missionId, score)
  local request = CompletePerfectPuzzleReq:New()
  request.mission_id = missionId
  request.score = score
  local response = CompletePerfectPuzzleRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PerfectPuzzleComponent] HandleCompleteTacitTestMission ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_pass_mission_info[missionId] = response.info
  return response.ret
end

function PerfectPuzzleComponent:HandleUnlockPerfectPuzzle(TT, asyncRes, missionId)
  local request = UnlockPerfectPuzzleReq:New()
  request.mission_id = missionId
  local response = UnlockPerfectPuzzleRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PerfectPuzzleComponent] HandleUnlockPerfectPuzzle ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_unlock_missions = response.m_unlock_missions
  return response.ret
end

function PerfectPuzzleComponent:HaveRedPoint()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local cfgs = Cfg.cfg_component_perfect_puzzle({
    ComponentID = self:GetComponentCfgId()
  })
  if cfgs then
    for i = 1, #cfgs do
      local curTime = svrTimeModule:GetServerTime() * 0.001
      local unlockTime = loginModule:GetTimeStampByTimeStr(cfgs[i].UnlockTime, 0)
      local isUnlock = curTime >= unlockTime
      local key = "UICN13PostGameBackpack" .. GameGlobal.GetModule(LoginModule):GetRoleShowID() .. cfgs[i].ID
      if isUnlock then
        local record = LocalDB.GetInt(key, 0)
        if record == 0 then
          return true
        end
      end
    end
  end
  return false
end
