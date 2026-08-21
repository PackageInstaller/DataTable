require("campaign_component_local_process_base")
_class("CCampaignSeniorSkinCopy", ICampaignComponentLocalProcessBase)
CCampaignSeniorSkinCopy = CCampaignSeniorSkinCopy

function CCampaignSeniorSkinCopy:Constructor()
  self._buyGiftComponent = nil
  self._buyGiftComponentInfo = nil
  self._seniorSkinComponent = nil
  self._seniorSkinComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignSeniorSkinCopy:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN_COPY
end

function CCampaignSeniorSkinCopy:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignSeniorSkinCopy:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetBuyGiftComponent()
  self:_GetSeniorSkinComponent()
end

function CCampaignSeniorSkinCopy:_GetBuyGiftComponent()
  self._buyGiftComponent = self._campaignObj:GetComponent(ECampaignSeniorSkinCopyComponentID.ECAMPAIGN_COPY_BUY_GIFT)
  if not self._buyGiftComponent then
    return
  end
  self._buyGiftComponentInfo = self._buyGiftComponent:ComponentInfo()
end

function CCampaignSeniorSkinCopy:_GetSeniorSkinComponent()
  self._seniorSkinComponent = self._campaignObj:GetComponent(ECampaignSeniorSkinCopyComponentID.ECAMPAIGN_COPY_SENIOR_SKIN)
  if not self._seniorSkinComponent then
    return
  end
  self._seniorSkinComponentInfo = self._seniorSkinComponent:ComponentInfo()
end

function CCampaignSeniorSkinCopy:GetComponent(componentID)
  if ECampaignSeniorSkinCopyComponentID.ECAMPAIGN_COPY_SENIOR_SKIN == componentID then
    return self._seniorSkinComponent
  end
  if ECampaignSeniorSkinCopyComponentID.ECAMPAIGN_COPY_BUY_GIFT == componentID then
    return self._buyGiftComponent
  end
  return nil
end

function CCampaignSeniorSkinCopy:GetComponentInfo(componentID)
  if ECampaignSeniorSkinCopyComponentID.ECAMPAIGN_COPY_SENIOR_SKIN == componentID then
    return self._seniorSkinComponentInfo
  end
  if ECampaignSeniorSkinCopyComponentID.ECAMPAIGN_COPY_BUY_GIFT == componentID then
    return self._buyGiftComponentInfo
  end
  return nil
end
