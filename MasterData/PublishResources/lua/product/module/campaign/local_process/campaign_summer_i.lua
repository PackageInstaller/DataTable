_class("CampaignSummerI", ICampaignComponentLocalProcessBase)
CampaignSummerI = CampaignSummerI

function CampaignSummerI:Constructor()
  self._shopComponent = nil
  self._shopCompInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._levelCommonComponet = nil
  self._levelCommonCompInfo = nil
  self._levelHardComponent = nil
  self._levelHardCompInfo = nil
  self._campaignShavingIceComponent = nil
  self._shavingIceComponentInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._actionPointComponent = nil
  self._actionPointCompInfo = nil
  self._storyComponent = nil
  self._storyCompInfo = nil
  self._campaignObj = nil
end

function CampaignSummerI:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_SUMMER_I
end

function CampaignSummerI:CampaignObjInfo()
  return self._campaignObj
end

function CampaignSummerI:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetShopComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetLevelCommonComponent()
  self:_GetLevelHardComponent()
  self:_GetShavingIceComponent()
  self:_GetFixTeamComponent()
  self:_GetActionPointComponent()
  self:_GetStoryComponent()
end

function CampaignSummerI:_GetShavingIceComponent()
  self._campaignShavingIceComponent = self._campaignObj:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_SHAVING_ICE)
  if not self._campaignShavingIceComponent then
    return
  end
  self._shavingIceComponentInfo = self._campaignShavingIceComponent:ComponentInfo()
end

function CampaignSummerI:_GetShopComponent()
  self._shopComponent = self._campaignObj:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_SHOP)
  if not self._shopComponent then
    return
  end
  self._shopCompInfo = self._shopComponent:ComponentInfo()
end

function CampaignSummerI:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CampaignSummerI:_GetLevelCommonComponent()
  self._levelCommonComponet = self._campaignObj:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_COMMON)
  if not self._levelCommonComponet then
    return
  end
  self._levelCommonCompInfo = self._levelCommonComponet:ComponentInfo()
end

function CampaignSummerI:_GetLevelHardComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_HARD)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CampaignSummerI:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CampaignSummerI:_GetActionPointComponent()
  self._actionPointComponent = self._campaignObj:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_ACTION_POINT)
  if not self._actionPointComponent then
    return
  end
  self._actionPointCompInfo = self._actionPointComponent:ComponentInfo()
end

function CampaignSummerI:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_STORY)
  if not self._storyComponent then
    return
  end
  self._storyCompInfo = self._storyComponent:ComponentInfo()
end

function CampaignSummerI:GetComponent(componentID)
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_SHOP == componentID then
    return self._shopComponent
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_COMMON == componentID then
    return self._levelCommonComponet
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_HARD == componentID then
    return self._levelHardComponent
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_SHAVING_ICE == componentID then
    return self._campaignShavingIceComponent
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_ACTION_POINT == componentID then
    return self._actionPointComponent
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_STORY == componentID then
    return self._storyComponent
  end
  return nil
end

function CampaignSummerI:GetComponentInfo(componentID)
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_SHOP == componentID then
    return self._shopCompInfo
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_COMMON == componentID then
    return self._levelCommonCompInfo
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_HARD == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_SHAVING_ICE == componentID then
    return self._shavingIceComponentInfo
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_FIXTEAM == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_ACTION_POINT == componentID then
    return self._actionPointCompInfo
  end
  if ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_STORY == componentID then
    return self._storyCompInfo
  end
  return nil
end
