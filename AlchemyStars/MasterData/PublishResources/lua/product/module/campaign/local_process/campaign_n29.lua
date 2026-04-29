_class("CCampaignN29", ICampaignComponentLocalProcessBase)
CCampaignN29 = CCampaignN29

function CCampaignN29:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._levelHardComponent = nil
  self._levelHardCompInfo = nil
  self._blackHardComponent = nil
  self._blackHardCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self._chessComponent = nil
  self._chessCompInfo = nil
  self._detectiveComponent = nil
  self._detectiveCompInfo = nil
  self._camQuestComponet = nil
  self._camQuestComponetInfo = nil
  self._campaignObj = nil
end

function CCampaignN29:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N29
end

function CCampaignN29:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN29:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetLineMissionComponent()
  self:_GetDifficultMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetLotteryComponent()
  self:_GetBlackDifficultMissionComponent()
  self:_GetChessComponent()
  self:_GetDetectiveComponent()
  self:_GetQuestComponent()
end

function CCampaignN29:_GetDetectiveComponent()
  self._detectiveComponent = self._campaignObj:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  if not self._detectiveComponent then
    return
  end
  self._detectiveCompInfo = self._detectiveComponent:ComponentInfo()
end

function CCampaignN29:_GetQuestComponent()
  self._camQuestComponet = self._campaignObj:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_QUEST)
  if not self._camQuestComponet then
    return
  end
  self._camQuestComponetInfo = self._camQuestComponet:ComponentInfo()
end

function CCampaignN29:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN29:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN29:_GetDifficultMissionComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN29:_GetBlackDifficultMissionComponent()
  self._blackHardComponent = self._campaignObj:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION)
  if not self._blackHardComponent then
    return
  end
  self._blackHardCompInfo = self._blackHardComponent:ComponentInfo()
end

function CCampaignN29:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_FIRST_MEET)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN29:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN29:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignN29:_GetChessComponent()
  self._chessComponent = self._campaignObj:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_CHESS)
  if not self._chessComponent then
    return
  end
  self._chessCompInfo = self._chessComponent:ComponentInfo()
end

function CCampaignN29:GetComponent(componentID)
  if ECampaignN29ComponentID.ECAMPAIGN_N29_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_FIRST_MEET == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION == componentID then
    return self._levelHardComponent
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION == componentID then
    return self._blackHardComponent
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_LOTTERY == componentID then
    return self._lotteryComponent
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_CHESS == componentID then
    return self._chessComponent
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE == componentID then
    return self._detectiveComponent
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_QUEST == componentID then
    return self._camQuestComponet
  end
  return nil
end

function CCampaignN29:GetComponentInfo(componentID)
  if ECampaignN29ComponentID.ECAMPAIGN_N29_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_FIRST_MEET == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION == componentID then
    return self._blackHardCompInfo
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_CHESS == componentID then
    return self._chessCompInfo
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE == componentID then
    return self._detectiveCompInfo
  end
  if ECampaignN29ComponentID.ECAMPAIGN_N29_QUEST == componentID then
    return self._camQuestComponetInfo
  end
  return nil
end

function CCampaignN29:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N29)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN29:GetEntryRedDot()
  return self:GetFixMissionRedDot() or self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:LineMissionRedDot() or self:CampQuestReddot()
end

function CCampaignN29:CampQuestReddot()
  return self._camQuestComponet and self._camQuestComponet:HaveRedPoint()
end

function CCampaignN29:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN29:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N29
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

function CCampaignN29:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN29:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN29:HardLineMissionRedDot()
  if not self._levelHardComponent:ComponentIsOpen() then
    return false
  end
  return self._levelHardComponent:HaveRedPoint()
end

function CCampaignN29:BlackHardLineMissionRedDot()
  if not self._blackHardComponent:ComponentIsOpen() then
    return false
  end
  return self._blackHardComponent:HaveRedPoint()
end

function CCampaignN29:LotteryShopReddot()
  if self._lotteryCompInfo and self._lotteryComponent:ComponentIsOpen() then
    local costCount = self._lotteryCompInfo.m_cost_count * self._lotteryCompInfo.m_multi_lottery
    local curCount = ClientCampaignDrawShop.GetMoney(self._lotteryCompInfo.m_cost_item_id)
    return costCount <= curCount and self:_JackPotCanLottery()
  end
  return false
end

function CCampaignN29:_JackPotCanLottery()
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
