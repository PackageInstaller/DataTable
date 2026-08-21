_class("CCampaignN10", ICampaignComponentLocalProcessBase)
CCampaignN10 = CCampaignN10

function CCampaignN10:Constructor()
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginComponentInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN10:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N10
end

function CCampaignN10:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN10:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLotteryComponent()
  self:_GetStoryComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
end

function CCampaignN10:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignN10:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignN10ComponentID.ECAMPAIGN_N10_STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignN10:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN10:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN10ComponentID.ECAMPAIGN_N10_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN10:GetComponent(componentID)
  if ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY == componentID then
    return self._lotteryComponent
  end
  if ECampaignN10ComponentID.ECAMPAIGN_N10_STORY == componentID then
    return self._storyComponent
  end
  if ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN10ComponentID.ECAMPAIGN_N10_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  return nil
end

function CCampaignN10:GetComponentInfo(componentID)
  if ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  if ECampaignN10ComponentID.ECAMPAIGN_N10_STORY == componentID then
    return self._storyComponentInfo
  end
  if ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN10ComponentID.ECAMPAIGN_N10_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  return nil
end

function CCampaignN10:LoginRewardRedPoint()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN10:ShopRedPoint()
  if self._lotteryCompInfo and self._lotteryComponent:ComponentIsOpen() then
    local costCount = self._lotteryCompInfo.m_cost_count * self._lotteryCompInfo.m_multi_lottery
    local curCount = ClientCampaignDrawShop.GetMoney(self._lotteryCompInfo.m_cost_item_id)
    return costCount <= curCount and self:_JackPotCanLottery()
  end
  return false
end

function CCampaignN10:_JackPotCanLottery()
  if self._lotteryCompInfo then
    for key, value in pairs(self._lotteryCompInfo.m_unlock_jackpots) do
      local remainCount = 0
      local jackpots = self._lotteryCompInfo.m_jackpots[value]
      if jackpots then
        for _, awardinfo in pairs(jackpots) do
          remainCount = remainCount + awardinfo.m_lottery_count
        end
        if remainCount >= self._lotteryCompInfo.m_multi_lottery then
          return true
        end
      end
    end
  end
  return false
end

function CCampaignN10:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN10:PetStageRedPoint()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N10
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

function CCampaignN10:CampaignEndStoryRedpoint()
  local cfg = Cfg.cfg_n10_campaign_end_story()
  if not cfg or not cfg[1] then
    return false
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local endTime = loginModule:GetTimeStampByTimeStr(cfg[1].OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local nowTime = svrTimeModule:GetServerTime() * 0.001
  local playRecord = LocalDB.GetInt("N10CampaignEndStory" .. loginModule:GetRoleShowID(), 0)
  return endTime <= nowTime and playRecord <= 0
end

function CCampaignN10:HaveRedPoint()
  return self:LoginRewardRedPoint() or self:ShopRedPoint() or self:PetStageRedPoint() or self.CampaignEndStoryRedpoint()
end

function CCampaignN10:UnLockNew()
  if self._campaignObj then
    local sampleInfo = self._campaignObj:GetSampleInfo()
    if sampleInfo then
      return sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
    end
  end
  return false
end

function CCampaignN10:HaveNewFlag()
  return self:UnLockNew()
end
