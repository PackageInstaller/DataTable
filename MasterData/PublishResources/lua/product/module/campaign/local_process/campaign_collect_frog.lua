_class("CCampaignCollectFrog", ICampaignComponentLocalProcessBase)
CCampaignCollectFrog = CCampaignCollectFrog

function CCampaignCollectFrog:Constructor()
  self._personProgressScoreComponent = nil
  self._personProgressScoreCompInfo = nil
  self._campaignObj = nil
end

function CCampaignCollectFrog:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_COLLECT_FROG
end

function CCampaignCollectFrog:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignCollectFrog:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetPersonProgressComponent()
end

function CCampaignCollectFrog:_GetPersonProgressComponent()
  self._personProgressScoreComponent = self._campaignObj:GetComponent(ECampaignCollectFrogComponentID.ECAMPAIGN_COLLECT_FROG_PERSON_PROCESS)
  if not self._personProgressScoreComponent then
    return
  end
  self._personProgressScoreCompInfo = self._personProgressScoreComponent:ComponentInfo()
end

function CCampaignCollectFrog:GetComponent(componentID)
  if ECampaignCollectFrogComponentID.ECAMPAIGN_COLLECT_FROG_PERSON_PROCESS == componentID then
    return self._personProgressScoreComponent
  end
  return nil
end

function CCampaignCollectFrog:GetComponentInfo(componentID)
  if ECampaignN13CenterComponentID.ECAMPAIGN_COLLECT_FROG_PERSON_PROCESS == componentID then
    return self._personProgressScoreCompInfo
  end
  return nil
end

function CCampaignCollectFrog:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_COLLECT_FROG)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end
