local LotteryPoolData = class("LotteryPoolData")
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function LotteryPoolData:ctor(poolId)
  self.poolId = poolId
  local ltrCfg = ConfigData.lottery_para[poolId]
  if ltrCfg == nil then
    error("Cant get lottery_para, poolId = " .. tostring(poolId))
    return
  end
  self.ltrCfg = ltrCfg
end

function _IsCountValid(count)
  return count ~= nil and count.tm > PlayerDataCenter.timestamp
end

function LotteryPoolData:UpdLtrPoolData(LotteryStatistic)
  self.total = LotteryStatistic.total
  self.pt = LotteryStatistic.pt
  self.dayNumTab = LotteryStatistic.dayNum
  self.specialDiscountPick = LotteryStatistic.specialDiscountPick
  self.singleFreePick = LotteryStatistic.singleFreePick
  self.pickBig = LotteryStatistic.pickBig
  self._noUpNum = LotteryStatistic.norUp
  self._customDic = LotteryStatistic.custom
end

function LotteryPoolData:IsLtrPoolOpen()
  local activityFrame = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actInfo = activityFrame:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.Lotter, self.ltrCfg.lottery_id)
  local open = actInfo ~= nil and actInfo:GetCouldShowActivity()
  local limitNum = self.ltrCfg.count_limit
  local countLimit = limitNum ~= 0 and limitNum <= self:GetLtrPoolTotalNum()
  open = open and not countLimit
  return open
end

function LotteryPoolData:IsLtrExecTypeOpen(execType)
  return self.ltrCfg.drawTypeDic[execType]
end

function LotteryPoolData:IsGuaranteeOpen()
  if self.ltrCfg.guaranteeType ~= nil and self.ltrCfg.guaranteeType ~= 0 then
    return true
  else
    return false
  end
end

function LotteryPoolData:GetFirstBigPrizeNum()
  return self.ltrCfg.first_big_prize_num
end

function LotteryPoolData:IsHeroInfoBtnOpen()
  for k, v in pairs(self.ltrCfg.heroUpAllDic) do
    return {true, k}
  end
  return {false, 0}
end

function LotteryPoolData:GetLtrPoolTotalNum()
  return self.total or 0
end

function LotteryPoolData:GetLtrPoolDayNum()
  if not _IsCountValid(self.dayNumTab) then
    return 0
  end
  return self.dayNumTab.times
end

function LotteryPoolData:GetLtrPoolDayNumUpdateTimestamp()
  if not _IsCountValid(self.dayNumTab) then
    return 0
  end
  return self.dayNumTab.tm
end

function LotteryPoolData:GetLtrPoolRemainNum()
  local limitNum = self.ltrCfg.count_limit
  if limitNum == 0 then
    return 0
  else
    return limitNum - self:GetLtrPoolTotalNum()
  end
end

function LotteryPoolData:GetLtrPoolLimitNum()
  return self.ltrCfg.count_limit
end

function LotteryPoolData:IsLtrExecOneceFree()
  if self.ltrCfg.cd == 0 then
    return
  end
  if self.singleFreePick == nil or self.singleFreePick.times == 0 or self.singleFreePick.tm < PlayerDataCenter.timestamp then
    return true
  end
end

function LotteryPoolData:IsLtrExecSpecialOneceTimeOk()
  if not self:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.SpecialOnce) then
    return
  end
  if self.specialDiscountPick == nil or self.specialDiscountPick.times == 0 or self.specialDiscountPick.tm < PlayerDataCenter.timestamp then
    return true
  end
end

function LotteryPoolData:GetLtrExecSpecialOneceRemainingTs()
  if self.specialDiscountPick == nil then
    return -1
  end
  local remainingTs = self.specialDiscountPick.tm - PlayerDataCenter.timestamp
  return remainingTs
end

function LotteryPoolData:GetStartAndEndTime()
  local activityFrame = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actUid = activityFrame:GetIdByActTypeAndActId(ActivityFrameEnum.eActivityType.Lotter, self.ltrCfg.lottery_id)
  local actInfo = activityFrame:GetActivityFrameData(actUid)
  if actInfo == nil then
    return -1, -1
  else
    return actInfo.startTime, actInfo.endTime
  end
end

function LotteryPoolData:IsLtrPoolLimitTime()
  local _, endTime = self:GetStartAndEndTime()
  return endTime ~= -1
end

function LotteryPoolData:HasLtrPt()
  return self.ltrCfg.is_pt
end

function LotteryPoolData:GetLtrPtNum()
  if not self:HasLtrPt() then
    return 0
  end
  return self.pt or 0
end

function LotteryPoolData:GetLotteryDataNavTag()
  return self.ltrCfg.nav_tag
end

function LotteryPoolData:GetLtrPoolDataCfg()
  return self.ltrCfg
end

function LotteryPoolData:GetLotteryDataCfgPoolType()
  return self.ltrCfg.pool_type
end

function LotteryPoolData:GetTagNameAndIconIndex()
  return LanguageUtil.GetLocaleText(self.ltrCfg.nav_tagName), self.ltrCfg.nav_tagIcon
