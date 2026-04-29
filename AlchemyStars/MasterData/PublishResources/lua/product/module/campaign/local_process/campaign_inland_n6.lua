_class("CCampaignCN6", ICampaignComponentLocalProcessBase)
CCampaignCN6 = CCampaignCN6

function CCampaignCN6:Constructor()
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
  self._smeltItemComponent = nil
  self._smeltItemCompInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._personProgressScoreComponent = nil
  self._personProgressScoreCompInfo = nil
  self._diffcultyMissionComponent = nil
  self._difficultyMissionCompInfo = nil
  self._campaignObj = nil
end

function CCampaignCN6:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N26
end

function CCampaignCN6:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignCN6:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetDifficultMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetShopComponent()
  self:_GetSharedStoryComponent()
  self:_GetSmeltItemComponent()
  self:_GetQuestComponent()
  self:_GetPersonProgressComponent()
  self:_GetDifficultyMissionComponent()
end

function CCampaignCN6:_GetDifficultyMissionComponent()
  self._diffcultyMissionComponent = self._campaignObj:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA)
  if not self._diffcultyMissionComponent then
    return
  end
  self._difficultyMissionCompInfo = self._diffcultyMissionComponent:ComponentInfo()
end

function CCampaignCN6:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignCN6:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignCN6:_GetDifficultMissionComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignCN6:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignCN6:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignCN6:_GetSharedStoryComponent()
  self._storySharedComponent = self._campaignObj:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_SHARED)
  if not self._storySharedComponent then
    return
  end
  self._storySharedComponentInfo = self._storySharedComponent:ComponentInfo()
end

function CCampaignCN6:_GetSmeltItemComponent()
  self._smeltItemComponent = self._campaignObj:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_SMELTITEM)
  if not self._smeltItemComponent then
    return
  end
  self._smeltItemCompInfo = self._smeltItemComponent:ComponentInfo()
end

function CCampaignCN6:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignCN6:_GetPersonProgressComponent()
  self._personProgressScoreComponent = self._campaignObj:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_PERSON_PROCESS)
  if not self._personProgressScoreComponent then
    return
  end
  self._personProgressScoreCompInfo = self._personProgressScoreComponent:ComponentInfo()
end

function CCampaignCN6:GetComponent(componentID)
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION == componentID then
    return self._levelHardComponent
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_SHARED == componentID then
    return self._storySharedComponent
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_SMELTITEM == componentID then
    return self._smeltItemComponent
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_QUEST == componentID then
    return self._questComponent
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_PERSON_PROCESS == componentID then
    return self._personProgressScoreComponent
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA == componentID then
    return self._diffcultyMissionComponent
  end
  return nil
end

function CCampaignCN6:GetComponentInfo(componentID)
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_SHARED == componentID then
    return self._storySharedComponentInfo
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_SMELTITEM == componentID then
    return self._smeltItemCompInfo
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_QUEST == componentID then
    return self._questComponentInfo
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_PERSON_PROCESS == componentID then
    return self._personProgressScoreCompInfo
  end
  if ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA == componentID then
    return self._difficultyMissionCompInfo
  end
  return nil
end

function CCampaignCN6:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_N6)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignCN6:GetEntryRedDot()
  return self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:LineMissionRedDot() or self:DifficultyMissionRedDot()
end

function CCampaignCN6:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignCN6:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignCN6:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignCN6:HardLineMissionRedDot()
  if not self._levelHardComponent:ComponentIsOpen() then
    return false
  end
  return self._levelHardComponent:HaveRedPoint()
end

function CCampaignCN6:DifficultyMissionRedDot()
  if not self._diffcultyMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._diffcultyMissionComponent:HaveRedPoint()
end
