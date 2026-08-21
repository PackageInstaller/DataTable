_class("CCampaignN9", ICampaignComponentLocalProcessBase)
CCampaignN9 = CCampaignN9

function CCampaignN9:Constructor()
  self._shopComponent = nil
  self._shopCompInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._levelCommonComponet = nil
  self._levelCommonCompInfo = nil
  self._levelHardComponent = nil
  self._levelHardCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._actionPointComponent = nil
  self._actionPointCompInfo = nil
  self._storyComponent = nil
  self._storyCompInfo = nil
  self._subjectComponent = nil
  self._subjectCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN9:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N9
end

function CCampaignN9:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN9:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetShopComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetLevelCommonComponent()
  self:_GetLevelHardComponent()
  self:_GetFixTeamComponent()
  self:_GetActionPointComponent()
  self:_GetStoryComponent()
  self:_GetSubjectComponent()
end

function CCampaignN9:_GetShopComponent()
  self._shopComponent = self._campaignObj:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_SHOP)
  if not self._shopComponent then
    return
  end
  self._shopCompInfo = self._shopComponent:ComponentInfo()
end

function CCampaignN9:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN9:_GetLevelCommonComponent()
  self._levelCommonComponet = self._campaignObj:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_COMMON)
  if not self._levelCommonComponet then
    return
  end
  self._levelCommonCompInfo = self._levelCommonComponet:ComponentInfo()
end

function CCampaignN9:_GetLevelHardComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN9:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN9:_GetActionPointComponent()
  self._actionPointComponent = self._campaignObj:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_ACTION_POINT)
  if not self._actionPointComponent then
    return
  end
  self._actionPointCompInfo = self._actionPointComponent:ComponentInfo()
end

function CCampaignN9:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_STORY)
  if not self._storyComponent then
    return
  end
  self._storyCompInfo = self._storyComponent:ComponentInfo()
end

function CCampaignN9:_GetSubjectComponent()
  self._subjectComponent = self._campaignObj:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  if not self._subjectComponent then
    return
  end
  self._subjectCompInfo = self._subjectComponent:ComponentInfo()
end

function CCampaignN9:GetComponent(componentID)
  if ECampaignN9ComponentID.ECAMPAIGN_N9_SHOP == componentID then
    return self._shopComponent
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_COMMON == componentID then
    return self._levelCommonComponet
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD == componentID then
    return self._levelHardComponent
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_ACTION_POINT == componentID then
    return self._actionPointComponent
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_STORY == componentID then
    return self._storyComponent
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME == componentID then
    return self._subjectComponent
  end
  return nil
end

function CCampaignN9:GetComponentInfo(componentID)
  if ECampaignN9ComponentID.ECAMPAIGN_N9_SHOP == componentID then
    return self._shopCompInfo
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_COMMON == componentID then
    return self._levelCommonCompInfo
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_FIXTEAM == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_ACTION_POINT == componentID then
    return self._actionPointCompInfo
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_STORY == componentID then
    return self._storyCompInfo
  end
  if ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME == componentID then
    return self._subjectCompInfo
  end
  return nil
end
