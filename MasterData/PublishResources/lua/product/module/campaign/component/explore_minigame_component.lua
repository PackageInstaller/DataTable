require("component_base")
_class("ExploreMinigameComponent", ICampaignComponent)
ExploreMinigameComponent = ExploreMinigameComponent

function ExploreMinigameComponent:Constructor()
  self.m_component_info = MiniGameExploreComponentLoadInfo:New()
end

function ExploreMinigameComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = MiniGameExploreComponentLoadInfo:New()
  end
  return self.m_component_info
end

function ExploreMinigameComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function ExploreMinigameComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_MINI_GAME_EXPLORE
end

function ExploreMinigameComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function ExploreMinigameComponent:HandleRandomRewardPostion(TT, asyncRes)
  local request = MiniGameExploreComponentRandomLocationReq:New()
  local response = MiniGameExploreComponentRandomPostionReply:New()
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DemoComponent] HandleDemo ret:", asyncRes.m_result)
    return -1
  end
  asyncRes:SetSucc(true)
  return response.postion_id
end

function ExploreMinigameComponent:HandleExploredReceiveReward(TT, asyncRes)
  local request = MiniGameExploreComponentRecvRewardReq:New()
  local response = MiniGameExploreComponentRecvRewardReply:New()
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][DemoComponent] HandleDemo ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.used_high_equip_num = response.used_high_equip_num
  self.m_component_info.used_low_equip_num = response.used_low_equip_num
  self.m_component_info.next_refresh_time = response.next_refresh_time
  asyncRes:SetSucc(true)
  return response.rewards
end

function ExploreMinigameComponent:HandleEnterExplored(TT)
  local asyncRes = AsyncRequestRes:New()
  local request = MiniGameExploreComponentClearNewEquipReq:New()
  local response = MiniGameExploreComponentClearNewEquipReply:New()
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  self.m_component_info.have_new_high_equip = false
  return
end
