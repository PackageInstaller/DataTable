require("component_base")
_class("ActionPointComponent", ICampaignComponent)
ActionPointComponent = ActionPointComponent

function ActionPointComponent:Constructor()
  self.m_component_info = ActionPointComponentInfo:New()
end

function ActionPointComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = ActionPointComponentInfo:New()
  end
  return self.m_component_info
end

function ActionPointComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function ActionPointComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_ACTION_POINT
end

function ActionPointComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function ActionPointComponent:HandleActionPointData(TT, asyncRes)
  local request = ActionPointDataReq:New()
  local response = ActionPointDataReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    asyncRes:SetResult(asyncRes.m_result)
    Log.error("[CampaignCom][ActionPointComponent] HandleActionPointData ret:", asyncRes.m_result)
    return nil
  end
  ComponentInfo.m_info = response.m_info
  return response
end

function ActionPointComponent:GetRegainEndTime()
  if self.m_component_info.m_info == nil then
    return 0
  end
  for key, value in pairs(self.m_component_info.m_info) do
    return value.m_end_time
  end
  return 0
end

function ActionPointComponent:GetEndTime(cfgID)
  if self.m_component_info.m_info == nil then
    return 0
  end
  if self.m_component_info.m_info[cfgID] == nil then
    return 0
  end
  return self.m_component_info.m_info[cfgID].m_end_time
end

function ActionPointComponent:GetActionPointCfgMap()
  local componentId = self:GetComponentCfgId()
  local cfgMap = Cfg.cfg_component_action_point({ComponentID = componentId})
  if cfgMap == nil then
    Log.exception("cfg_component_action_point中找不到组件ID:", componentId)
    return nil
  end
  return cfgMap
end

function ActionPointComponent:GetActionPointConfig()
  local componentId = self:GetComponentCfgId()
  local cfg = Cfg.cfg_component_action_point({ComponentID = componentId})
  if cfg == nil then
    Log.exception("cfg_component_action_point中找不到组件ID:", componentId)
    return nil
  end
  return cfg[1]
end

function ActionPointComponent:GetItemId()
  local cfg = self:GetActionPointConfig()
  return cfg and cfg.ItemID or 0
end

function ActionPointComponent:GetItemCount()
  local cfg = self:GetActionPointConfig()
  if cfg then
    local module = GameGlobal.GetModule(ItemModule)
    local count = module:GetItemCount(self:GetItemId()) or 0
    local ceiling = cfg.RegainMax
    return count, ceiling
  end
end

function ActionPointComponent:GetItemIcon()
  local cfg = Cfg.cfg_top_tips[self:GetItemId()]
  return cfg and cfg.Icon
end

function ActionPointComponent:GetItemReplaceIcon()
  local cfg = Cfg.cfg_top_tips[self:GetItemId()]
  return cfg and cfg.ReplaceIcon
end
