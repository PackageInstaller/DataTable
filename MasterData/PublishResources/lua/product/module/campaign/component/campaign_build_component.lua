_class("CampaignBuildComponent", ICampaignComponent)
CampaignBuildComponent = CampaignBuildComponent

function CampaignBuildComponent:Constructor()
  self.m_component_info = BuildComponentInfo:New()
end

function CampaignBuildComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = BuildComponentInfo:New()
  end
  return self.m_component_info
end

function CampaignBuildComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CampaignBuildComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_REBUILD
end

function CampaignBuildComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function CampaignBuildComponent:HandleBuild(TT, asyncRes, build_item_id, build_type)
  local request = BuildComponentBuildReq:New()
  request.item_id = build_item_id
  request.build_type = build_type
  local response = BuildComponentBuildRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignBuildComponent] HandleBuild ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.build_item_infos[response.build_info.build_item_id] = response.build_info
  return asyncRes, response.rewards
end

function CampaignBuildComponent:HandleStory(TT, asyncRes, build_item_id, build_type)
  local request = BuildComponentStoryReq:New()
  request.item_id = build_item_id
  request.status = build_type
  local response = BuildComponentStoryRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignBuildComponent] HandleStory ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.build_item_infos[response.build_info.build_item_id] = response.build_info
  return asyncRes
end

function CampaignBuildComponent:HandleCompleteEvent(TT, asyncRes, event_id)
  local request = BuildComponentCompleteEventReq:New()
  request.event_id = event_id
  local response = BuildComponentCompleteEventRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignBuildComponent] HandleCompleteEvent ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.event_info = response.build_event_info
  return asyncRes, response.rewards
end

function CampaignBuildComponent:HandlePicnicPutFood(TT, asyncRes, area_id)
  local request = PicnicPutFoodReq:New()
  request.area_id = area_id
  local response = PicnicPutFoodRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignBuildComponent] HandlePicnicPutFood ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.m_picnic_info = response.picnicInfo
  return asyncRes, response.reward
end

function CampaignBuildComponent:HandlePicnicStory(TT, asyncRes)
  local request = PicnicWatchStoryReq:New()
  local response = PicnicWatchStoryRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignBuildComponent] HandlePicnicStory ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.m_picnic_info.m_have_story = false
  return asyncRes
end

function CampaignBuildComponent:CampaignComponentPushNotify(notify_data)
  if BuildComponentNotifyType.BuildComponentNotify_EventRefresh == notify_data.m_notify_type then
    local ev = NotifyBuildComponentEventRefresh:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.event_info = ev.event_info
      GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixEventRefresh)
    else
      Log.error("[CampaignCom][CampaignBuildComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  elseif BuildComponentNotifyType.BuildComponentNotify_TokenMoneyChanged == notify_data.m_notify_type then
    local ev = NotifyBuildComponentTokenMoneyChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self.m_component_info.item_count = ev.item_count
      GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixEventRefresh)
    else
      Log.error("[CampaignCom][CampaignBuildComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function CampaignBuildComponent:HaveEventRedPoint()
  local eventInfo = self.m_component_info.event_info
  if eventInfo.cur_event_list and table.count(eventInfo.cur_event_list) > 0 then
    return true
  end
  return false
end

function CampaignBuildComponent:GetNextBuildCost(component)
  local componentID = component.m_campaign_id * 100000 + component.m_component_type * 100 + component.m_component_id
  local lastItem = table.maxn(self.m_component_info.build_item_infos)
  if lastItem == 0 then
    local item_cfg = Cfg.cfg_component_build_item({ComponentID = componentID})
    local build_cost = item_cfg[2].BuildCost
    return build_cost[1][1], 0
  end
  local cfgs = Cfg.cfg_component_build_item({ComponentID = componentID, BuildItemId = lastItem})
  if not cfgs then
    return 0, 0
  end
  local mask = 0
  for _, v in pairs(cfgs) do
    mask = mask | v.BuildStatus
    if mask > component.build_item_infos[lastItem].mask then
      local next_status_cfg = Cfg.cfg_component_build_item({
        ComponentID = componentID,
        BuildItemId = lastItem,
        BuildStatus = v.BuildStatus
      })
      local next_status_cost = next_status_cfg[1].BuildCost
      if next_status_cost then
        return next_status_cost[1][1], next_status_cost[1][2]
      else
        return 0, 0
      end
    end
  end
  local next_item_cfg = Cfg.cfg_component_build_item({
    ComponentID = componentID,
    BuildItemId = lastItem + 1
  })
  if not next_item_cfg then
    return -1, -1
  end
  local next_item_cost = next_item_cfg[2].BuildCost
  if next_item_cost then
    return next_item_cost[1][1], next_item_cost[1][2]
  else
    return 0, 0
  end
end

function CampaignBuildComponent:HaveSakuragariRedPoint()
  local component = self:GetComponentInfo()
  local next_item_id, next_cost = self:GetNextBuildCost(component)
  if 0 < next_item_id then
    local my_item_count = ClientCampaignDrawShop.GetMoney(next_item_id)
    if 0 < my_item_count and 0 <= next_cost and next_cost <= my_item_count then
      return true
    end
  end
  local picnic_count = 0
  for key, value in pairs(component.build_item_infos) do
    if value.mask & BuildType.PICNIC_AREA ~= 0 then
      picnic_count = picnic_count + 1
      if picnic_count > table.count(component.m_picnic_info.m_next_food) then
        return true
      end
    end
  end
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  if not time_mod then
    return false
  end
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  for key, value in pairs(component.m_picnic_info.m_next_food) do
    if value <= tmNowTime then
      return true
    end
  end
  if component.m_picnic_info.m_have_story then
    return true
  end
  return false
end

function CampaignBuildComponent:Start_HandleBuild(build_item_id, build_type, callback)
  local lockName = "CampaignBuildComponent:Start_HandleBuild"
  GameGlobal.UIStateManager():Lock(lockName)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewardList
    res, rewardList = self:HandleBuild(TT, res, build_item_id, build_type)
    if callback then
      callback(res, rewardList)
    end
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end

function CampaignBuildComponent:Start_HandleStory(buildingId, curStatus, callback)
  local lockName = "CampaignBuildComponent:Start_HandleStory"
  GameGlobal.UIStateManager():Lock(lockName)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res = self:HandleStory(TT, res, buildingId, curStatus)
    if callback then
      callback(res)
    end
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end

function CampaignBuildComponent:Start_HandlePicnicPutFood(area_id, callback)
  local lockName = "CampaignBuildComponent:Start_HandlePicnicPutFood"
  GameGlobal.UIStateManager():Lock(lockName)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewardList
    res, rewardList = self:HandlePicnicPutFood(TT, res, area_id)
    if callback then
      callback(res, rewardList)
    end
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end

function CampaignBuildComponent:Start_HandlePicnicStory(callback)
  local lockName = "CampaignBuildComponent:Start_HandlePicnicStory"
  GameGlobal.UIStateManager():Lock(lockName)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res = self:HandlePicnicStory(TT, res)
    if callback then
      callback(res)
    end
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end
