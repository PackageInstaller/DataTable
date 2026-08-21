_class("CCampaignN20", ICampaignComponentLocalProcessBase)
CCampaignN20 = CCampaignN20

function CCampaignN20:Constructor()
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
  self._campaignShavingIceComponent = nil
  self._shavingIceComponentInfo = nil
  self._campaignAvgStoryComponent = nil
  self._avgStoryComponentClientInfo = nil
  self._campaignObj = nil
end

function CCampaignN20:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N20
end

function CCampaignN20:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN20:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLevelCommonComponent()
  self:_GetLevelHardComponent()
  self:_GetPower2itemComponent()
  self:_GetShopComponent()
  self:_GetFixTeamComponent()
  self:_GetActionPointComponent()
  self:_GetShavingIceComponent()
  self:_GetAvgStoryComponent()
end

function CCampaignN20:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN20:_GetLevelCommonComponent()
  self._levelCommonComponet = self._campaignObj:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_COMMON)
  if not self._levelCommonComponet then
    return
  end
  self._levelCommonCompInfo = self._levelCommonComponet:ComponentInfo()
end

function CCampaignN20:_GetLevelHardComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_HARD)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN20:_GetPower2itemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN20:_GetShopComponent()
  self._shopComponent = self._campaignObj:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_SHOP)
  if not self._shopComponent then
    return
  end
  self._shopCompInfo = self._shopComponent:ComponentInfo()
end

function CCampaignN20:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN20:_GetActionPointComponent()
  self._actionPointComponent = self._campaignObj:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_ACTION_POINT)
  if not self._actionPointComponent then
    return
  end
  self._actionPointCompInfo = self._actionPointComponent:ComponentInfo()
end

function CCampaignN20:_GetShavingIceComponent()
  self._campaignShavingIceComponent = self._campaignObj:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_MINI_GAME)
  if not self._campaignShavingIceComponent then
    return
  end
  self._shavingIceComponentInfo = self._campaignShavingIceComponent:ComponentInfo()
end

function CCampaignN20:_GetAvgStoryComponent()
  self._campaignAvgStoryComponent = self._campaignObj:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_AVG_MINI_GAME)
  if not self._campaignAvgStoryComponent then
    return
  end
  self._avgStoryComponentClientInfo = self._campaignAvgStoryComponent:ComponentInfo()
end

function CCampaignN20:GetComponent(componentID)
  if ECampaignN20ComponentID.ECAMPAIGN_N20_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_COMMON == componentID then
    return self._levelCommonComponet
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_HARD == componentID then
    return self._levelHardComponent
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_SHOP == componentID then
    return self._shopComponent
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_ACTION_POINT == componentID then
    return self._actionPointComponent
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_MINI_GAME == componentID then
    return self._campaignShavingIceComponent
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_AVG_MINI_GAME == componentID then
    return self._campaignAvgStoryComponent
  end
  return nil
end

function CCampaignN20:GetComponentInfo(componentID)
  if ECampaignN20ComponentID.ECAMPAIGN_N20_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_COMMON == componentID then
    return self._levelCommonCompInfo
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_HARD == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_SHOP == componentID then
    return self._shopCompInfo
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_FIXTEAM == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_ACTION_POINT == componentID then
    return self._actionPointCompInfo
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_MINI_GAME == componentID then
    return self._shavingIceComponentInfo
  end
  if ECampaignN20ComponentID.ECAMPAIGN_N20_AVG_MINI_GAME == componentID then
    return self._avgStoryComponentClientInfo
  end
  return nil
end

function CCampaignN20:GetStepStatusNew()
  return true
end

function CCampaignN20:GetEntryRedDot()
  return self:GetEasyMissionRedDot() or self:GetHardMissionRedDot() or self:GetFixMissionRedDot() or self:GetLoginAwardRedDot()
end

function CCampaignN20:GetLoginAwardRedDot()
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

function CCampaignN20:GetEasyMissionRedDot()
  return self:GetFixMissionRedDot()
end

function CCampaignN20:GetHardMissionRedDot()
  if self._levelHardComponent == nil then
    return false
  end
  return self._levelHardComponent:GetComponentStep() == ECampaignStep.CAMPAIGN_STEP_NEW
end

function CCampaignN20:GetFixMissionRedDot()
  if self._fixTeamComponent == nil then
    return false
  end
  return self._fixTeamComponent:HaveRedPoint()
end
