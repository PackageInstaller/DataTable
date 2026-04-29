_class("CCampaignCN7", ICampaignComponentLocalProcessBase)
CCampaignCN7 = CCampaignCN7

function CCampaignCN7:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self._storySharedComponent = nil
  self._storySharedComponentInfo = nil
  self._tacitTestComponent = nil
  self._tacitTestComponentInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignCN7:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N7
end

function CCampaignCN7:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignCN7:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetLotteryComponent()
  self:_GetSharedStoryComponent()
  self:_GetTacitTestComponent()
  self:_GetQuestComponent()
end

function CCampaignCN7:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignCN7:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignCN7:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignCN7:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignCN7:_GetSharedStoryComponent()
  self._storySharedComponent = self._campaignObj:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_SHARED)
  if not self._storySharedComponent then
    return
  end
  self._storySharedComponentInfo = self._storySharedComponent:ComponentInfo()
end

function CCampaignCN7:_GetTacitTestComponent()
  self._tacitTestComponent = self._campaignObj:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST)
  if not self._tacitTestComponent then
    return
  end
  self._tacitTestComponentInfo = self._tacitTestComponent:ComponentInfo()
end

function CCampaignCN7:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignCN7:GetComponent(componentID)
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY == componentID then
    return self._lotteryComponent
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_SHARED == componentID then
    return self._storySharedComponent
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST == componentID then
    return self._tacitTestComponent
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST == componentID then
    return self._questComponent
  end
  return nil
end

function CCampaignCN7:GetComponentInfo(componentID)
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_SHARED == componentID then
    return self._storySharedComponentInfo
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST == componentID then
    return self._tacitTestComponentInfo
  end
  if ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST == componentID then
    return self._questComponentInfo
  end
  return nil
end

function CCampaignCN7:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_N7)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignCN7:GetEntryRedDot()
  return self:LineMissionRedDot() or self:AccumulateLoginReddot() or self:TacitTestRedDot() or self:QuestRedDot()
end

function CCampaignCN7:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignCN7:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignCN7:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignCN7:TacitTestRedDot()
  if not self._tacitTestComponent:ComponentIsOpen() then
    return false
  end
  return self._tacitTestComponent:HaveRedPoint()
end

function CCampaignCN7:QuestRedDot()
  if not self._questComponent:ComponentIsOpen() then
    return false
  end
  return self._questComponent:HaveRedPoint()
end

function CCampaignCN7:ShopRedPoint()
  if self._lotteryCompInfo and self._lotteryComponent:ComponentIsOpen() then
    local costCount = self._lotteryCompInfo.m_cost_count * self._lotteryCompInfo.m_multi_lottery
    local curCount = ClientCampaignDrawShop.GetMoney(self._lotteryCompInfo.m_cost_item_id)
    return costCount <= curCount and self:_JackPotCanLottery()
  end
  return false
end

function CCampaignCN7:_JackPotCanLottery()
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
