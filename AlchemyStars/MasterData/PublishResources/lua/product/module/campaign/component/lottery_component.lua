_class("LotteryComponent", ICampaignComponent)
LotteryComponent = LotteryComponent

function LotteryComponent:Constructor()
  self._componentInfo = LotteryComponentInfo:New()
end

function LotteryComponent:ComponentInfo()
  if not self._componentInfo then
    self._componentInfo = LotteryComponentInfo:New()
  end
  return self._componentInfo
end

function LotteryComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function LotteryComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_LOTTERY
end

function LotteryComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self._componentInfo)
  return ret
end

function LotteryComponent:HandleLottery(TT, asyncRes, jackpotIndex, lotteryType)
  local request = LotteryComponentLotteryReq:New()
  request.m_jackpot_index = jackpotIndex
  request.m_lottery_type = lotteryType
  local response = LotteryComponentLotteryRep:New()
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][Lottery] HandleLottery ret:", asyncRes.m_result)
    return nil
  end
  if response.m_is_open_new then
    table.insert(componentInfo.m_unlock_jackpots, response.m_unlock_jackpot_index)
  end
  componentInfo.m_jackpots[jackpotIndex] = response.m_jackpot
  asyncRes:SetSucc(true)
  return response.m_rewards, response.m_is_open_new
end

function LotteryComponent:IsLotteryJackpotUnlock(jackpotIndex)
  local componentInfo = self:ComponentInfo()
  for _, value in pairs(componentInfo.m_unlock_jackpots) do
    if value == jackpotIndex then
      return true
    end
  end
  return false
end

function LotteryComponent:IsLotteryJeckpotEmpty(jackpotIndex)
  local componentInfo = self:ComponentInfo()
  local jackpot = componentInfo.m_jackpots[jackpotIndex]
  if jackpot then
    for _, awardInfo in pairs(jackpot) do
      if awardInfo.m_lottery_count ~= 0 then
        return false
      end
    end
  end
  return true
end

function LotteryComponent:IsLotteryJeckpotNoRestBigReward(jackpotIndex)
  local awardInfo = self:GetLotteryBigReward(jackpotIndex)
  return not awardInfo or awardInfo.m_lottery_count == 0
end

function LotteryComponent:IsLotteryJeckpotCanMutliLottery(jackpotIndex)
  local componentInfo = self:ComponentInfo()
  local jackpot = componentInfo.m_jackpots[jackpotIndex]
  local lottery_count = 0
  if jackpot then
    for _, awardInfo in pairs(jackpot) do
      lottery_count = lottery_count + awardInfo.m_lottery_count
    end
  end
  if lottery_count >= componentInfo.m_multi_lottery then
    return true
  end
  return false
end

function LotteryComponent:GetLotteryCount(jackpotIndex)
  local rest = 0
  local total = 0
  local jackpots_info = self:ComponentInfo().m_jackpots
  for key, award in pairs(jackpots_info[jackpotIndex]) do
    rest = award.m_lottery_count + rest
    total = award.m_lottery_limit_count + total
  end
  return rest, total
end

function LotteryComponent:HaveRedPoint()
  local componentInfo = self:ComponentInfo()
  if componentInfo and self:ComponentIsOpen() then
    local costCount = componentInfo.m_cost_count * componentInfo.m_multi_lottery
    local curCount = ClientCampaignDrawShop.GetMoney(componentInfo.m_cost_item_id)
    return costCount <= curCount and self:_JackPotCanLottery()
  end
  return false
end

function LotteryComponent:_JackPotCanLottery()
  local componentInfo = self:ComponentInfo()
  if componentInfo then
    for key, value in pairs(componentInfo.m_unlock_jackpots) do
      local remainCount = 0
      local jackpots = componentInfo.m_jackpots[value]
      if jackpots then
        for _, awardinfo in pairs(jackpots) do
          remainCount = remainCount + awardinfo.m_lottery_count
        end
        if remainCount >= componentInfo.m_multi_lottery then
          return true
        end
      end
    end
  end
  return false
end

function LotteryComponent:RandEventInfo()
  local jackpots_info = {}
  local lottery_times = 0
  local unlock_jackpots_id = self:ComponentInfo().m_unlock_jackpots
  local cur_jackpots = self:ComponentInfo().m_jackpots
  for id_key, id_value in pairs(unlock_jackpots_id) do
    for key, value in pairs(cur_jackpots[id_value]) do
      lottery_times = lottery_times + value.m_lottery_limit_count - value.m_lottery_count
    end
  end
  local campaign_id = self:GetComponentInfo().m_campaign_id
  local event_cfg = Cfg.cfg_activity_lottery_event({CampaignID = campaign_id})
  local event_info = event_cfg[1].Event
  for i = 1, #event_info do
    local jackpot_event = RandomEvent:New()
    jackpot_event.lottery_times = event_info[i][1]
    jackpot_event.event_id = event_info[i][2]
    if lottery_times >= event_info[i][1] then
      jackpot_event.is_unlock = true
    end
    table.insert(jackpots_info, jackpot_event)
  end
  return jackpots_info, lottery_times
end

local LotteryState = {
  None = 1,
  WaitRequestResult = 2,
  LotterySpine = 3,
  LotteryResultSpine = 4,
  ShowRewards = 5
}
_enum("LotteryState", LotteryState)

function LotteryComponent:GetLotteryCostItemIconText()
  local item_id = self:GetComponentInfo().m_cost_item_id
  local cfgItem = Cfg.cfg_item[item_id]
  local icon = cfgItem and cfgItem.Icon
  local count = GameGlobal.GetModule(ItemModule):GetItemCount(item_id)
  return icon, count
end

function LotteryComponent:GetLotteryBigReward(jackpotIndex)
  local componentInfo = self:ComponentInfo()
  local jackpot = componentInfo.m_jackpots[jackpotIndex]
  if jackpot then
    for _, awardInfo in pairs(jackpot) do
      if awardInfo.m_is_big_reward then
        return awardInfo
      end
    end
  end
end

function LotteryComponent:GetLotteryBigRewardName(jackpotIndex)
  local awardInfo = self:GetLotteryBigReward(jackpotIndex)
  if awardInfo then
    local itemId = awardInfo.m_item_id
    local cfg = Cfg.cfg_item[itemId]
    return cfg and StringTable.Get(cfg.Name) or ""
  end
  return ""
end
