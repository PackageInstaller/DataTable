_class("CCampaignInlandSailing", ICampaignComponentLocalProcessBase)
CCampaignInlandSailing = CCampaignInlandSailing

function CCampaignInlandSailing:Constructor()
  self._buyGiftComponent = nil
  self._buyGiftComponentInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandSailing:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_SAILING
end

function CCampaignInlandSailing:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandSailing:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetBuyGiftComponent()
  self:_GetQuestComponent()
end

function CCampaignInlandSailing:_GetBuyGiftComponent()
  self._buyGiftComponent = self._campaignObj:GetComponent(ECCampaignInlandSailingComponentID.BUY_GIFT)
  if not self._buyGiftComponent then
    return
  end
  self._buyGiftComponentInfo = self._buyGiftComponent:ComponentInfo()
end

function CCampaignInlandSailing:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECCampaignInlandSailingComponentID.QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignInlandSailing:GetComponent(componentID)
  if ECCampaignInlandSailingComponentID.BUY_GIFT == componentID then
    return self._buyGiftComponent
  end
  if ECCampaignInlandSailingComponentID.QUEST == componentID then
    return self._questComponent
  end
  return nil
end

function CCampaignInlandSailing:GetComponentInfo(componentID)
  if ECCampaignInlandSailingComponentID.BUY_GIFT == componentID then
    return self._buyGiftComponentInfo
  end
  if ECCampaignInlandSailingComponentID.QUEST == componentID then
    return self._questComponentInfo
  end
  return nil
end
