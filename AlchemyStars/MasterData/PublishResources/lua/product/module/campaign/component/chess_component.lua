require("component_base")
_class("ChessComponent", ICampaignComponent)
ChessComponent = ChessComponent

function ChessComponent:Constructor()
  self.m_component_info = ChessComponentInfo:New()
end

function ChessComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = ChessComponentInfo:New()
  end
  return self.m_component_info
end

function ChessComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function ChessComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_CHESS
end

function ChessComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function ChessComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_ChessMission
end

function ChessComponent:GetCampaignMissionParamKeyMap()
  local componentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(componentInfo.m_campaign_id, componentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end
