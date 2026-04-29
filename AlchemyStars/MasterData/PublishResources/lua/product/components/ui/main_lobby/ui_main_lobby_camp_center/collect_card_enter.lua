require("main_lobby_center_camp_data")
_class("CollectCardEnter", MainLobbyCenterCampData)
CollectCardEnter = CollectCardEnter

function CollectCardEnter:LoadData(TT)
  if UICollectCardContent.CheckLocalDB_Enter_WebView() then
    return
  end
  if self:CheckComIsOpen() then
    return
  end
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_COLLECT_CARD, ECampaignCollectCardComponentID.COLLECT_CARD, ECampaignCollectCardComponentID.QUEST)
  local localProcess = self._campaign:GetLocalProcess()
  self._cardCom = localProcess:GetComponent(ECampaignCollectCardComponentID.COLLECT_CARD)
  self._cardComInfo = localProcess:GetComponentInfo(ECampaignCollectCardComponentID.COLLECT_CARD)
  if self._cardCom then
    self._cardCfgID = self._cardCom:GetComponentCfgId()
  end
  self._questCom = localProcess:GetComponent(ECampaignCollectCardComponentID.QUEST)
  self._questComInfo = localProcess:GetComponentInfo(ECampaignCollectCardComponentID.QUEST)
end

function CollectCardEnter:CheckComIsOpen()
  local btnKey = self._cfg.BtnKey
  local cfg = Cfg.cfg_main_side_enter_btn[btnKey]
  local campType = cfg.CampaignType
  local campID = cfg.CampaignId
  local campModule = GameGlobal.GetModule(CampaignModule)
  local sampleInfo
  if campID then
    sampleInfo = campModule:GetReviewCampaignSampleByCampaignId(campID)
  else
    sampleInfo = campModule:GetSampleByType(campType)
  end
  local questComOpen = false
  if self._questCom and sampleInfo then
    questComOpen = sampleInfo.m_is_component_open >> ECampaignCollectCardComponentID.QUEST & 1 == 1
  end
  if questComOpen then
    return true
  end
  return false
end

function CollectCardEnter:CheckRed()
  local baseRed = self.super.CheckRed(self)
  local redPlatform = self:CheckPlatformRed()
  if baseRed == 1 or redPlatform == 1 then
    return 1
  end
  return 0
end

function CollectCardEnter:CheckPlatformRed()
  if UICollectCardContent.CheckLocalDB_Enter_WebView() then
    return 0
  end
  if self:CheckComIsOpen() then
    return 0
  end
  if not self._cardCom then
    return 0
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
  if isAllCollected then
    return 1
  end
  return 0
end
