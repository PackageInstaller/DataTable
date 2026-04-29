_class("ICampaignComponent", Object)
ICampaignComponent = ICampaignComponent

function ICampaignComponent:Constructor()
  self.m_campaign_com_module = nil
end

function ICampaignComponent:Init(a_module, a_load_info)
  self.m_campaign_com_module = a_module
  if self:GetComponentType() ~= a_load_info.m_com_type then
    Log.error("[Campaign][ICampaignComponent] LoadComponentInfo type error! m_com_type:", a_load_info.m_com_type, ", GetComponentType:", self:GetComponentType())
    return false
  end
  local info = self:GetComponentInfo()
  info.m_campaign_id = a_load_info.m_campaign_id
  info.m_component_type = a_load_info.m_com_type
  info.m_component_id = a_load_info.m_com_id
  info.m_component_step = a_load_info.m_component_step
  info.m_b_unlock = a_load_info.m_b_unlock
  info.m_unlock_time = a_load_info.m_unlock_time
  info.m_unlock_items = a_load_info.m_unlock_items
  info.m_open_time = a_load_info.m_open_time
  info.m_close_time = a_load_info.m_close_time
  info.m_need_mission_type = a_load_info.m_need_mission_type
  info.m_need_mission_id = a_load_info.m_need_mission_id
  info.m_first_story_id = a_load_info.m_first_story_id
  return self:InitComponentInfo(a_load_info)
end

function ICampaignComponent:ResetUnLockInfo(is_unlock, unlock_time, unlock_items, unlock_need_mission_type, unlock_need_mission_id)
  local info = self:GetComponentInfo()
  info.m_b_unlock = is_unlock
  info.m_unlock_time = unlock_time
  info.m_unlock_items = unlock_items
  info.m_need_mission_type = unlock_need_mission_type
  info.m_need_mission_id = unlock_need_mission_id
end

function ICampaignComponent:ResetCommonInfo(open_time, close_time, first_story_id)
  local info = self:GetComponentInfo()
  info.m_open_time = open_time
  info.m_close_time = close_time
  info.m_first_story_id = first_story_id
end

function ICampaignComponent:ComponentIsOpen()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local info = self:GetComponentInfo()
  if not info then
    Log.error("[Campaign][ICampaignComponent] ComponentIsOpen GetComponentInfo is nil! ComponentType:", self:GetComponentType())
    return false
  end
  local isOpen = curTime >= info.m_open_time and curTime <= info.m_close_time
  return isOpen and info.m_b_unlock
end

function ICampaignComponent:ComponentIsClose()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local info = self:GetComponentInfo()
  if not info then
    Log.error("[Campaign][ICampaignComponent] ComponentIsClose GetComponentInfo is nil! ComponentType:", self:GetComponentType())
    return false
  end
  return curTime > info.m_close_time
end

function ICampaignComponent:ComponentIsUnLock()
  local info = self:GetComponentInfo()
  if not info then
    Log.error("[Campaign][ICampaignComponent] ComponentIsUnLock GetComponentInfo is nil! ComponentType:", self:GetComponentType())
    return false
  end
  return info.m_b_unlock
end

function ICampaignComponent:ComponentUnLockTime()
  local info = self:GetComponentInfo()
  if not info then
    Log.error("[Campaign][ICampaignComponent] ComponentUnLockTime GetComponentInfo is nil! ComponentType:", self:GetComponentType())
    return -1
  end
  return info.m_unlock_time
end

function ICampaignComponent:ComponentNeedMission()
  local info = self:GetComponentInfo()
  if not info then
    Log.error("[Campaign][ICampaignComponent] ComponentNeedMission GetComponentInfo is nil! ComponentType:", self:GetComponentType())
    return 0, 0
  end
  return info.m_need_mission_type, info.m_need_mission_id
end

function ICampaignComponent:ComponentUnlockItems()
  local info = self:GetComponentInfo()
  if not info then
    Log.error("[Campaign][ICampaignComponent] ComponentUnlockItems GetComponentInfo is nil! ComponentType:", self:GetComponentType())
    return nil
  end
  return info.m_unlock_items
end

function ICampaignComponent:GetComponentStep()
  local info = self:GetComponentInfo()
  if not info then
    Log.error("[Campaign][ICampaignComponent] GetComponentStep GetComponentInfo is nil! ComponentType:", self:GetComponentType())
    return ECampaignStep.CAMPAIGN_STEP_INVALID
  end
  return info.m_component_step
end

function ICampaignComponent:UpdateComponentStep(a_step)
  local info = self:GetComponentInfo()
  if not info then
    Log.error("[Campaign][ICampaignComponent] UpdateComponentStep GetComponentInfo is nil! ComponentType:", self:GetComponentType())
    return
  end
  if a_step ~= info.m_component_step then
    info.m_component_step = a_step
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, info.m_campaign_id, info.m_component_id, info.m_component_step)
  end
end

function ICampaignComponent:InitComponentInfo(a_load_info)
  Log.error("[Campaign][ICampaignComponent] InitComponentInfo not found! ComponentType:", self:GetComponentType())
  return false
end

function ICampaignComponent:GetComponentInfo()
  Log.error("[Campaign][ICampaignComponent] GetComponentInfo not found! ComponentType:", self:GetComponentType())
  return nil
end

function ICampaignComponent:HaveRedPoint()
  if not self:ComponentIsOpen() then
    return false
  end
  local component_step = self:GetComponentStep()
  return component_step & ECampaignStep.CAMPAIGN_STEP_REWARD > 0
end

function ICampaignComponent:GetCampaignMissionComponentId()
  Log.error("[Campaign][ICampaignComponent] GetCampaignMissionComponentId not found! ComponentType:", self:GetComponentType())
  return nil
end

function ICampaignComponent:GetCampaignMissionParamKeyMap()
  Log.error("[Campaign][ICampaignComponent] GetCampaignMissionParamKeyMap not found! ComponentType:", self:GetComponentType())
  return nil
end

function ICampaignComponent:GetComponentCfgId()
  local info = self:GetComponentInfo()
  if not info then
    Log.error("[Campaign][ICampaignComponent] GetComponentCfgId GetComponentInfo is nil! ComponentType:", self:GetComponentType())
    return
  end
  return self:GetComponetCfgId(info.m_campaign_id, info.m_component_id)
end

function ICampaignComponent:GetComponetCfgId(nCampaignId, nComponentID)
  local nCfgId = nCampaignId * CampaignConfigDefine.CONFIG_CAMPAIGN_ID_MOD + self:GetComponentType() * CampaignConfigDefine.CONFIG_COMPONENT_TYPE_MOD + nComponentID
  return nCfgId
end

function ICampaignComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_TYPE_BEGIN
end

function ICampaignComponent:CampaignComponentPushNotify(notify_data)
  local info = self:GetComponentInfo()
  if not info then
    Log.error("[Campaign][ICampaignComponent] CampaignComponentPushNotify GetComponentInfo is nil! ComponentType:", self:GetComponentType())
    return
  end
  Log.error("[Campaign][ICampaignComponent] CampaignComponentPushNotify not found! notify_type:", notify_data.m_notify_type, ", campaign_id:", info.m_campaign_id, ", ComponentType:", self:GetComponentType())
  return
end
