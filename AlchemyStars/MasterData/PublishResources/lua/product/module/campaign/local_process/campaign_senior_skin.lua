require("campaign_component_local_process_base")
_class("CCampaignSeniorSkin", ICampaignComponentLocalProcessBase)
CCampaignSeniorSkin = CCampaignSeniorSkin

function CCampaignSeniorSkin:Constructor()
  self._buyGiftComponent = nil
  self._buyGiftComponentInfo = nil
  self._seniorSkinComponent = nil
  self._seniorSkinComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignSeniorSkin:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN
end

function CCampaignSeniorSkin:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignSeniorSkin:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetBuyGiftComponent()
  self:_GetSeniorSkinComponent()
end

function CCampaignSeniorSkin:_GetBuyGiftComponent()
  self._buyGiftComponent = self._campaignObj:GetComponent(ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT)
  if not self._buyGiftComponent then
    return
  end
  self._buyGiftComponentInfo = self._buyGiftComponent:ComponentInfo()
end

function CCampaignSeniorSkin:_GetSeniorSkinComponent()
  self._seniorSkinComponent = self._campaignObj:GetComponent(ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN)
  if not self._seniorSkinComponent then
    return
  end
  self._seniorSkinComponentInfo = self._seniorSkinComponent:ComponentInfo()
end

function CCampaignSeniorSkin:GetComponent(componentID)
  if ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN == componentID then
    return self._seniorSkinComponent
  end
  if ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT == componentID then
    return self._buyGiftComponent
  end
  return nil
end

function CCampaignSeniorSkin:GetComponentInfo(componentID)
  if ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN == componentID then
    return self._seniorSkinComponentInfo
  end
  if ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT == componentID then
    return self._buyGiftComponentInfo
  end
  return nil
end
