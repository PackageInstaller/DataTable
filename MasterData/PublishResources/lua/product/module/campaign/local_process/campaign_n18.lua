_class("CCampaignN18", ICampaignComponentLocalProcessBase)
CCampaignN18 = CCampaignN18

function CCampaignN18:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._levelCommonComponet = nil
  self._levelCommonCompInfo = nil
  self._levelHardComponent = nil
  self._levelHardCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._shopComponent = nil
  self._shopCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._actionPointComponent = nil
  self._actionPointCompInfo = nil
  self._exploreMinigameComponent = nil
  self._exploreMinigameComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN18:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N18
end

function CCampaignN18:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN18:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLevelCommonComponent()
  self:_GetLevelHardComponent()
  self:_GetPower2itemComponent()
  self:_GetShopComponent()
  self:_GetFixTeamComponent()
  self:_GetActionPointComponent()
  self:_GetExploreMiniGameComponent()
end

function CCampaignN18:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN18ComponentID.ECAMPAIGN_N18_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN18:_GetLevelCommonComponent()
  self._levelCommonComponet = self._campaignObj:GetComponent(ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON)
  if not self._levelCommonComponet then
    return
  end
  self._levelCommonCompInfo = self._levelCommonComponet:ComponentInfo()
end

function CCampaignN18:_GetLevelHardComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN18:_GetPower2itemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN18ComponentID.ECAMPAIGN_N18_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN18:_GetShopComponent()
  self._shopComponent = self._campaignObj:GetComponent(ECampaignN18ComponentID.ECAMPAIGN_N18_SHOP)
  if not self._shopComponent then
    return
  end
  self._shopCompInfo = self._shopComponent:ComponentInfo()
end

function CCampaignN18:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN18:_GetActionPointComponent()
  self._actionPointComponent = self._campaignObj:GetComponent(ECampaignN18ComponentID.ECAMPAIGN_N18_ACTION_POINT)
  if not self._actionPointComponent then
    return
  end
  self._actionPointCompInfo = self._actionPointComponent:ComponentInfo()
end

function CCampaignN18:_GetExploreMiniGameComponent()
  self._exploreMinigameComponent = self._campaignObj:GetComponent(ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME)
  if not self._exploreMinigameComponent then
    return
  end
  self._exploreMinigameComponentInfo = self._exploreMinigameComponent:ComponentInfo()
end

function CCampaignN18:GetComponent(componentID)
  if ECampaignN18ComponentID.ECAMPAIGN_N18_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON == componentID then
    return self._levelCommonComponet
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD == componentID then
    return self._levelHardComponent
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_SHOP == componentID then
    return self._shopComponent
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_ACTION_POINT == componentID then
    return self._actionPointComponent
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME == componentID then
    return self._exploreMinigameComponent
  end
  return nil
end

function CCampaignN18:GetComponentInfo(componentID)
  if ECampaignN18ComponentID.ECAMPAIGN_N18_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON == componentID then
    return self._levelCommonCompInfo
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_SHOP == componentID then
    return self._shopCompInfo
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_FIXTEAM == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_ACTION_POINT == componentID then
    return self._actionPointCompInfo
  end
  if ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME == componentID then
    return self._exploreMinigameComponentInfo
  end
  return nil
end

function CCampaignN18:HaveNewHighEquip()
  return self._exploreMinigameComponentInfo.have_new_high_equip
end

function CCampaignN18:OnEnterMiniGame(TT)
  self._exploreMinigameComponent:HandleEnterExplored(TT)
end
