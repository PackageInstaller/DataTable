require("component_base")
_class("StoryComponent", ICampaignComponent)
StoryComponent = StoryComponent

function StoryComponent:Constructor()
  self.m_component_info = CStoryComponentInfo:New()
end

function StoryComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = CStoryComponentInfo:New()
  end
  return self.m_component_info
end

function StoryComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function StoryComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function StoryComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_STORY
end

function StoryComponent:GetCampaignCount()
  return self.m_component_info.m_total_count
end

function StoryComponent:GetAlreadyReceivedStoryIdList()
  return self.m_component_info.m_recieved_reward_story
end

function StoryComponent:IsStoryReceived(story_id)
  if not next(self.m_component_info.m_recieved_reward_story) then
    return false
  end
  return table.icontains(self.m_component_info.m_recieved_reward_story, story_id)
end

function StoryComponent:CheckStoryIsUnlock(story_id)
  local config = Cfg.cfg_campaign_story[story_id]
  if not config then
    return false
  end
  local recv_list = self:GetAlreadyReceivedStoryIdList()
  if config.PreStoryID and not table.icontains(recv_list, config.PreStoryID) then
    return false
  end
  if config.ComponentID then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    if not campaignModule then
      return false
    end
    local com = campaignModule:GetComponentByComponentId(config.ComponentID)
    if not com then
      return false
    end
    if config.NeedMissionList ~= nil and next(config.NeedMissionList) ~= nil then
      for k, v in pairs(config.NeedMissionList) do
        if not com:IsPassCamMissionID(v) then
          return false
        end
      end
    end
  end
  return true
end

function StoryComponent:GetStoryIsUnlockInfo(story_id)
  local config = Cfg.cfg_campaign_story[story_id]
  if not config then
    return ECampaignStoryCondition.E_CONDITION_ALL_LOCK
  end
  local condition1 = true
  local condition2 = true
  local recv_list = self:GetAlreadyReceivedStoryIdList()
  if config.PreStoryID and not table.icontains(recv_list, config.PreStoryID) then
    condition1 = false
  end
  if config.ComponentID then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    if not campaignModule then
      return ECampaignStoryCondition.E_CONDITION_ALL_LOCK
    end
    local com = campaignModule:GetComponentByComponentId(config.ComponentID)
    if not com then
      return ECampaignStoryCondition.E_CONDITION_ALL_LOCK
    end
    if config.NeedMissionList ~= nil and next(config.NeedMissionList) ~= nil then
      for k, v in pairs(config.NeedMissionList) do
        if not com:IsPassCamMissionID(v) then
          condition2 = false
        end
      end
    end
  end
  if condition1 and condition2 then
    return ECampaignStoryCondition.E_UNLOCK
  elseif condition1 then
    return ECampaignStoryCondition.E_CONDITION1_UNLOCK
  elseif condition2 then
    return ECampaignStoryCondition.E_CONDITION2_UNLOCK
  else
    return ECampaignStoryCondition.E_CONDITION_ALL_LOCK
  end
end

function StoryComponent:HaveRedPoint()
  if not self:ComponentIsOpen() then
    return false
  end
  local recv_list = self:GetAlreadyReceivedStoryIdList()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  if not Cfg.cfg_component_story[nCfgId] then
    return false
  end
  local story_list = Cfg.cfg_component_story[nCfgId].StoryID
  local count_list = Cfg.cfg_component_story[nCfgId].UnlockCount
  local cur_count = self:GetCampaignCount()
  for i = 1, table.count(story_list) do
    if not table.icontains(recv_list, story_list[i]) then
      if count_list and count_list[i] then
        if cur_count >= count_list[i] and self:CheckStoryIsUnlock(story_list[i]) then
          return true
        end
      elseif self:CheckStoryIsUnlock(story_list[i]) then
        return true
      end
    end
  end
  return false
end

function StoryComponent:HandleStoryTake(TT, asyncRes, nStoryId)
  local request = StoryComponentRecvRewardReq:New()
  local response = StoryComponentRecvRep:New()
  request.story_id = nStoryId
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][StoryComponent] HandleStoryTake ret:", asyncRes.m_result)
    return nil
  end
  table.insert(self.m_component_info.m_recieved_reward_story, nStoryId)
  return response.rewards
end

function StoryComponent:CampaignComponentPushNotify(notify_data)
  if StoryComponentNotifyType.StoryComponentNotifyType_PointChange == notify_data.m_notify_type then
    local ev = NotifyStoryComponentPointChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.m_total_count = ev.m_total_count
    else
      Log.error("[CampaignCom][StoryComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end
