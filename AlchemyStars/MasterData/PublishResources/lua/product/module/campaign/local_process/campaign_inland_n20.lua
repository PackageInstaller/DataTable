_class("CCampaignCN20", ICampaignComponentLocalProcessBase)
CCampaignCN20 = CCampaignCN20

function CCampaignCN20:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._linetalentComponet = nil
  self._linetalentComponetInfo = nil
  self._talentTreeComponet = nil
  self._talentTreeCompInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._actionPointComponent = nil
  self._actionPointCompInfo = nil
  self._alchemyComponent = nil
  self._alchemyCompInfo = nil
  self._personProgressComponent = nil
  self._personProgressCompInfo = nil
  self._storySharedComponent = nil
  self._storySharedComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignCN20:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N20
end

function CCampaignCN20:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignCN20:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetLineTalentTreeComponent()
  self:_GetTalentTreeComponent()
  self:_GetShopComponent()
  self:_GetPower2ItemComponent()
  self:_GetActionPointComponent()
  self:_GetAlchemyComponent()
  self:_GetPersonProgressComponent()
  self:_GetSharedStoryComponent()
end

function CCampaignCN20:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignCN20ComponentID.ECN20_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignCN20:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignCN20ComponentID.ECN20_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignCN20:_GetLineTalentTreeComponent()
  self._linetalentComponet = self._campaignObj:GetComponent(ECampaignCN20ComponentID.ECN20_LINE_MISSION_TALEN)
  if not self._linetalentComponet then
    return
  end
  self._linetalentComponetInfo = self._linetalentComponet:ComponentInfo()
end

function CCampaignCN20:_GetTalentTreeComponent()
  self._talentTreeComponet = self._campaignObj:GetComponent(ECampaignCN20ComponentID.ECN20_TALENT_TREE)
  if not self._talentTreeComponet then
    return
  end
  self._talentTreeCompInfo = self._talentTreeComponet:ComponentInfo()
end

function CCampaignCN20:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignCN20ComponentID.ECN20_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignCN20:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignCN20ComponentID.ECN20_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignCN20:_GetActionPointComponent()
  self._actionPointComponent = self._campaignObj:GetComponent(ECampaignCN20ComponentID.ECN20_ACTION_POINT)
  if not self._actionPointComponent then
    return
  end
  self._actionPointCompInfo = self._actionPointComponent:ComponentInfo()
end

function CCampaignCN20:_GetAlchemyComponent()
  self._alchemyComponent = self._campaignObj:GetComponent(ECampaignCN20ComponentID.ECN20_ALCHEMY)
  if not self._alchemyComponent then
    return
  end
  self._alchemyCompInfo = self._alchemyComponent:ComponentInfo()
end

function CCampaignCN20:_GetPersonProgressComponent()
  self._personProgressComponent = self._campaignObj:GetComponent(ECampaignCN20ComponentID.ECN20_PERSON_PROGRESS)
  if not self._personProgressComponent then
    return
  end
  self._personProgressCompInfo = self._personProgressComponent:ComponentInfo()
end

function CCampaignCN20:_GetSharedStoryComponent()
  self._storySharedComponent = self._campaignObj:GetComponent(ECampaignCN20ComponentID.ECN20_SHARED)
  if not self._storySharedComponent then
    return
  end
  self._storySharedComponentInfo = self._storySharedComponent:ComponentInfo()
end

function CCampaignCN20:GetComponent(componentID)
  if ECampaignCN20ComponentID.ECN20_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignCN20ComponentID.ECN20_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignCN20ComponentID.ECN20_LINE_MISSION_TALEN == componentID then
    return self._linetalentComponet
  end
  if ECampaignCN20ComponentID.ECN20_TALENT_TREE == componentID then
    return self._talentTreeComponet
  end
  if ECampaignCN20ComponentID.ECN20_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignCN20ComponentID.ECN20_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignCN20ComponentID.ECN20_ACTION_POINT == componentID then
    return self._actionPointComponent
  end
  if ECampaignCN20ComponentID.ECN20_ALCHEMY == componentID then
    return self._alchemyComponent
  end
  if ECampaignCN20ComponentID.ECN20_PERSON_PROGRESS == componentID then
    return self._personProgressComponent
  end
  if ECampaignCN20ComponentID.ECN20_SHARED == componentID then
    return self._storySharedComponent
  end
  return nil
end

function CCampaignCN20:GetComponentInfo(componentID)
  if ECampaignCN20ComponentID.ECN20_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignCN20ComponentID.ECN20_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignCN20ComponentID.ECN20_LINE_MISSION_TALEN == componentID then
    return self._linetalentComponetInfo
  end
  if ECampaignCN20ComponentID.ECN20_TALENT_TREE == componentID then
    return self._talentTreeCompInfo
  end
  if ECampaignCN20ComponentID.ECN20_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignCN20ComponentID.ECN20_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignCN20ComponentID.ECN20_ACTION_POINT == componentID then
    return self._actionPointCompInfo
  end
  if ECampaignCN20ComponentID.ECN20_ALCHEMY == componentID then
    return self._alchemyCompInfo
  end
  if ECampaignCN20ComponentID.ECN20_PERSON_PROGRESS == componentID then
    return self._personProgressCompInfo
  end
  if ECampaignCN20ComponentID.ECN20_SHARED == componentID then
    return self._storySharedComponentInfo
  end
  return nil
end

function CCampaignCN20:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_N20)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end
