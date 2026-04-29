require("ui_side_enter_item_campaign")
_class("UISideEnterItem_Collect_Card", UISideEnterItem_Campaign)
UISideEnterItem_Collect_Card = UISideEnterItem_Collect_Card

function UISideEnterItem_Collect_Card:_LoadCampaign(TT)
  local campaignType, campaignId = self._btnCfg.CampaignType, self._btnCfg.CampaignId
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityHelper.LoadCampaign(TT, res, campaignType, campaignId)
  local localProcess = self._campaign:GetLocalProcess()
  self._cardCom = localProcess:GetComponent(ECampaignCollectCardComponentID.COLLECT_CARD)
  self._cardComInfo = localProcess:GetComponentInfo(ECampaignCollectCardComponentID.COLLECT_CARD)
  if self._cardCom then
    self._cardCfgID = self._cardCom:GetComponentCfgId()
  end
  self._questCom = localProcess:GetComponent(ECampaignCollectCardComponentID.QUEST)
  self._questComInfo = localProcess:GetComponentInfo(ECampaignCollectCardComponentID.QUEST)
end

function UISideEnterItem_Collect_Card:_CalcRed()
  local questRed = false
  if self._questCom then
    questRed = self._questCom:HaveRedPoint()
  end
  local cardRed = false
  if self._cardCom then
    cardRed = self._cardCom:HaveRedPoint()
  end
  local normalRed = questRed or cardRed
  local specialRed = self:CollectCardRed()
  if normalRed or specialRed then
    return 1
  end
  return 0
end

function UISideEnterItem_Collect_Card:CollectCardRed()
  if UICollectCardContent.CheckLocalDB_Enter_WebView() then
    return false
  end
  if self:CheckComIsOpen() then
    return false
  end
  if self:CheckCardsAllCollected() then
    return true
  end
  return false
end

function UISideEnterItem_Collect_Card:CheckCardsAllCollected()
  if not self._cardCom then
    return false
  end
  local cards = self._cardComInfo.card
  local cfgs = Cfg.cfg_component_collect_card_reward({
    ComponentID = self._cardCfgID,
    RewardType = 2
  })
  local cfg = cfgs[1]
  local cardList = cfg.CardList
  local isAllCollected = true
  for key, value in pairs(cardList) do
    if cards[value] then
    else
      isAllCollected = false
      break
    end
  end
  return isAllCollected
end

function UISideEnterItem_Collect_Card:CheckComIsOpen()
  local questComOpen = false
  if self._questCom then
    local sampleInfo = self:GetSampleInfo()
    if sampleInfo then
      questComOpen = sampleInfo.m_is_component_open >> ECampaignCollectCardComponentID.QUEST & 1 == 1
    end
  end
  if questComOpen then
    return true
  end
  return false
end

function UISideEnterItem_Collect_Card:GetSampleInfo()
  local campType = self._campaign._type
  local campID = self._campaign._id
  local campModule = GameGlobal.GetModule(CampaignModule)
  local sampleInfo
  if campID then
    sampleInfo = campModule:GetReviewCampaignSampleByCampaignId(campID)
  else
    sampleInfo = campModule:GetSampleByType(campType)
  end
  return sampleInfo
end
