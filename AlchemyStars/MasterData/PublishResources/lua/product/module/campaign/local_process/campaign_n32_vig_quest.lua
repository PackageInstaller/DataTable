_class("CCampaignVigQuest", ICampaignComponentLocalProcessBase)
CCampaignVigQuest = CCampaignVigQuest

function CCampaignVigQuest:Constructor()
  self._turncardComponent = nil
  self._turncardCompInfo = nil
  self._campaignQuestComponent = nil
  self._campaignQuestCompInfo = nil
  self._campaignObj = nil
end

function CCampaignVigQuest:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N32_VIG_QUEST
end

function CCampaignVigQuest:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignVigQuest:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetTurnCardComponent()
  self:_GetCampaignQuestComponent()
end

function CCampaignVigQuest:_GetTurnCardComponent()
  self._turncardComponent = self._campaignObj:GetComponent(ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_TURNCARD)
  if not self._turncardComponent then
    return
  end
  self._turncardCompInfo = self._turncardComponent:ComponentInfo()
end

function CCampaignVigQuest:_GetCampaignQuestComponent()
  self._campaignQuestComponent = self._campaignObj:GetComponent(ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_QUEST)
  if not self._campaignQuestComponent then
    return
  end
  self._campaignQuestCompInfo = self._campaignQuestComponent:ComponentInfo()
end

function CCampaignVigQuest:GetComponent(componentID)
  if ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_TURNCARD == componentID then
    return self._turncardComponent
  end
  if ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_QUEST == componentID then
    return self._campaignQuestComponent
  end
  return nil
end

function CCampaignVigQuest:GetComponentInfo(componentID)
  if ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_TURNCARD == componentID then
    return self._turncardCompInfo
  end
  if ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_QUEST == componentID then
    return self._campaignQuestCompInfo
  end
  return nil
end

function CCampaignVigQuest:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N32_VIG_QUEST)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignVigQuest:GetEntryRedDot()
  return self:TurnCardReddot() or self:CampQuestReddot()
end

function CCampaignVigQuest:TurnCardReddot()
  return self._turncardComponent and self._turncardComponent:HaveRedPoint()
end

function CCampaignVigQuest:CampQuestReddot()
  return self._campaignQuestComponent and self._campaignQuestComponent:HaveRedPoint()
end
