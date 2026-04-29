_class("CCampaignN28", ICampaignComponentLocalProcessBase)
CCampaignN28 = CCampaignN28

function CCampaignN28:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._levelHardComponent = nil
  self._levelHardCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._campaignAvgStoryComponent = nil
  self._avgStoryComponentClientInfo = nil
  self._campaignObj = nil
end

function CCampaignN28:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N28
end

function CCampaignN28:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN28:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetLineMissionComponent()
  self:_GetDifficultMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetShopComponent()
  self:_GetAvgStoryComponent()
end

function CCampaignN28:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN28:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_FIRST_MEET)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN28:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN28:_GetDifficultMissionComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_DIFFICULT_MISSION)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN28:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN28:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN28:_GetAvgStoryComponent()
  self._campaignAvgStoryComponent = self._campaignObj:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_AVG_PHASE_2)
  if not self._campaignAvgStoryComponent then
    return
  end
  self._avgStoryComponentClientInfo = self._campaignAvgStoryComponent:ComponentInfo()
end

function CCampaignN28:GetComponent(componentID)
  if ECampaignN28ComponentID.ECAMPAIGN_N28_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_FIRST_MEET == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_DIFFICULT_MISSION == componentID then
    return self._levelHardComponent
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_AVG_PHASE_2 == componentID then
    return self._campaignAvgStoryComponent
  end
  return nil
end

function CCampaignN28:GetComponentInfo(componentID)
  if ECampaignN28ComponentID.ECAMPAIGN_N28_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_FIRST_MEET == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_DIFFICULT_MISSION == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignN28ComponentID.ECAMPAIGN_N28_AVG_PHASE_2 == componentID then
    return self._avgStoryComponentClientInfo
  end
  return nil
end

function CCampaignN28:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N28)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN28:GetEntryRedDot()
  return self:GetFixMissionRedDot() or self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:LineMissionRedDot()
end

function CCampaignN28:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN28:GetFixMissionRedDot()
  if not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  return self._fixTeamComponent:HaveRedPoint()
end

function CCampaignN28:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN28:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN28:HardLineMissionRedDot()
  if not self._levelHardComponent:ComponentIsOpen() then
    return false
  end
  return self._levelHardComponent:HaveRedPoint()
end
