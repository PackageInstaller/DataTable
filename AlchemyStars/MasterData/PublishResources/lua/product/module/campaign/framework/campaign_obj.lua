_class("CampaignObj", Object)
CampaignObj = CampaignObj

function CampaignObj:Constructor(a_module)
  self.m_module = a_module
  self.m_server_time = 0
  self.m_sample_info = nil
  self.m_component_dict = {}
  self.m_campaign_common_config = nil
  self.m_special_type = CampaignSpecialType.CST_Common
end

function CampaignObj:SpecialType(type)
  return self.m_special_type == type
end

function CampaignObj:IsCommonCam()
  return self.m_special_type == CampaignSpecialType.CST_Common
end

function CampaignObj:IsReView()
  local campaign_cfg = Cfg.cfg_campaign[self.m_sample_info.id]
  if campaign_cfg == nil then
    Log.exception("cfg_campaign中找不到对应活动配置 id:" .. self.m_sample_info.id)
    return false
  end
  if campaign_cfg.CostItem ~= nil and #campaign_cfg.CostItem > 0 then
    return true
  end
  return false
end

function CampaignObj:GetComponent(a_component_id)
  local component = self.m_component_dict[a_component_id]
  if not component then
    Log.debug("[Campaign][CampaignObj] GetComponent not component! a_component_id:", a_component_id)
    return nil
  end
  return component
end

function CampaignObj:GetComponentInfo(a_component_id)
  local component = self:GetComponent(a_component_id)
  if not component then
    Log.error("[Campaign][CampaignObj] GetComponentInfo not component! a_component_id:", a_component_id)
    return nil
  end
  return component:GetComponentInfo()
end

function CampaignObj:Init(a_campaign_load_info)
  self.m_server_time = a_campaign_load_info.m_server_time
  self:UpdateSampleInfo(a_campaign_load_info.m_sample_info)
  self.m_campaign_common_config = a_campaign_load_info.m_campaign_common_config
  for key, value in pairs(a_campaign_load_info.m_data_dict) do
    local component_obj = self.m_component_dict[key]
    if not component_obj then
      component_obj = self.m_module.m_component_factory:CreateCampaignComponent(value.m_com_type, value)
      if not component_obj then
        Log.error("[Campaign][CampaignObj] Init CreateCampaignComponent error!", key)
      else
        self.m_component_dict[key] = component_obj
      end
    else
      component_obj:ResetUnLockInfo(value.m_b_unlock, value.m_unlock_time, value.m_unlock_items, value.m_need_mission_type, value.m_need_mission_id)
      component_obj:UpdateComponentStep(value.m_component_step)
      component_obj:ResetCommonInfo(value.m_open_time, value.m_close_time, value.m_first_story_id)
      component_obj:InitComponentInfo(value)
    end
    Log.debug("[Campaign][CampaignObj] Init component succ!", key)
  end
end

function CampaignObj:UpdateSampleInfo(a_sample_info)
  if a_sample_info then
    self.m_sample_info = a_sample_info
    self.m_special_type = Cfg.cfg_campaign[a_sample_info.id].SpecialType
    self.HandleCampaignSampleExtandData(a_sample_info.camp_type, a_sample_info.extend_data)
    self.HandleCampaignSampleExtandInfo(a_sample_info.camp_type, a_sample_info.m_extend_info)
  end
end

function CampaignObj:HandleCampaignSampleExtandData(a_camp_type, a_extend_data)
end

function CampaignObj:HandleCampaignSampleExtandInfo(a_camp_type, a_extend_info)
end

function CampaignObj:UpdateComponentStep(a_component_id, a_step)
  local component = self.m_component_dict[a_component_id]
  if not component then
    Log.error("[Campaign][CampaignObj] UpdateComponentStep not component! ", a_component_id)
    return
  end
  component:UpdateComponentStep(a_step)
end

function CampaignObj:UpdateCampaignStep(step, flag)
  if not self.m_sample_info then
    Log.error("[Campaign][CampaignObj] UpdateCampaignStep sample_info not found! ")
    return
  end
  if flag then
    self.m_sample_info.step = self.m_sample_info.step | step
  else
    self.m_sample_info.step = self.m_sample_info.step & ~step
  end
end

function CampaignObj:SetCampaignStep(step)
  if not self.m_sample_info then
    Log.error("[Campaign][CampaignObj] UpdateCampaignStep sample_info not found! ")
    return
  end
  self.m_sample_info.step = step
end

function CampaignObj:CampaignComProtoPushNotify(notify)
  local component = self.m_component_dict[notify.m_component_id]
  if component then
    component:UpdateComponentStep(notify.m_component_step)
    if notify.m_push_data.m_notify_type ~= CampaignDefaultNotify.CAMPAIGN_NOTIFY_DEFAULT then
      component:CampaignComponentPushNotify(notify.m_push_data)
    end
    return
  else
    Log.error("[Campaign][CampaignObj] CampaignComProtoPushNotify not component! ", notify.m_component_id)
  end
end

function CampaignObj:CampaignComponentIsUnLock(component_id)
  local component = self.m_component_dict[component_id]
  if not component then
    Log.error("[Campaign][CampaignObj] CampaignComponentIsUnLock not component!", component_id)
    return false
  end
  return component:ComponentIsUnLock()
end

function CampaignObj:CampaignComponentUnLockTime(component_id)
  local component = self.m_component_dict[component_id]
  if not component then
    Log.error("[Campaign][CampaignObj] CampaignComponentUnLockTime not component!", component_id)
    return GameGlobal:GetInstance():GetCurrentRealTime()
  end
  return component:ComponentUnLockTime()
end

function CampaignObj:GetCampaignCommonConfigByKey(key)
  local val = self.m_campaign_common_config[key]
  return val
end

function CampaignObj:GetCampaignLocalProcess()
  return self.m_module:GetCampaignLocalProcess(self.m_sample_info.camp_type)
end

function CampaignObj:GetSampleInfo()
  return self.m_sample_info
end
