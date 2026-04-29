require("component_base")
_class("SeniorSkinComponent", ICampaignComponent)
SeniorSkinComponent = SeniorSkinComponent

function SeniorSkinComponent:Constructor()
  self.m_component_info = SeniorSkinComponentInfo:New()
end

function SeniorSkinComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = SeniorSkinComponentInfo:New()
  end
  return self.m_component_info
end

function SeniorSkinComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function SeniorSkinComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_SENIOR_SKIN
end

function SeniorSkinComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function SeniorSkinComponent:HandleApplySeniorSkin(TT, asyncRes)
  local request = SeniorSkinComponentApplyShake:New()
  local response = SeniorSkinComponentApplyShakeReplay:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][SeniorSkinComponent] HandleApplySeniorSkin ret:", asyncRes.m_result)
    return nil
  end
  asyncRes:SetSucc(true)
  return asyncRes, response.id
end

function SeniorSkinComponent:AllAwardCollected()
  local info = self:GetComponentInfo()
  local allCfgs = Cfg.cfg_component_senior_skin_weight({
    ComponentID = self:GetComponentCfgId()
  })
  local allIDs = {}
  for _, cfg in pairs(allCfgs) do
    allIDs[cfg.ID] = true
  end
  for _, id in pairs(info.shake_win_ids) do
    allIDs[id] = nil
  end
  return next(allIDs) == nil
end
