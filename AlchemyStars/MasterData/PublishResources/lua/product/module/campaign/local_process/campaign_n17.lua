_class("CCampaignN17", ICampaignComponentLocalProcessBase)
CCampaignN17 = CCampaignN17

function CCampaignN17:Constructor()
  self._cycleQuestComponent = nil
  self._cycleQuestComponentInfo = nil
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self.power2itemComponent = nil
  self.power2itemComponentInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginComponentInfo = nil
  self._exploreMinigameComponent = nil
  self._exploreMinigameComponentInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN17:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N17
end

function CCampaignN17:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN17:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLotteryComponent()
  self:_GetStoryComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetCycleQuestComponent()
  self:_GetExploreMiniGameComponent()
  self:_GetFixTeamComponent()
end

function CCampaignN17:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignN17ComponentID.ECAMPAIGN_N17_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignN17:_GetStoryComponent()
  self.power2itemComponent = self._campaignObj:GetComponent(ECampaignN17ComponentID.ECAMPAIGN_N17_STORY)
  if not self.power2itemComponent then
    return
  end
  self.power2itemComponentInfo = self.power2itemComponent:ComponentInfo()
end

function CCampaignN17:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN17ComponentID.ECAMPAIGN_N17_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN17:_GetCycleQuestComponent()
  self._cycleQuestComponent = self._campaignObj:GetComponent(ECampaignN17ComponentID.ECAMPAIGN_N17_CYCLE_QUEST)
  if not self._cycleQuestComponent then
    return
  end
  self._cycleQuestComponentInfo = self._cycleQuestComponent:ComponentInfo()
end

function CCampaignN17:_GetExploreMiniGameComponent()
  self._exploreMinigameComponent = self._campaignObj:GetComponent(ECampaignN17ComponentID.ECAMPAIGN_N17_MINI_GAME)
  if not self._exploreMinigameComponent then
    return
  end
  self._exploreMinigameComponentInfo = self._exploreMinigameComponent:ComponentInfo()
end

function CCampaignN17:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN17ComponentID.ECAMPAIGN_N17_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN17:GetComponent(componentID)
  if ECampaignN17ComponentID.ECAMPAIGN_N17_LOTTERY == componentID then
    return self._lotteryComponent
  end
  if ECampaignN17ComponentID.ECAMPAIGN_N17_STORY == componentID then
    return self.power2itemComponent
  end
  if ECampaignN17ComponentID.ECAMPAIGN_N17_CYCLE_QUEST == componentID then
    return self._cycleQuestComponent
  end
  if ECampaignN17ComponentID.ECAMPAIGN_N17_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN17ComponentID.ECAMPAIGN_N17_MINI_GAME == componentID then
    return self._exploreMinigameComponent
  end
  if ECampaignN17ComponentID.ECAMPAIGN_N17_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  return nil
end

function CCampaignN17:GetComponentInfo(componentID)
  if ECampaignN17ComponentID.ECAMPAIGN_N17_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  if ECampaignN17ComponentID.ECAMPAIGN_N17_STORY == componentID then
    return self.power2itemComponentInfo
  end
  if ECampaignN17ComponentID.ECAMPAIGN_N17_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN17ComponentID.ECAMPAIGN_N17_MINI_GAME == componentID then
    return self._exploreMinigameComponentInfo
  end
  if ECampaignN17ComponentID.ECAMPAIGN_N17_CYCLE_QUEST == componentID then
    return self._cycleQuestComponentInfo
  end
  return nil
end

function CCampaignN17:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N17)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN17:GetEntryRedDot()
  return self:GetPlanListRedDot() or self:LotteryShopReddot() or self:AccumulateLoginReddot() or self:GetIntegratedCalculation()
end

function CCampaignN17:GetPlanListRedDot()
  return not LocalDB.HasKey("N17PlanListRedDot" .. GameGlobal.GameLogic():GetOpenId())
end

function CCampaignN17:OnOpenPlanList()
  LocalDB.SetInt("N17PlanListRedDot" .. GameGlobal.GameLogic():GetOpenId(), 1)
end

function CCampaignN17:GetIntegratedCalculation()
  return not LocalDB.HasKey("N17IntegratedCalculationRedDot" .. GameGlobal.GameLogic():GetOpenId())
end

function CCampaignN17:OnOpenGetIntegratedCalculation()
  LocalDB.SetInt("N17IntegratedCalculationRedDot" .. GameGlobal.GameLogic():GetOpenId(), 1)
end

function CCampaignN17:LotteryShopReddot()
  if self._lotteryCompInfo and self._lotteryComponent:ComponentIsOpen() then
    local costCount = self._lotteryCompInfo.m_cost_count * self._lotteryCompInfo.m_multi_lottery
    local curCount = ClientCampaignDrawShop.GetMoney(self._lotteryCompInfo.m_cost_item_id)
    return costCount <= curCount and self:_JackPotCanLottery()
  end
  return false
end

function CCampaignN17:_JackPotCanLottery()
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

function CCampaignN17:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN17:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN17:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N17
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

function CCampaignN17:WeiSiExploreReddot()
  return not LocalDB.HasKey("N17WeiSiExploreRedDot" .. GameGlobal.GameLogic():GetOpenId())
end

function CCampaignN17:OnOpenWeiSiExplore()
  LocalDB.SetInt("N17WeiSiExploreRedDot" .. GameGlobal.GameLogic():GetOpenId(), 1)
end

function CCampaignN17:HaveNewHighEquip()
  return self._exploreMinigameComponentInfo.have_new_high_equip
end

function CCampaignN17:OnEnterMiniGame(TT)
  self._exploreMinigameComponent:HandleEnterExplored(TT)
end
