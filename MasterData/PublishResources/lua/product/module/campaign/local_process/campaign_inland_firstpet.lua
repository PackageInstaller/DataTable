_class("CCampaignInlandFirstPet", ICampaignComponentLocalProcessBase)
CCampaignInlandFirstPet = CCampaignInlandFirstPet

function CCampaignInlandFirstPet:Constructor()
  self._levelCommonComponet = nil
  self._levelCommonCompInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandFirstPet:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_FIRSTPET
end

function CCampaignInlandFirstPet:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandFirstPet:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLevelCommonComponent()
end

function CCampaignInlandFirstPet:_GetLevelCommonComponent()
  self._levelCommonComponet = self._campaignObj:GetComponent(ECCampaignInlandFirstPetComponentID.Line_MISSION)
  if not self._levelCommonComponet then
    return
  end
  self._levelCommonCompInfo = self._levelCommonComponet:ComponentInfo()
end

function CCampaignInlandFirstPet:GetComponent(componentID)
  if ECCampaignInlandFirstPetComponentID.Line_MISSION == componentID then
    return self._levelCommonComponet
  end
  return nil
end

function CCampaignInlandFirstPet:GetComponentInfo(componentID)
  if ECCampaignInlandFirstPetComponentID.Line_MISSION == componentID then
    return self._levelCommonCompInfo
  end
  return nil
end
