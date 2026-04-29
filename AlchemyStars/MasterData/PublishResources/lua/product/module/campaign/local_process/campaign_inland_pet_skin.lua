_class("CCampaignPetSkin", ICampaignComponentLocalProcessBase)
CCampaignPetSkin = CCampaignPetSkin

function CCampaignPetSkin:Constructor()
  self._randomLotteryComponent = nil
  self._randomLotteryCompInfo = nil
  self._buyGiftComponent = nil
  self._buyGiftComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._campaignObj = nil
end

function CCampaignPetSkin:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_PET_SKIN
end

function CCampaignPetSkin:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignPetSkin:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetRandomLotteryComponent()
  self:_GetBuyGiftComponent()
  self:_GetPower2ItemComponent()
end

function CCampaignPetSkin:_GetRandomLotteryComponent()
  self._randomLotteryComponent = self._campaignObj:GetComponent(ECampaignPetSkinComponentID.RANDOMLOTTERY)
  if not self._randomLotteryComponent then
    return
  end
  self._randomLotteryCompInfo = self._randomLotteryComponent:ComponentInfo()
end

function CCampaignPetSkin:_GetBuyGiftComponent()
  self._buyGiftComponent = self._campaignObj:GetComponent(ECampaignPetSkinComponentID.BUYGIFT)
  if not self._buyGiftComponent then
    return
  end
  self._buyGiftComponentInfo = self._buyGiftComponent:ComponentInfo()
end

function CCampaignPetSkin:_GetPower2ItemComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignPetSkinComponentID.SHOPEXCHANGE)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignPetSkin:GetComponent(componentID)
  if ECampaignPetSkinComponentID.RANDOMLOTTERY == componentID then
    return self._randomLotteryComponent
  end
  if ECampaignPetSkinComponentID.BUYGIFT == componentID then
    return self._buyGiftComponent
  end
  if ECampaignPetSkinComponentID.SHOPEXCHANGE == componentID then
    return self._powerShopComponent
  end
  return nil
end

function CCampaignPetSkin:GetComponentInfo(componentID)
  if ECampaignPetSkinComponentID.RANDOMLOTTERY == componentID then
    return self._randomLotteryCompInfo
  end
  if ECampaignPetSkinComponentID.BUYGIFT == componentID then
    return self._buyGiftComponentInfo
  end
  if ECampaignPetSkinComponentID.SHOPEXCHANGE == componentID then
    return self._powerShopCompInfo
  end
  return nil
end

function CCampaignPetSkin:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_PET_SKIN)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end
