_class("CCampaignFishGame", ICampaignComponentLocalProcessBase)
CCampaignFishGame = CCampaignFishGame

function CCampaignFishGame:Constructor()
  self._FishingComponent = nil
  self._FishingComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignFishGame:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_FISH_GAME
end

function CCampaignFishGame:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignFishGame:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetFishingComponent()
end

function CCampaignFishGame:_GetFishingComponent()
  self._FishingComponent = self._campaignObj:GetComponent(ECampaignFishGameComponentID.ECAMPAIGN_FISH_GAME)
  if not self._FishingComponent then
    return
  end
  self._FishingComponentInfo = self._FishingComponent:ComponentInfo()
end

function CCampaignFishGame:GetComponent(componentID)
  if ECampaignFishGameComponentID.ECAMPAIGN_FISH_GAME == componentID then
    return self._FishingComponent
  end
  return nil
end

function CCampaignFishGame:GetComponentInfo(componentID)
  if ECampaignFishGameComponentID.ECAMPAIGN_FISH_GAME == componentID then
    return self._FishingComponentInfo
  end
  return nil
end

function CCampaignFishGame:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_FISH_GAME)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignFishGame:GetEntryRedDot()
  return self:CampFishReddot()
end

function CCampaignFishGame:CampFishReddot()
  return self._FishingComponent and self._FishingComponent:HaveRedPoint()
end
