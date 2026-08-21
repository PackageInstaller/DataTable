_class("CCampaignPlayerBackPhaseII", ICampaignComponentLocalProcessBase)
CCampaignPlayerBackPhaseII = CCampaignPlayerBackPhaseII

function CCampaignPlayerBackPhaseII:Constructor()
  self._PlayerBackComponent = nil
  self._PlayerBackComponentInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._camQuestComponet = nil
  self._camQuestComponetInfo = nil
  self._buyGiftComponent = nil
  self._buyGiftComponentInfo = nil
  self._personProgress1Component = nil
  self._personProgress1CompInfo = nil
  self._resHelpComponent = nil
  self._resHelpComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignPlayerBackPhaseII:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_BACK_PHASE_II
end

function CCampaignPlayerBackPhaseII:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignPlayerBackPhaseII:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetPlayerBackComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetCamQuestComponent()
  self:_GetBuyGiftComponent()
  self:_GetPersonProgress1Component()
  self:_GetResHelpComponent()
  self:_GetShopComponent()
  self:_GetPower2ItemComponent()
end

function CCampaignPlayerBackPhaseII:_GetPlayerBackComponent()
  self._PlayerBackComponent = self._campaignObj:GetComponent(ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_COMPONENT)
  if not self._PlayerBackComponent then
    return
  end
  self._PlayerBackComponentInfo = self._PlayerBackComponent:ComponentInfo()
end

function CCampaignPlayerBackPhaseII:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:GetComponentInfo()
end

function CCampaignPlayerBackPhaseII:_GetCamQuestComponent()
  self._camQuestComponet = self._campaignObj:GetComponent(ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_QUEST)
  if not self._camQuestComponet then
    return
  end
  self._camQuestComponetInfo = self._camQuestComponet:ComponentInfo()
end

function CCampaignPlayerBackPhaseII:_GetBuyGiftComponent()
  self._buyGiftComponent = self._campaignObj:GetComponent(ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_BUY_GIFT)
  if not self._buyGiftComponent then
    return
  end
  self._buyGiftComponentInfo = self._buyGiftComponent:ComponentInfo()
end

function CCampaignPlayerBackPhaseII:_GetPersonProgress1Component()
  self._personProgress1Component = self._campaignObj:GetComponent(ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_PERSON_PROGRESS)
  if not self._personProgress1Component then
    return
  end
  self._personProgress1CompInfo = self._personProgress1Component:ComponentInfo()
end

function CCampaignPlayerBackPhaseII:_GetResHelpComponent()
  self._resHelpComponent = self._campaignObj:GetComponent(ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_RES_HELP)
  if not self._resHelpComponent then
    return
  end
  self._resHelpComponentInfo = self._resHelpComponent:ComponentInfo()
end

function CCampaignPlayerBackPhaseII:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignPlayerBackPhaseII:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignPlayerBackPhaseII:GetComponent(componentID)
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_COMPONENT == componentID then
    return self._PlayerBackComponent
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_QUEST == componentID then
    return self._camQuestComponet
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_BUY_GIFT == componentID then
    return self._buyGiftComponent
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_PERSON_PROGRESS == componentID then
    return self._personProgress1Component
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_RES_HELP == componentID then
    return self._resHelpComponent
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  return nil
end

function CCampaignPlayerBackPhaseII:GetComponentInfo(componentID)
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_COMPONENT == componentID then
    return self._PlayerBackComponentInfo
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_QUEST == componentID then
    return self._camQuestComponetInfo
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_BUY_GIFT == componentID then
    return self._buyGiftComponentInfo
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_PERSON_PROGRESS == componentID then
    return self._personProgress1CompInfo
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_RES_HELP == componentID then
    self:_GetResHelpComponent()
    return self._resHelpComponentInfo
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignPlayerBackphaseIIComponentID.ECAMPAIGN_BACK_PHASEII_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  return nil
end
