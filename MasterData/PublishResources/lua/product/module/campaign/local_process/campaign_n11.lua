_class("CCampaignN11", ICampaignComponentLocalProcessBase)
CCampaignN11 = CCampaignN11

function CCampaignN11:Constructor()
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
  self._campaignObj = nil
end

function CCampaignN11:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N11
end

function CCampaignN11:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN11:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetShopComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetLevelCommonComponent()
  self:_GetLevelHardComponent()
  self:_GetFixTeamComponent()
  self:_GetActionPointComponent()
  self:_GetStoryComponent()
end

function CCampaignN11:_GetShopComponent()
  self._shopComponent = self._campaignObj:GetComponent(ECampaignN11ComponentID.ECAMPAIGN_N11_SHOP)
  if not self._shopComponent then
    return
  end
  self._shopCompInfo = self._shopComponent:ComponentInfo()
end

function CCampaignN11:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN11ComponentID.ECAMPAIGN_N11_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN11:_GetLevelCommonComponent()
  self._levelCommonComponet = self._campaignObj:GetComponent(ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_COMMON)
  if not self._levelCommonComponet then
    return
  end
  self._levelCommonCompInfo = self._levelCommonComponet:ComponentInfo()
end

function CCampaignN11:_GetLevelHardComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_HARD)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN11:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN11:_GetActionPointComponent()
  self._actionPointComponent = self._campaignObj:GetComponent(ECampaignN11ComponentID.ECAMPAIGN_N11_ACTION_POINT)
  if not self._actionPointComponent then
    return
  end
  self._actionPointCompInfo = self._actionPointComponent:ComponentInfo()
end

function CCampaignN11:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignN11ComponentID.ECAMPAIGN_N11_STORY)
  if not self._storyComponent then
    return
  end
  self._storyCompInfo = self._storyComponent:ComponentInfo()
end

function CCampaignN11:GetComponent(componentID)
  if ECampaignN11ComponentID.ECAMPAIGN_N11_SHOP == componentID then
    return self._shopComponent
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_COMMON == componentID then
    return self._levelCommonComponet
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_HARD == componentID then
    return self._levelHardComponent
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_ACTION_POINT == componentID then
    return self._actionPointComponent
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_STORY == componentID then
    return self._storyComponent
  end
  return nil
end

function CCampaignN11:GetComponentInfo(componentID)
  if ECampaignN11ComponentID.ECAMPAIGN_N11_SHOP == componentID then
    return self._shopCompInfo
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_COMMON == componentID then
    return self._levelCommonCompInfo
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_HARD == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_FIXTEAM == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_ACTION_POINT == componentID then
    return self._actionPointCompInfo
  end
  if ECampaignN11ComponentID.ECAMPAIGN_N11_STORY == componentID then
    return self._storyCompInfo
  end
  return nil
end

function CCampaignN11:GetStepStatusNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N11)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN11:GetEntryRedDot()
  return self:GetEasyMissionRedDot() or self:GetHardMissionRedDot() or self:GetFixMissionRedDot() or self:GetLoginAwardRedDot()
end

function CCampaignN11:GetLoginAwardRedDot()
  if not self._cumulativeLoginComponent:ComponentIsOpen() then
    return false
  end
  local info = self._cumulativeLoginCompInfo.m_cumulative_info
  for k, v in pairs(info) do
    if v.m_reward_status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV then
      return true
    end
  end
  return false
end

function CCampaignN11:GetEasyMissionRedDot()
  return self:GetFixMissionRedDot()
end

function CCampaignN11:GetHardMissionRedDot()
  if self._levelHardComponent == nil then
    return false
  end
  return self._levelHardComponent:GetComponentStep() == ECampaignStep.CAMPAIGN_STEP_NEW
end

function CCampaignN11:GetFixMissionRedDot()
  if self._fixTeamComponent == nil then
    return false
  end
  return self._fixTeamComponent:HaveRedPoint()
end
