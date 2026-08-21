_class("CCampaignN21", ICampaignComponentLocalProcessBase)
CCampaignN21 = CCampaignN21

function CCampaignN21:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._levelCommonComponet = nil
  self._levelCommonCompInfo = nil
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self._pangolinComponent = nil
  self._pangolinCompInfo = nil
  self._exploreMinigameComponent = nil
  self._exploreMinigameComponentInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN21:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N21
end

function CCampaignN21:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN21:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetLotteryComponent()
  self:_GetPangolinComponent()
  self:_GetExploreMiniGameComponent()
  self:_GetLevelCommonComponent()
  self:_GetPower2itemComponent()
end

function CCampaignN21:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignN21ComponentID.ECAMPAIGN_N21_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignN21:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN21ComponentID.ECAMPAIGN_N21_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN21:_GetLevelCommonComponent()
  self._levelCommonComponet = self._campaignObj:GetComponent(ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_COMMON)
  if not self._levelCommonComponet then
    return
  end
  self._levelCommonCompInfo = self._levelCommonComponet:ComponentInfo()
end

function CCampaignN21:_GetExploreMiniGameComponent()
  self._exploreMinigameComponent = self._campaignObj:GetComponent(ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME)
  if not self._exploreMinigameComponent then
    return
  end
  self._exploreMinigameComponentInfo = self._exploreMinigameComponent:ComponentInfo()
end

function CCampaignN21:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN21:_GetPower2itemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN21ComponentID.ECAMPAIGN_N21_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN21:GetComponent(componentID)
  if ECampaignN21ComponentID.ECAMPAIGN_N21_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_COMMON == componentID then
    return self._levelCommonComponet
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_LOTTERY == componentID then
    return self._lotteryComponent
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_PANGOLIN == componentID then
    return self._pangolinComponent
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME == componentID then
    return self._exploreMinigameComponent
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  return nil
end

function CCampaignN21:GetComponentInfo(componentID)
  if ECampaignN21ComponentID.ECAMPAIGN_N21_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_COMMON == componentID then
    return self._levelCommonCompInfo
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_PANGOLIN == componentID then
    return self._pangolinCompInfo
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME == componentID then
    return self._exploreMinigameComponentInfo
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN21ComponentID.ECAMPAIGN_N21_LEVEL_FIXTEAM == componentID then
    return self._fixTeamCompInfo
  end
  return nil
end

function CCampaignN21:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N21)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN21:GetEntryRedDot()
  return self:GetPlanListRedDot() or self:LotteryShopReddot() or self:AccumulateLoginReddot() or self:GetIntegratedCalculation()
end

function CCampaignN21:GetPlanListRedDot()
  return not LocalDB.HasKey("N21PlanListRedDot" .. GameGlobal.GameLogic():GetOpenId())
end

function CCampaignN21:OnOpenPlanList()
  LocalDB.SetInt("N21PlanListRedDot" .. GameGlobal.GameLogic():GetOpenId(), 1)
end

function CCampaignN21:GetIntegratedCalculation()
  return not LocalDB.HasKey("N21IntegratedCalculationRedDot" .. GameGlobal.GameLogic():GetOpenId())
end

function CCampaignN21:OnOpenGetIntegratedCalculation()
  LocalDB.SetInt("N21IntegratedCalculationRedDot" .. GameGlobal.GameLogic():GetOpenId(), 1)
end

function CCampaignN21:LotteryShopReddot()
  if self._lotteryCompInfo and self._lotteryComponent:ComponentIsOpen() then
    local costCount = self._lotteryCompInfo.m_cost_count * self._lotteryCompInfo.m_multi_lottery
    local curCount = ClientCampaignDrawShop.GetMoney(self._lotteryCompInfo.m_cost_item_id)
    return costCount <= curCount and self:_JackPotCanLottery()
  end
  return false
end

function CCampaignN21:_JackPotCanLottery()
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

function CCampaignN21:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN21:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN21:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N21
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

function CCampaignN21:_GetPangolinComponent()
  self._pangolinComponent = self._campaignObj:GetComponent(ECampaignN21ComponentID.ECAMPAIGN_N21_PANGOLIN)
  if not self._pangolinComponent then
    return
  end
  self._pangolinCompInfo = self._pangolinComponent:ComponentInfo()
end

function CCampaignN21:WeiSiExploreReddot()
  return not LocalDB.HasKey("N21WeiSiExploreRedDot" .. GameGlobal.GameLogic():GetOpenId())
end

function CCampaignN21:OnOpenWeiSiExplore()
  LocalDB.SetInt("N21WeiSiExploreRedDot" .. GameGlobal.GameLogic():GetOpenId(), 1)
end

function CCampaignN21:HaveNewHighEquip()
  return self._exploreMinigameComponentInfo.have_new_high_equip
end

function CCampaignN21:OnEnterMiniGame(TT)
  self._exploreMinigameComponent:HandleEnterExplored(TT)
end
