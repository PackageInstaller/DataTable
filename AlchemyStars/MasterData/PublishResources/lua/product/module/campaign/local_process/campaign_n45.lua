_class("CCampaignN45", ICampaignComponentLocalProcessBase)
CCampaignN45 = CCampaignN45

function CCampaignN45:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._diffcultyMissionComponent = nil
  self._difficultyMissionCompInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN45:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N45
end

function CCampaignN45:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN45:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetShopComponent()
  self:_GetDifficultyMissionComponent()
  self:_GetQuestComponent()
end

function CCampaignN45:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignN45ComponentID.ECAMPAIGN_N45_QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignN45:_GetDifficultyMissionComponent()
  self._diffcultyMissionComponent = self._campaignObj:GetComponent(ECampaignN45ComponentID.ECAMPAIGN_N45_HEIXIA)
  if not self._diffcultyMissionComponent then
    return
  end
  self._difficultyMissionCompInfo = self._diffcultyMissionComponent:ComponentInfo()
end

function CCampaignN45:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN45ComponentID.ECAMPAIGN_N45_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN45:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN45ComponentID.ECAMPAIGN_N45_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN45:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN45ComponentID.ECAMPAIGN_N45_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN45:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN45ComponentID.ECAMPAIGN_N45_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN45:GetComponent(componentID)
  if ECampaignN45ComponentID.ECAMPAIGN_N45_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN45ComponentID.ECAMPAIGN_N45_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN45ComponentID.ECAMPAIGN_N45_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN45ComponentID.ECAMPAIGN_N45_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignN45ComponentID.ECAMPAIGN_N45_HEIXIA == componentID then
    return self._diffcultyMissionComponent
  end
  if ECampaignCN16ComponentID.ECAMPAIGN_N16_QUEST == componentID then
    return self.CampaignQuestComponent
  end
  return nil
end

function CCampaignN45:GetComponentInfo(componentID)
  if ECampaignN45ComponentID.ECAMPAIGN_N45_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN45ComponentID.ECAMPAIGN_N45_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN45ComponentID.ECAMPAIGN_N45_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN45ComponentID.ECAMPAIGN_N45_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignN45ComponentID.ECAMPAIGN_N45_HEIXIA == componentID then
    return self._difficultyMissionCompInfo
  end
  if ECampaignCN16ComponentID.ECAMPAIGN_N16_QUEST == componentID then
    return self._questComponentInfo
  end
  return nil
end

function CCampaignN45:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N45)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN45:GetEntryRedDot()
  return self:AccumulateLoginReddot() or self:LineMissionRedDot() or self:DifficultyMissionRedDot() or self:CampQuestReddot()
end

function CCampaignN45:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN45:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN45:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN45:DifficultyMissionRedDot()
  if not self._diffcultyMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._diffcultyMissionComponent:HaveRedPoint()
end

function CCampaignOptionPet:CampQuestReddot()
  return self._questComponent and self._questComponent:HaveRedPoint()
end
