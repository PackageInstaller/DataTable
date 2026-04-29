require("component_base")
_class("CollectCardComponent", ICampaignComponent)
CollectCardComponent = CollectCardComponent

function CollectCardComponent:Constructor()
  self.m_component_info = CollectCardComponentInfo:New()
  self.m_receive_card_info = {}
end

function CollectCardComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = CollectCardComponentInfo:New()
  end
  return self.m_component_info
end

function CollectCardComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CollectCardComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COLLECT_CARD
end

function CollectCardComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  if ret then
    self.m_receive_card_info = self.m_component_info.receive_cards
  end
  return ret
end

function CollectCardComponent:HandleTakeRewardReq(TT, asyncRes, reward_id)
  local request = TakeCollectCardRewardReq:New()
  request.reward_id = reward_id
  local response = TakeCollectCardRewardRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS == asyncRes.m_result then
    table.insert(self.m_component_info.received_rewards, reward_id)
  else
    Log.error("[CampaignCom][CollectCardComponent] HandleTakeRewardReq ret:", asyncRes.m_result)
    asyncRes:SetSucc(false)
    return asyncRes, nil
  end
  return asyncRes, response.rewards
end

function CollectCardComponent:HandleDropCardReq(TT, asyncRes, item1, item2)
  local request = DropCardsReq:New()
  request.item1 = item1
  request.item2 = item2
  local response = DropCardsRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS == asyncRes.m_result then
    for key, value in pairs(response.add_cards) do
      if self.m_component_info.card[key] then
        self.m_component_info.card[key] = self.m_component_info.card[key] + value
      else
        self.m_component_info.card[key] = value
      end
    end
  else
    Log.error("[CampaignCom][CollectCardComponent] HandleDropCardReq ret:", asyncRes.m_result)
    asyncRes:SetSucc(false)
    return asyncRes, nil
  end
  return asyncRes, response.add_cards
end

function CollectCardComponent:HandleSendCardReq(TT, asyncRes, pstid, card_id)
  local request = SendCardReq:New()
  request.pstid = pstid
  request.card_id = card_id
  local response = SendCardRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS == asyncRes.m_result then
    self.m_component_info.card[card_id] = self.m_component_info.card[card_id] - 1
    self.m_component_info.send_card_info = response.send_card_info
  else
    Log.error("[CampaignCom][CollectCardComponent] HandleDropCardReq ret:", asyncRes.m_result)
    asyncRes:SetSucc(false)
    return asyncRes, nil
  end
  return asyncRes
end

function CollectCardComponent:HandleClearSendCardInfoReq(TT, asyncRes)
  local request = ClearSendCardInfoReq:New()
  local response = ClearSendCardInfoRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS == asyncRes.m_result then
    self.m_component_info.receive_cards = {}
  else
    Log.error("[CampaignCom][CollectCardComponent] HandleClearSendCardInfoReq ret:", asyncRes.m_result)
    asyncRes:SetSucc(false)
    return asyncRes
  end
  return asyncRes
end

function CollectCardComponent:CampaignComponentPushNotify(notify_data)
  if CollectCardComponentNotifyType.CollectCardComponentNotifyType_InfoChanged == notify_data.m_notify_type then
    local ev = NotifyCollectCardComponentInfoChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnUpdateBaseInfo(ev)
    else
      Log.error("[CampaignCom][CollectCardComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function CollectCardComponent:OnUpdateBaseInfo(ev)
  for key, value in pairs(ev.add_cards) do
    if self.m_component_info.card[key] then
      self.m_component_info.card[key] = self.m_component_info.card[key] + value
    else
      self.m_component_info.card[key] = value
    end
  end
  for key, value in pairs(ev.infos) do
    table.insert(self.m_receive_card_info, value)
  end
end

function CollectCardComponent:GetReceiveCardsInfo()
  return self.m_receive_card_info
end

function CollectCardComponent:ClearReceiveCardsInfo()
  self.m_receive_card_info = {}
end
