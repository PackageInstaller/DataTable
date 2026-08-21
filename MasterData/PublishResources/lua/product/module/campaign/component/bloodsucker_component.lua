require("component_base")
_class("BloodsuckerComponent", ICampaignComponent)
BloodsuckerComponent = BloodsuckerComponent

function BloodsuckerComponent:Constructor()
  self.m_component_info = BloodsuckerComponentInfo:New()
end

function BloodsuckerComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = BloodsuckerComponentInfo:New()
  end
  return self.m_component_info
end

function BloodsuckerComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function BloodsuckerComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_BLOODSUCKER
end

function BloodsuckerComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function BloodsuckerComponent:HandleBloodsuckerUpgradeTalentPoint(TT, asyncRes, row, index)
  local request = BloodsuckerComponentUpgradeTalentPointReq:New()
  request.row = row
  request.index = index
  local response = BloodsuckerComponentUpgradeTalentPointRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BloodsuckerComponent] HandleBloodsuckerUpgradeTalentPoint ret:", asyncRes.m_result)
    return nil
  end
  asyncRes:SetSucc(true)
end

function BloodsuckerComponent:HandleBloodsuckerSelectSkill(TT, asyncRes, row, index)
  local request = BloodsuckerComponentSelectSkillReq:New()
  request.row = row
  request.index = index
  local response = BloodsuckerComponentSelectSkillRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BloodsuckerComponent] HandleBloodsuckerSelectSkill ret:", asyncRes.m_result)
    return nil
  end
  asyncRes:SetSucc(true)
end

function BloodsuckerComponent:HandleBloodsuckerResetTalentTree(TT, asyncRes)
  local request = BloodsuckerComponentResetTalentTreeReq:New()
  local response = BloodsuckerComponentResetTalentTreeRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BloodsuckerComponent] HandleBloodsuckerResetTalentTree ret:", asyncRes.m_result)
    return nil
  end
  asyncRes:SetSucc(true)
end

function BloodsuckerComponent:HandleBloodsuckerChangeFormation(TT, asyncRes, pet_data_list)
  local request = BloodsuckerComponentChangeFormationReq:New()
  request.formation_pet_list = pet_data_list
  local response = BloodsuckerComponentFormationRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][BloodsuckerComponent] HandleBloodsuckerChangeFormation ret:", asyncRes.m_result)
    return nil
  end
  asyncRes:SetSucc(true)
end

function BloodsuckerComponent:CampaignComponentPushNotify(notify_data)
  if BloodsuckerComponentNotifyType.BloodsuckerComponentNotify_TalentTreeChange == notify_data.m_notify_type then
    local ev = NotifyBloodsuckerComponentTalentTreeChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.talent_info = ev.tree_info
      GameGlobal.EventDispatcher():Dispatch(GameEventType.N25UpdateTalentData)
    else
      Log.error("[CampaignCom][BloodsuckerComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end
