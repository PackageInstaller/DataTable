require("component_base")
_class("AlchemyComponent", ICampaignComponent)
AlchemyComponent = AlchemyComponent

function AlchemyComponent:Constructor()
  self.m_component_info = AlchemyComponentInfo:New()
end

function AlchemyComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = AlchemyComponentInfo:New()
  end
  return self.m_component_info
end

function AlchemyComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function AlchemyComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_ALCHEMY
end

function AlchemyComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function AlchemyComponent:HandleAlchemyMakeup(TT, asyncRes, item_id, num)
  local request = AlchemyComponentMakeupReq:New()
  request.item_id = item_id
  request.num = num
  local response = AlchemyComponentMakeupRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][AlchemyComponent] HandleAlchemyMakeup ret:", asyncRes.m_result)
    return nil
  end
  return asyncRes, response
end

function AlchemyComponent:HandleAlchemyShopSell(TT, asyncRes, items)
  local request = AlchemyComponentSellReq:New()
  request.items = items
  local response = AlchemyComponentSellRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][AlchemyComponent] HandleAlchemyShopSell ret:", asyncRes.m_result)
    return nil
  end
  return response
end

function AlchemyComponent:HandleAlchemyShopBuy(TT, asyncRes, type, buy_id)
  local request = AlchemyComponentBuyReq:New()
  request.type = type
  request.buy_id = buy_id
  local response = AlchemyComponentBuyRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][AlchemyComponent] HandleAlchemyShopBuy ret:", asyncRes.m_result)
    return nil
  end
  if type == EAlchemyShopItemType.EAlchemyShopItemType_TipBuff then
    ComponentInfo.show_tip_buff_id = response.new_id
    ComponentInfo.tip_buff_finish = response.bfinish
  elseif type == EAlchemyShopItemType.EAlchemyShopItemType_ExtraItem then
    ComponentInfo.show_extra_buff_id = response.new_id
    ComponentInfo.extra_buff_finsih = response.bfinish
  end
  return response
end
