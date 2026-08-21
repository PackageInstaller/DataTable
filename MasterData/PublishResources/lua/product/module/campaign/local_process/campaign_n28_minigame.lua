_class("CCampaignN28MiniGame", ICampaignComponentLocalProcessBase)
CCampaignN28MiniGame = CCampaignN28MiniGame

function CCampaignN28MiniGame:Constructor()
  self._bounceMissionComponent = nil
  self._bounceMissionComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN28MiniGame:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N28_MINI_GAME
end

function CCampaignN28MiniGame:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN28MiniGame:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetBounceMissionComponent()
end

function CCampaignN28MiniGame:_GetBounceMissionComponent()
  self._bounceMissionComponent = self._campaignObj:GetComponent(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
  if not self._bounceMissionComponent then
    return
  end
  self._bounceMissionComponentInfo = self._bounceMissionComponent:ComponentInfo()
end

function CCampaignN28MiniGame:GetComponent(componentID)
  if ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION == componentID then
    return self._bounceMissionComponent
  end
  return nil
end

function CCampaignN28MiniGame:GetComponentInfo(componentID)
  if ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION == componentID then
    return self._bounceMissionComponentInfo
  end
  return nil
end

function CCampaignN28MiniGame:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N28_MINI_GAME)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end
