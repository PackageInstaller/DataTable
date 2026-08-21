_class("CCampaignN27MiniGame", ICampaignComponentLocalProcessBase)
CCampaignN27MiniGame = CCampaignN27MiniGame

function CCampaignN27MiniGame:Constructor()
  self._questComponent = nil
  self._questComponentInfo = nil
  self._mailComponent = nil
  self._mailComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN27MiniGame:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N27_MINI_GAME
end

function CCampaignN27MiniGame:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN27MiniGame:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetQuestComponent()
  self:_GetMailComponent()
end

function CCampaignN27MiniGame:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignN27MiniGameComponentID.QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignN27MiniGame:_GetMailComponent()
  self._mailComponent = self._campaignObj:GetComponent(ECampaignN27MiniGameComponentID.MINI_MAIL)
  if not self._mailComponent then
    return
  end
  self._mailComponentInfo = self._mailComponent:ComponentInfo()
end

function CCampaignN27MiniGame:GetComponent(componentID)
  if ECampaignN27MiniGameComponentID.QUEST == componentID then
    return self._questComponent
  end
  if ECampaignN27MiniGameComponentID.MINI_MAIL == componentID then
    return self._mailComponent
  end
  return nil
end

function CCampaignN27MiniGame:GetComponentInfo(componentID)
  if ECampaignN27MiniGameComponentID.QUEST == componentID then
    return self._questComponentInfo
  end
  if ECampaignN27MiniGameComponentID.MINI_MAIL == componentID then
    return self._mailComponentInfo
  end
  return nil
end

function CCampaignN27MiniGame:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N27_MINI_GAME)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end
