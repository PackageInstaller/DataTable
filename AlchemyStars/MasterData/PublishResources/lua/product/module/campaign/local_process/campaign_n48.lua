_class("CCampaignN48", ICampaignComponentLocalProcessBase)
CCampaignN48 = CCampaignN48

function CCampaignN48:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._storySharedComponent = nil
  self._storySharedComponentInfo = nil
  self._diffcultyMissionComponent = nil
  self._difficultyMissionCompInfo = nil
  self._campaignShavingIceComponent = nil
  self._shavingIceComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN48:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N48
end

function CCampaignN48:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN48:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetSharedStoryComponent()
  self:_GetShopComponent()
  self:_GetDifficultyMissionComponent()
  self:_GetShavingIceComponent()
end

function CCampaignN48:_GetShavingIceComponent()
  self._campaignShavingIceComponent = self._campaignObj:GetComponent(ECampaignN48ComponentID.MINI_GAME)
  if not self._campaignShavingIceComponent then
    return
  end
  self._shavingIceComponentInfo = self._campaignShavingIceComponent:ComponentInfo()
end

function CCampaignN48:_GetDifficultyMissionComponent()
  self._diffcultyMissionComponent = self._campaignObj:GetComponent(ECampaignN48ComponentID.HEIXIA)
  if not self._diffcultyMissionComponent then
    return
  end
  self._difficultyMissionCompInfo = self._diffcultyMissionComponent:ComponentInfo()
end

function CCampaignN48:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN48ComponentID.LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN48:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN48ComponentID.CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN48:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN48ComponentID.SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN48:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN48ComponentID.POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN48:_GetSharedStoryComponent()
  self._storySharedComponent = self._campaignObj:GetComponent(ECampaignN48ComponentID.SHARED)
  if not self._storySharedComponent then
    return
  end
  self._storySharedComponentInfo = self._storySharedComponent:ComponentInfo()
end

function CCampaignN48:GetComponent(componentID)
  if ECampaignN48ComponentID.CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN48ComponentID.LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN48ComponentID.POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN48ComponentID.SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignN48ComponentID.SHARED == componentID then
    return self._storySharedComponent
  end
  if ECampaignN48ComponentID.HEIXIA == componentID then
    return self._diffcultyMissionComponent
  end
  if ECampaignN48ComponentID.MINI_GAME == componentID then
    return self._campaignShavingIceComponent
  end
  return nil
end

function CCampaignN48:GetComponentInfo(componentID)
  if ECampaignN48ComponentID.CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN48ComponentID.LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN48ComponentID.POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN48ComponentID.SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignN48ComponentID.SHARED == componentID then
    return self._storySharedComponentInfo
  end
  if ECampaignN48ComponentID.HEIXIA == componentID then
    return self._difficultyMissionCompInfo
  end
  if ECampaignN48ComponentID.MINI_GAME == componentID then
    return self._shavingIceComponentInfo
  end
  return nil
end

function CCampaignN48:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N48)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN48:GetEntryRedDot()
  return self:AccumulateLoginReddot() or self:LineMissionRedDot() or self:DifficultyMissionRedDot()
end

function CCampaignN48:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN48:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN48:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  local red = false
  local isCross = UIActivityN48Helper.LocalDB_Get_CrossDay("line", "Red")
  red = self._lineMissionComponent:HaveRedPoint() and isCross
  return red
end

function CCampaignN48:DifficultyMissionRedDot()
  if not self._diffcultyMissionComponent:ComponentIsOpen() then
    return false
  end
  local red = false
  local isCross = UIActivityN48Helper.LocalDB_Get_CrossDay("hard", "Red")
  red = red or self._diffcultyMissionComponent:HaveRedPoint()
  return red and isCross
end

function CCampaignN48:GetLottleryNew()
  if not self._powerShopComponent:ComponentIsOpen() then
    return false
  end
  return UIActivityN48Helper.GetNewFlagStatus("N48_Lottlery")
end

function CCampaignN48:ClearLottleryNew()
  UIActivityN48Helper.SetNewFlagStatus("N48_Lottlery", false)
end

function CCampaignN48:GetChessNew()
  if not self._campaignShavingIceComponent:ComponentIsOpen() then
    return false
  end
  return UIActivityN48Helper.GetNewFlagStatus("N48_Chess")
end

function CCampaignN48:ClearChessNew()
  UIActivityN48Helper.SetNewFlagStatus("N48_Chess", false)
end

function CCampaignN48:GetHardLineNew()
  if not self._diffcultyMissionComponent:ComponentIsOpen() then
    return false
  end
  return UIActivityN48Helper.GetNewFlagStatus("N48_Hard_line")
end

function CCampaignN48:ClearHardLineNew()
  UIActivityN48Helper.SetNewFlagStatus("N48_Hard_line", false)
end

function CCampaignN48:GetLoginNew()
  if not self._cumulativeLoginComponent:ComponentIsOpen() then
    return false
  end
  return UIActivityN48Helper.GetNewFlagStatus("N48_Login")
end

function CCampaignN48:ClearLoginNew()
  UIActivityN48Helper.SetNewFlagStatus("N48_Login", false)
end

function CCampaignN48:GetBattlePassNew()
  return UIActivityN48Helper.GetNewFlagStatus("BattlePass")
end

function CCampaignN48:ClearBattlePassNew()
  UIActivityN48Helper.SetNewFlagStatus("BattlePass", false)
end

function CCampaignN48:GetLineMissionNew()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return UIActivityN48Helper.GetNewFlagStatus("N48_LineMission")
end

function CCampaignN48:ClearLineMissionNew()
  UIActivityN48Helper.SetNewFlagStatus("N48_LineMission", false)
end
