_class("CCampaignN13PerfectPuzzle", ICampaignComponentLocalProcessBase)
CCampaignN13PerfectPuzzle = CCampaignN13PerfectPuzzle

function CCampaignN13PerfectPuzzle:Constructor()
  self._perfectPuzzleComponent = nil
  self._perfectPuzzleComponentInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._personProgressScoreComponent = nil
  self._personProgressScoreCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN13PerfectPuzzle:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE
end

function CCampaignN13PerfectPuzzle:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN13PerfectPuzzle:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetPerfectPuzzleComponent()
  self:_GetQuestComponent()
  self:_GetPersonProgressComponent()
end

function CCampaignN13PerfectPuzzle:_GetPerfectPuzzleComponent()
  self._perfectPuzzleComponent = self._campaignObj:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE)
  if not self._perfectPuzzleComponent then
    return
  end
  self._perfectPuzzleComponentInfo = self._perfectPuzzleComponent:ComponentInfo()
end

function CCampaignN13PerfectPuzzle:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignN13PerfectPuzzle:_GetPersonProgressComponent()
  self._personProgressScoreComponent = self._campaignObj:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
  if not self._personProgressScoreComponent then
    return
  end
  self._personProgressScoreCompInfo = self._personProgressScoreComponent:ComponentInfo()
end

function CCampaignN13PerfectPuzzle:GetComponent(componentID)
  if ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE == componentID then
    return self._perfectPuzzleComponent
  end
  if ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST == componentID then
    return self._questComponent
  end
  if ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS == componentID then
    return self._personProgressScoreComponent
  end
  return nil
end

function CCampaignN13PerfectPuzzle:GetComponentInfo(componentID)
  if ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE == componentID then
    return self._perfectPuzzleComponentInfo
  end
  if ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST == componentID then
    return self._questComponentInfo
  end
  if ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS == componentID then
    return self._personProgressScoreCompInfo
  end
  return nil
end

function CCampaignN13PerfectPuzzle:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN13PerfectPuzzle:GetEntryRedDot()
  return self:PerfectPuzzleReddot()
end

function CCampaignN13PerfectPuzzle:PerfectPuzzleReddot()
  return self._perfectPuzzleComponent and self._perfectPuzzleComponent:HaveRedPoint()
end