end

function LotteryPoolData:GetLtrFreeChoiceHeroIdList()
  local ltrSelectionCfg = ConfigData.lottery_selection[self.poolId]
  if ltrSelectionCfg == nil then
    error("Cant get lottery_selection, poolId = " .. tostring(self.poolId))
    return table.emptytable
  end
  local heroId2ItemIdMapDic = {}
  local heroIdList = {}
  for k, itemId in ipairs(ltrSelectionCfg.item_rewardIds) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg.action_type == eItemActionType.HeroCard then
      local heroId = itemCfg.arg[1]
      table.insert(heroIdList, heroId)
      heroId2ItemIdMapDic[heroId] = itemId
    else
      error("item is not hero, item id = " .. tostring(itemId))
    end
  end
  return heroIdList, heroId2ItemIdMapDic
end

function LotteryPoolData:IsLtrFreeChoicePrompt()
  return self.ltrCfg.is_prompt
end

function LotteryPoolData:TryGetLtrCustomDrawNum()
  if not self:IsLtrExecTypeOpen(LotteryEnum.eLtrExecType.CustomNum) then
    return false
  end
  local itemCount = PlayerDataCenter:GetItemCount(self.ltrCfg.costId1)
  local drawNum = itemCount // self.ltrCfg.costNum1
  return true, drawNum
end

function LotteryPoolData:IsLtrSpecialUp()
  return self.ltrCfg.special_up > 0
end

function LotteryPoolData:GetLtrNoUpNum()
  return self._noUpNum or 0
end

function LotteryPoolData:GetLtrSpecialUpNum()
  return self.ltrCfg.special_up
end

function LotteryPoolData:ShowLtrUpIntro()
  return false
end

function LotteryPoolData:IsLtrHeroConvertFrag()
  return self.ltrCfg.repeat_type == 1
end

function LotteryPoolData:GetLtrUpHeroFragDic()
  if self:IsLtrHeroConvertFrag() then
    local upHeroFragDic = {}
    for heroId, _ in pairs(self.ltrCfg.heroUpAllDic) do
      upHeroFragDic[heroId] = self.ltrCfg.big_prize_extra_num
    end
    return upHeroFragDic
  end
  return nil
end

function LotteryPoolData:IsShowLtrNewRuleReddot()
  if self.ltrCfg.new_rule_reddot == 0 then
    return false
  end
  local isRead = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):IsReadLtrNewRuleReddot(self.ltrCfg.new_rule_reddot)
  return not isRead
end

function LotteryPoolData:IsLtrHasTenPrior()
  return self.ltrCfg.costIdTenPrior ~= nil and self.ltrCfg.costIdTenPrior ~= 0
end

function LotteryPoolData:LtrCurTenIsPrior()
  return self:IsLtrHasTenPrior() and PlayerDataCenter:GetItemCount(self.ltrCfg.costIdTenPrior) >= self.ltrCfg.costNumTenPrior
end

function LotteryPoolData:LtrCanJumpByExternal()
  return self.ltrCfg.system_jump
end

function LotteryPoolData:TryGetLtrIntoAvgNotPlayed()
  local avgId = self.ltrCfg.intro_avg
  if avgId ~= 0 and not ControllerManager:GetController(ControllerTypeId.AvgPlay, true):IsAvgPlayed(avgId) then
    return avgId
  end
  return nil
end

function LotteryPoolData:GetBuyableGiftIdList()
  if #self.ltrCfg.gift_id == 0 then
    return false
  end
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  for k, giftId in ipairs(self.ltrCfg.gift_id) do
    local giftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
    if giftInfo and giftInfo:IsUnlock() and not giftInfo:IsSoldOut() then
      return true, self.ltrCfg.gift_id
    end
  end
  return false
end

function LotteryPoolData:IsLtrSpecialSelectHero()
  return ConfigData.lottery.ltrSpeSelectDic[self.poolId] ~= nil
end

function LotteryPoolData:GetLtrSpeSelectHeroRewardType()
  return ConfigData.lottery.ltrSpeSelectDic[self.poolId]
end

function LotteryPoolData:GetLtrSpeSelectTotalList()
  local rewardType = self:GetLtrSpeSelectHeroRewardType()
  if rewardType == nil then
    return table.emptytable
  end
  local cfgDic = ConfigData.lottery_reward_pool[rewardType]
  if cfgDic == nil then
    error("Cant get lottery_reward_pool cfg, rewardType:" .. tostring(rewardType))
    return table.emptytable
  end
  local itemIdList = {}
  for k, cfg in pairs(cfgDic) do
    table.insert(itemIdList, cfg.item_reward)
  end
  table.sort(itemIdList)
  return itemIdList
end

function LotteryPoolData:GetLtrSpeSelectedList()
  local rewardType = self:GetLtrSpeSelectHeroRewardType()
  local customMsg = self._customDic[rewardType]
  return customMsg and customMsg.itemReward
end

return LotteryPoolData
