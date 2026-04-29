_class("CCampaignPlayerBack", ICampaignComponentLocalProcessBase)
CCampaignPlayerBack = CCampaignPlayerBack

function CCampaignPlayerBack:Constructor()
  self._PlayerBackComponent = nil
  self._PlayerBackComponentInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._camQuestComponet = nil
  self._camQuestComponetInfo = nil
  self._buyGiftComponent = nil
  self._buyGiftComponentInfo = nil
  self._buyShopComponent = nil
  self._buyShopComponentInfo = nil
  self._personProgress1Component = nil
  self._personProgress1CompInfo = nil
  self._resHelpComponent = nil
  self._resHelpComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignPlayerBack:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_BACK
end

function CCampaignPlayerBack:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignPlayerBack:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetPlayerBackComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetCamQuestComponent()
  self:_GetBuyGiftComponent()
  self:_GetPersonProgress1Component()
  self:_GetResHelpComponent()
end

function CCampaignPlayerBack:_GetPlayerBackComponent()
  self._PlayerBackComponent = self._campaignObj:GetComponent(ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_COMPONENT)
  if not self._PlayerBackComponent then
    return
  end
  self._PlayerBackComponentInfo = self._PlayerBackComponent:ComponentInfo()
end

function CCampaignPlayerBack:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:GetComponentInfo()
end

function CCampaignPlayerBack:_GetCamQuestComponent()
  self._camQuestComponet = self._campaignObj:GetComponent(ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_QUEST)
  if not self._camQuestComponet then
    return
  end
  self._camQuestComponetInfo = self._camQuestComponet:ComponentInfo()
end

function CCampaignPlayerBack:_GetBuyGiftComponent()
  self._buyGiftComponent = self._campaignObj:GetComponent(ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_BUY_GIFT)
  if not self._buyGiftComponent then
    return
  end
  self._buyGiftComponentInfo = self._buyGiftComponent:ComponentInfo()
end

function CCampaignPlayerBack:_GetPersonProgress1Component()
  self._personProgress1Component = self._campaignObj:GetComponent(ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_PERSON_PROGRESS)
  if not self._personProgress1Component then
    return
  end
  self._personProgress1CompInfo = self._personProgress1Component:ComponentInfo()
end

function CCampaignPlayerBack:_GetResHelpComponent()
  self._resHelpComponent = self._campaignObj:GetComponent(ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_RES_HELP)
  if not self._resHelpComponent then
    return
  end
  self._resHelpComponentInfo = self._resHelpComponent:ComponentInfo()
end

function CCampaignPlayerBack:_GetBuyShopComponent()
  self._buyShopComponent = self._campaignObj:GetComponent(ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_PHASEII_POWER2ITEM)
  if not self._buyShopComponent then
    return
  end
  self._buyShopComponentInfo = self._buyShopComponent:ComponentInfo()
end

function CCampaignPlayerBack:GetComponent(componentID)
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_COMPONENT == componentID then
    return self._PlayerBackComponent
  end
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_QUEST == componentID then
    return self._camQuestComponet
  end
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_BUY_GIFT == componentID then
    return self._buyGiftComponent
  end
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_PERSON_PROGRESS == componentID then
    return self._personProgress1Component
  end
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_RES_HELP == componentID then
    return self._resHelpComponent
  end
  return nil
end

function CCampaignPlayerBack:GetComponentInfo(componentID)
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_COMPONENT == componentID then
    return self._PlayerBackComponentInfo
  end
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_QUEST == componentID then
    return self._camQuestComponetInfo
  end
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_BUY_GIFT == componentID then
    return self._buyGiftComponentInfo
  end
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_PERSON_PROGRESS == componentID then
    return self._personProgress1CompInfo
  end
  if ECampaignPlayerBackComponentID.ECAMPAIGN_BACK_RES_HELP == componentID then
    return self._resHelpComponentInfo
  end
  return nil
end
