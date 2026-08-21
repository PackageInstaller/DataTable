_class("CCampaignCN21", ICampaignComponentLocalProcessBase)
CCampaignCN21 = CCampaignCN21

function CCampaignCN21:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._storySharedComponent = nil
  self._storySharedComponentInfo = nil
  self._diffcultyMissionComponent = nil
  self._difficultyMissionCompInfo = nil
  self._campaignObj = nil
end

function CCampaignCN21:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N21
end

function CCampaignCN21:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignCN21:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetSharedStoryComponent()
  self:_GetShopComponent()
  self:_GetDifficultyMissionComponent()
end

function CCampaignCN21:_GetDifficultyMissionComponent()
  self._diffcultyMissionComponent = self._campaignObj:GetComponent(ECampaignCN21ComponentID.ECN21_HEIXIA)
  if not self._diffcultyMissionComponent then
    return
  end
  self._difficultyMissionCompInfo = self._diffcultyMissionComponent:ComponentInfo()
end

function CCampaignCN21:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignCN21ComponentID.ECN21_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignCN21:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignCN21ComponentID.ECN21_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignCN21:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignCN21ComponentID.ECN21_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignCN21:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignCN21ComponentID.ECN21_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignCN21:_GetSharedStoryComponent()
  self._storySharedComponent = self._campaignObj:GetComponent(ECampaignCN21ComponentID.ECN21_SHARED)
  if not self._storySharedComponent then
    return
  end
  self._storySharedComponentInfo = self._storySharedComponent:ComponentInfo()
end

function CCampaignCN21:GetComponent(componentID)
  if ECampaignCN21ComponentID.ECN21_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignCN21ComponentID.ECN21_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignCN21ComponentID.ECN21_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignCN21ComponentID.ECN21_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignCN21ComponentID.ECN21_SHARED == componentID then
    return self._storySharedComponent
  end
  if ECampaignCN21ComponentID.ECN21_HEIXIA == componentID then
    return self._diffcultyMissionComponent
  end
  return nil
end

function CCampaignCN21:GetComponentInfo(componentID)
  if ECampaignCN21ComponentID.ECN21_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignCN21ComponentID.ECN21_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignCN21ComponentID.ECN21_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignCN21ComponentID.ECN21_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignCN21ComponentID.ECN21_SHARED == componentID then
    return self._storySharedComponentInfo
  end
  if ECampaignCN21ComponentID.ECN21_HEIXIA == componentID then
    return self._difficultyMissionCompInfo
  end
  return nil
end

function CCampaignCN21:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_N21)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignCN21:GetEntryRedDot()
  return self:AccumulateLoginReddot() or self:LineMissionRedDot() or self:DifficultyMissionRedDot()
end

function CCampaignCN21:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignCN21:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignCN21:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignCN21:DifficultyMissionRedDot()
  if not self._diffcultyMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._diffcultyMissionComponent:HaveRedPoint()
end
