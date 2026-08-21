_class("PlayerBackComponent", ICampaignComponent)
PlayerBackComponent = PlayerBackComponent

function PlayerBackComponent:Constructor()
  self.m_component_info = CPlayerBackComponentInfo:New()
end

function PlayerBackComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = CPlayerBackComponentInfo:New()
  end
  return self.m_component_info
end

function PlayerBackComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function PlayerBackComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_BACK
end

function PlayerBackComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function PlayerBackComponent:HandleRecvBackReward(TT, asyncRes)
  local request = BackComponentRecvRewardReq:New()
  local response = BackComponentRecvRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PlayerBackComponent] HandleRecvBackReward ret:", asyncRes.m_result)
    return
  end
end

function PlayerBackComponent:IsRecvBackReward()
  local info = self:GetComponentInfo()
  return info.bIsRecvReward
end

function PlayerBackComponent:SetRecvBackRewardGot()
  local info = self:GetComponentInfo()
  info.bIsRecvReward = true
end

function PlayerBackComponent:GetAwards()
  local info = self:GetComponentInfo()
  return info.BackRewardVec
end

function PlayerBackComponent:GetTimeStampStartEnd()
  local info = self:GetComponentInfo()
  return info.tmTriggerTime, info.tmEndTime
end
