_class("ExchangeItemComponent", ICampaignComponent)
ExchangeItemComponent = ExchangeItemComponent

function ExchangeItemComponent:Constructor()
  self.m_component_info = ExchangeItemComponentInfo:New()
end

function ExchangeItemComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = ExchangeItemComponentInfo:New()
  end
  return self.m_component_info
end

function ExchangeItemComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function ExchangeItemComponent:GetItemList()
  return self:ComponentInfo().m_exchange_item_list
end

function ExchangeItemComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_EXCHANGE_ITEM
end

function ExchangeItemComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function ExchangeItemComponent:HandleExchangeItem(TT, asyncRes, a_reward_id, a_exchange_count)
  local request = ExchangeItemComponentExchangeReq:New()
  request.m_exchange_item_id = a_reward_id
  request.m_exchange_count = a_exchange_count
  local response = ExchangeItemComponentExchangeRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][ExchangeItem] HandleExchangeItem ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_exchange_item_list = table.cloneconf(response.m_exchange_info.m_exchange_item_list)
  self:UpdateComponentStep(response.m_step)
  return response.m_rewards
end

function ExchangeItemComponent:Start_HandleExchangeItem(a_reward_id, a_exchange_count, callback)
  local lockName = "ExchangeItemComponent:Start_HandleExchangeItem"
  GameGlobal.UIStateManager():Lock(lockName)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewards = self:HandleExchangeItem(TT, res, a_reward_id, a_exchange_count)
    if callback then
      callback(res, rewards)
    end
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end

function ExchangeItemComponent:GetCostItemIconText()
  local item_id = self:GetCostItemId()
  local cfgItem = Cfg.cfg_item[item_id]
  local icon = cfgItem and cfgItem.Icon
  local count = GameGlobal.GetModule(ItemModule):GetItemCount(item_id)
  return icon, count
end

function ExchangeItemComponent:GetCostItemId(isSpecial)
  local info = self:GetComponentInfo()
  local items = info.m_exchange_item_list
  for _, v in ipairs(items) do
    if isSpecial and v.m_is_special then
      return v.m_cost_item_id
    elseif not isSpecial and not v.m_is_special then
      return v.m_cost_item_id
    end
  end
end

function ExchangeItemComponent:GetExchangeItemList()
  local info = self:GetComponentInfo()
  return info.m_exchange_item_list
end

function ExchangeItemComponent:GetExchangeItem(id)
  local list = self:GetExchangeItemList()
  for i, v in ipairs(list) do
    if v.m_id == id then
      return v
    end
  end
end

function ExchangeItemComponent:GetExchangeItemSpecial(index)
  index = index or 1
  local tb = {}
  local list = self:GetExchangeItemList()
  for i, v in ipairs(list) do
    if v.m_is_special then
      table.insert(tb, v)
    end
  end
  table.sort(tb, function(a, b)
    return a.m_id < b.m_id
  end)
  return tb[index]
end

function ExchangeItemComponent:IsExchangeItemInfinity(itemInfo)
  return itemInfo.m_exchange_limit_count == ExchangeItemCountType.ExchangeItemComponent_Infinity
end

function ExchangeItemComponent:GetCanExchangeCount(itemInfo, noLimitCount)
  local Infinity = self:IsExchangeItemInfinity(itemInfo)
  return Infinity and noLimitCount or itemInfo.m_can_exchange_count
end

function ExchangeItemComponent:IsExchangeItemSoldout(itemInfo)
  local Infinity = self:IsExchangeItemInfinity(itemInfo)
  return not Infinity and itemInfo.m_can_exchange_count == 0
end
