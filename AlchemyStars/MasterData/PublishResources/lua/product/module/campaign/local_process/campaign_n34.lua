_class("CCampaignN34", ICampaignComponentLocalProcessBase)
CCampaignN34 = CCampaignN34

function CCampaignN34:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._surveyComponent = nil
  self._surveyComponentInfo = nil
  self._dispatchComponent = nil
  self._dispatchComponentInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN34:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N34
end

function CCampaignN34:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN34:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetPower2ItemComponent()
  self:_GetSurveyComponent()
  self:_GetDispatchComponent()
  self:_GetQuestComponent()
end

function CCampaignN34:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN34:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN34:_GetSurveyComponent()
  self._surveyComponent = self._campaignObj:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY)
  if not self._surveyComponent then
    return
  end
  self._surveyComponentInfo = self._surveyComponent:ComponentInfo()
end

function CCampaignN34:_GetDispatchComponent()
  self._dispatchComponent = self._campaignObj:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH)
  if not self._dispatchComponent then
    return
  end
  self._dispatchComponentInfo = self._dispatchComponent:ComponentInfo()
end

function CCampaignN34:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignN34:GetComponent(componentID)
  if ECampaignN34ComponentID.ECAMPAIGN_N34_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN34ComponentID.ECAMPAIGN_N34_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY == componentID then
    return self._surveyComponent
  end
  if ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH == componentID then
    return self._dispatchComponent
  end
  if ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST == componentID then
    return self._questComponent
  end
  return nil
end

function CCampaignN34:GetComponentInfo(componentID)
  if ECampaignN34ComponentID.ECAMPAIGN_N34_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN34ComponentID.ECAMPAIGN_N34_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN34ComponentID.ECAMPAIGN_N34_SURVEY == componentID then
    return self._surveyComponentInfo
  end
  if ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH == componentID then
    return self._dispatchComponentInfo
  end
  if ECampaignN34ComponentID.ECAMPAIGN_N34_QUEST == componentID then
    return self._questComponentInfo
  end
  return nil
end

function CCampaignN34:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N34)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN34:GetEntryRedDot()
  return self:AccumulateLoginReddot() or self:SurveyReddot() or self:DispatchReddot() or self:QuestReddot()
end

function CCampaignN34:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN34:SurveyReddot()
  return self._surveyComponent and self._surveyComponent:HaveRedPoint()
end

function CCampaignN34:DispatchReddot()
  return self._dispatchComponent and self._dispatchComponent:HaveRedPoint()
end

function CCampaignN34:QuestReddot()
  return self._questComponent and self._questComponent:HaveRedPoint()
end

function CCampaignN34:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end
