_class("CCampaignOptionPet", ICampaignComponentLocalProcessBase)
CCampaignOptionPet = CCampaignOptionPet

function CCampaignOptionPet:Constructor()
  self._questComponent = nil
  self._questComponentInfo = nil
  self._personProgressScoreComponent = nil
  self._personProgressScoreCompInfo = nil
  self._campaignObj = nil
end

function CCampaignOptionPet:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_OPTION_PET
end

function CCampaignOptionPet:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignOptionPet:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetQuestComponent()
  self:_GetPersonProgressComponent()
end

function CCampaignOptionPet:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignOptionPet:_GetPersonProgressComponent()
  self._personProgressScoreComponent = self._campaignObj:GetComponent(ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_PERSON_PROCESS)
  if not self._personProgressScoreComponent then
    return
  end
  self._personProgressScoreCompInfo = self._personProgressScoreComponent:ComponentInfo()
end

function CCampaignOptionPet:GetComponent(componentID)
  if ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_QUEST == componentID then
    return self._questComponent
  end
  if ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_PERSON_PROCESS == componentID then
    return self._personProgressScoreComponent
  end
  return nil
end

function CCampaignOptionPet:GetComponentInfo(componentID)
  if ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_QUEST == componentID then
    return self._questComponentInfo
  end
  if ECampaignOptionPetComponentID.ECAMPAIGN_OPTION_PET_PERSON_PROCESS == componentID then
    return self._personProgressScoreCompInfo
  end
  return nil
end

function CCampaignOptionPet:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_OPTION_PET)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignOptionPet:GetEntryRedDot()
  return self:HardLineMissionRedDot() or self:CampQuestReddot()
end

function CCampaignOptionPet:CampQuestReddot()
  return self._questComponent and self._questComponent:HaveRedPoint()
end
