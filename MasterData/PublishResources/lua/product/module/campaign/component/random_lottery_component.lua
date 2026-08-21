_class("RandomLotteryComponent", ICampaignComponent)
RandomLotteryComponent = RandomLotteryComponent

function RandomLotteryComponent:Constructor()
  self._componentInfo = RandomLotteryComponentInfo:New()
end

function RandomLotteryComponent:ComponentInfo()
  if not self._componentInfo then
    self._componentInfo = RandomLotteryComponentInfo:New()
  end
  return self._componentInfo
end

function RandomLotteryComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function RandomLotteryComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_RANDOM_LOTTERY
end

function RandomLotteryComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self._componentInfo)
  return ret
end

function RandomLotteryComponent:ClearDraw(msgInfo)
  local ComponentInfo = self:ComponentInfo()
  ComponentInfo.draw_refresh_time = msgInfo.draw_refresh_time
  ComponentInfo.m_draw = {}
end

function RandomLotteryComponent:HandleReceiveRandomLotteryCost(TT, asyncRes, cfgID, isOne)
  local request = RandomLotteryComponentCostReq:New()
  request.cfg_id = cfgID
  request.is_one = isOne
  local response = RandomLotteryComponentCostRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][RandomLotteryComponent] HandleReceiveRandomLotteryCost ret:", asyncRes.m_result)
    return nil
  else
    ComponentInfo.m_one_count = response.m_one_count
    ComponentInfo.m_multi_count = response.m_multi_count
  end
  return response
end

function RandomLotteryComponent:HandleRandomLotteryComponentDraw(TT, asyncRes, cfgID)
  local request = RandomLotteryComponentDrawReq:New()
  request.cfg_id = cfgID
  local response = RandomLotteryComponentDrawRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("RandomLotteryComponent:HandleRandomLotteryComponentDraw ret:", asyncRes.m_result)
    return nil
  else
    table.insert(ComponentInfo.m_draw, response.m_draw)
    ComponentInfo.m_one_count = response.m_one_count
    ComponentInfo.m_multi_count = response.m_multi_count
  end
  return response
end

function RandomLotteryComponent:HandleRandomLotteryComponentDrawReward(TT, asyncRes, index)
  local request = RandomLotteryComponentDrawRewardReq:New()
  request.index = index - 1
  local response = RandomLotteryComponentDrawRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("RandomLotteryComponent:RandomLotteryComponentDrawRewardReq ret:", asyncRes.m_result)
    return nil
  else
    ComponentInfo.m_draw[index] = response.m_draw
  end
  return response
end

function RandomLotteryComponent:CampaignComponentPushNotify(notify_data)
  if RandomLotteryComponentNotifyType.RandomLotteryComponentNotify_Clear == notify_data.m_notify_type then
    local ev = NotifyRandomLotteryComponentClear:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:ClearDraw(ev)
    else
      Log.error("[CampaignCom][RandomLotteryComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function RandomLotteryComponent:GetCfgMap()
  local componentId = self:GetComponentCfgId()
  local cfgMap = Cfg.cfg_component_random_lottery({ComponentID = componentId})
  if cfgMap == nil then
    Log.exception("cfg_component_random_lottery 中找不到组件ID:", componentId)
    return nil
  end
  return cfgMap
end

function RandomLotteryComponent:GetFirstCfg()
  local componentId = self:GetComponentCfgId()
  local cfgMap = Cfg.cfg_component_random_lottery({ComponentID = componentId})
  if cfgMap == nil then
    Log.exception("cfg_component_random_lottery 中找不到组件ID:", componentId)
    return nil
  end
  return cfgMap[1]
end

function RandomLotteryComponent:GetCfgMain()
  local componentId = self:GetComponentCfgId()
  local cfg = Cfg.cfg_junior_skin_draw({ComponentID = componentId})
  if cfg == nil then
    Log.exception("cfg_junior_skin_draw 中找不到组件ID:", componentId)
    return nil
  end
  return cfg[1]
end

function RandomLotteryComponent:GetProbablityCfg()
  local componentId = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_junior_skin_draw_probablity({ComponentID = componentId})
  if cfgs == nil then
    Log.exception("cfg_junior_skin_draw_probablity 中找不到组件ID:", componentId)
    return nil
  end
  return cfgs
end

function RandomLotteryComponent:HasRed()
  local cfgMap = self:GetCfgMap()
  if cfgMap == nil then
    return false
  end
  local module = GameGlobal.GetModule(ItemModule)
  for key, value in pairs(cfgMap) do
    if value.CostItemID > 0 then
      local count = module:GetItemCount(value.CostItemID) or 0
      if count > value.OneCostCount then
        return true
      end
    end
  end
  return false
end

function RandomLotteryComponent:HasRewardRed()
  local ComponentInfo = self:ComponentInfo()
  local num = 0
  for key, value in pairs(ComponentInfo.m_draw) do
    num = num + 1
    if value.is_get == true then
      return false
    end
  end
  if num == 0 then
    return false
  end
  return true
end
