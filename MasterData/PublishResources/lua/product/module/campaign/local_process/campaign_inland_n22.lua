_class("CCampaignCN22", ICampaignComponentLocalProcessBase)
CCampaignCN22 = CCampaignCN22

function CCampaignCN22:Constructor()
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

function CCampaignCN22:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N22
end

function CCampaignCN22:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignCN22:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetSharedStoryComponent()
  self:_GetShopComponent()
  self:_GetDifficultyMissionComponent()
end

function CCampaignCN22:_GetDifficultyMissionComponent()
  self._diffcultyMissionComponent = self._campaignObj:GetComponent(ECampaignCN22ComponentID.ECN22_HEIXIA)
  if not self._diffcultyMissionComponent then
    return
  end
  self._difficultyMissionCompInfo = self._diffcultyMissionComponent:ComponentInfo()
end

function CCampaignCN22:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignCN22ComponentID.ECN22_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignCN22:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignCN22ComponentID.ECN22_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignCN22:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignCN22ComponentID.ECN22_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignCN22:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignCN22ComponentID.ECN22_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignCN22:_GetSharedStoryComponent()
  self._storySharedComponent = self._campaignObj:GetComponent(ECampaignCN22ComponentID.ECN22_SHARED)
  if not self._storySharedComponent then
    return
  end
  self._storySharedComponentInfo = self._storySharedComponent:ComponentInfo()
end

function CCampaignCN22:GetComponent(componentID)
  if ECampaignCN22ComponentID.ECN22_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignCN22ComponentID.ECN22_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignCN22ComponentID.ECN22_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignCN22ComponentID.ECN22_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignCN22ComponentID.ECN22_SHARED == componentID then
    return self._storySharedComponent
  end
  if ECampaignCN22ComponentID.ECN22_HEIXIA == componentID then
    return self._diffcultyMissionComponent
  end
  return nil
end

function CCampaignCN22:GetComponentInfo(componentID)
  if ECampaignCN22ComponentID.ECN22_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignCN22ComponentID.ECN22_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignCN22ComponentID.ECN22_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignCN22ComponentID.ECN22_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignCN22ComponentID.ECN22_SHARED == componentID then
    return self._storySharedComponentInfo
  end
  if ECampaignCN22ComponentID.ECN22_HEIXIA == componentID then
    return self._difficultyMissionCompInfo
  end
  return nil
end

function CCampaignCN22:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_N21)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignCN22:GetEntryRedDot()
  return self:AccumulateLoginReddot() or self:LineMissionRedDot() or self:DifficultyMissionRedDot()
end

function CCampaignCN22:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignCN22:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignCN22:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignCN22:DifficultyMissionRedDot()
  if not self._diffcultyMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._diffcultyMissionComponent:HaveRedPoint()
end
