_class("CCampaignN19P5", ICampaignComponentLocalProcessBase)
CCampaignN19P5 = CCampaignN19P5

function CCampaignN19P5:Constructor()
  self._shopComponent = nil
  self._shopCompInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN19P5:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N19_P5
end

function CCampaignN19P5:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN19P5:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetShopComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetPower2itemComponent()
  self:_GetPower2itemShopComponent()
end

function CCampaignN19P5:_GetShopComponent()
  self._shopComponent = self._campaignObj:GetComponent(ECampaignN19P5ComponentID.SHOP)
  if not self._shopComponent then
    return
  end
  self._shopCompInfo = self._shopComponent:ComponentInfo()
end

function CCampaignN19P5:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN19P5ComponentID.CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN19P5:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN19P5ComponentID.LEVEL)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN19P5:_GetPower2itemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN19P5ComponentID.POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN19P5:_GetPower2itemShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN19P5ComponentID.POWER_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN19P5:GetComponent(componentID)
  if ECampaignN19P5ComponentID.SHOP == componentID then
    return self._shopComponent
  end
  if ECampaignN19P5ComponentID.CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN19P5ComponentID.LEVEL == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN19P5ComponentID.POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN19P5ComponentID.POWER_SHOP == componentID then
    return self._powerShopComponent
  end
  return nil
end

function CCampaignN19P5:GetComponentInfo(componentID)
  if ECampaignN19P5ComponentID.SHOP == componentID then
    return self._shopCompInfo
  end
  if ECampaignN19P5ComponentID.CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN19P5ComponentID.LEVEL == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN19P5ComponentID.POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN19P5ComponentID.POWER_SHOP == componentID then
    return self._powerShopCompInfo
  end
  return nil
end

function CCampaignN19P5:PetStageRedPoint()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N19_P5
  })
  local lock = false
  if cfgs then
    for key, value in pairs(cfgs) do
      if not self._fixTeamComponent:IsPassCamMissionID(value.CampaignMissionId) then
        lock = true
        break
      end
    end
  end
  return self._fixTeamCompInfo.m_b_unlock and lock
end
