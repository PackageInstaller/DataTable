_class("CCampaignCN9", ICampaignComponentLocalProcessBase)
CCampaignCN9 = CCampaignCN9

function CCampaignCN9:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._levelHardComponent = nil
  self._levelHardCompInfo = nil
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

function CCampaignCN9:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N9
end

function CCampaignCN9:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignCN9:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetDifficultMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetSharedStoryComponent()
  self:_GetShopComponent()
  self:_GetSharedStoryComponent()
  self:_GetDifficultyMissionComponent()
end

function CCampaignCN9:_GetDifficultyMissionComponent()
  self._diffcultyMissionComponent = self._campaignObj:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA)
  if not self._diffcultyMissionComponent then
    return
  end
  self._difficultyMissionCompInfo = self._diffcultyMissionComponent:ComponentInfo()
end

function CCampaignCN9:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignCN9:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignCN9:_GetDifficultMissionComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignCN9:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignCN9:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignCN9:_GetSharedStoryComponent()
  self._storySharedComponent = self._campaignObj:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_SHARED)
  if not self._storySharedComponent then
    return
  end
  self._storySharedComponentInfo = self._storySharedComponent:ComponentInfo()
end

function CCampaignCN9:GetComponent(componentID)
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION == componentID then
    return self._levelHardComponent
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_SHARED == componentID then
    return self._storySharedComponent
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA == componentID then
    return self._diffcultyMissionComponent
  end
  return nil
end

function CCampaignCN9:GetComponentInfo(componentID)
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_SHARED == componentID then
    return self._storySharedComponentInfo
  end
  if ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA == componentID then
    return self._difficultyMissionCompInfo
  end
  return nil
end

function CCampaignCN9:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_N9)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignCN9:GetEntryRedDot()
  return self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:LineMissionRedDot() or self:DifficultyMissionRedDot()
end

function CCampaignCN9:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignCN9:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignCN9:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignCN9:HardLineMissionRedDot()
  if not self._levelHardComponent:ComponentIsOpen() then
    return false
  end
  return self._levelHardComponent:HaveRedPoint()
end

function CCampaignCN9:DifficultyMissionRedDot()
  if not self._diffcultyMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._diffcultyMissionComponent:HaveRedPoint()
end
