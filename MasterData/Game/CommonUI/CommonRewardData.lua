local CommonRewardData = class("CommonRewardData")
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType

function CommonRewardData.CreateCRDataUseDic(rewardDic)
  local data = CommonRewardData.New()
  local rewardIds = {}
  local rewardNums = {}
  for itemId, num in pairs(rewardDic) do
    if 0 < num and CommonRewardData.IsNeedShowItem(itemId) then
      table.insert(rewardIds, itemId)
      table.insert(rewardNums, num)
    end
  end
  data.rewardIds = rewardIds
  data.rewardNums = rewardNums
  data.rewardDataList = data:GenRewardDataList(data.rewardIds)
  return data
end

function CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums)
  local data = CommonRewardData.New()
  data.rewardIds = {}
  data.rewardNums = {}
  local count = 0
  for index, itemId in ipairs(rewardIds) do
    if CommonRewardData.IsNeedShowItem(itemId) then
      count = count + 1
      data.rewardIds[count] = itemId
      data.rewardNums[count] = rewardNums[index]
    end
  end
  data.rewardDataList = data:GenRewardDataList(data.rewardIds)
  return data
end

function CommonRewardData:ctor()
  self.rewardIds = nil
  self.rewardNums = nil
  self.heroSnapshoot = nil
  self.skipOldHero = nil
  self.title = nil
  self.rewardTips = nil
  self.exitAction = nil
  self.buyAction = nil
  self.isNotHandledGreat = nil
  self.isCRCutted = nil
  self.rewardDataList = nil
  self.newHeroIndexDic = nil
  self.heroIdList = nil
  self.downTitle = nil
  self.downContent = nil
end

function CommonRewardData.IsNeedShowItem(itemId)
  local removePassPoint = true
  if PlayerDataCenter.battlepassData:GetMainBattlePass() ~= nil then
    removePassPoint = false
  end
  if itemId > CommonUtil.UInt32Max then
  else
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("item cfg is null, id:" .. tostring(itemId))
      return false
    end
    if itemCfg.type == eItemType.BattlePassPoint and removePassPoint then
      return false
    end
    if itemCfg.is_shielded then
      return false
    end
  end
  return true
end

function CommonRewardData:GenRewardDataList(rewardIds)
  local rewardDataList = {}
  for index = 1, #rewardIds do
    local rewardId = rewardIds[index]
    local athUid = 0
    if rewardId > CommonUtil.UInt32Max then
      athUid = rewardId
      rewardId = athUid >> 32
      rewardIds[index] = rewardId
    end
    local itemCfg = ConfigData.item[rewardId]
    local rewardShowData = {itemCfg = itemCfg, athData = nil}
    if itemCfg.type == eItemType.Arithmetic and 0 < athUid then
      rewardShowData.athData = PlayerDataCenter.allAthData.athDic[athUid]
    end
    rewardDataList[index] = rewardShowData
  end
  return rewardDataList
end

function CommonRewardData:CRHandleHero()
  for index = 1, #self.rewardIds do
    local rewardId = self.rewardIds[index]
    if not (rewardId > CommonUtil.UInt32Max) then
      local itemCfg = ConfigData.item[rewardId]
      if itemCfg.action_type == eItemActionType.HeroCard then
        if self.heroIdList == nil then
          self.heroIdList = {}
        end
        if self.newHeroIndexDic == nil then
          self.newHeroIndexDic = {}
        end
        if itemCfg.arg == nil or itemCfg.arg[1] == nil then
          error("hero card item cfg error id=" .. rewardId)
        else
          table.insert(self.heroIdList, itemCfg.arg[1])
          if self.heroSnapshoot ~= nil and not self.heroSnapshoot[itemCfg.arg[1]] then
            self.newHeroIndexDic[#self.heroIdList] = true
          end
        end
      end
    end
  end
end

function CommonRewardData:CRSortRewards()
  return self
end

function CommonRewardData:SetCRHeroSnapshoot(heroSnapshoot, skipOldHero)
  self.heroSnapshoot = heroSnapshoot
  self.skipOldHero = skipOldHero
  self:CRHandleHero()
  return self
end

function CommonRewardData:SetCRHeroUpFragDic(upHeroFragDic)
  self.crUpHeroFragDic = upHeroFragDic
  return self
end

function CommonRewardData:SetCRItemTransDic(crItemTransDic)
  self.crItemTransDic = crItemTransDic
  return self
end

function CommonRewardData:SetCRItemCustomTransDic(crCustomItemTransDic)
  self.crCustomItemTransDic = crCustomItemTransDic
  if crCustomItemTransDic ~= nil then
    self.customItemIndexs = {}
    for k, v in pairs(crCustomItemTransDic) do
      table.insert(self.rewardIds, v.itemId)
      table.insert(self.rewardNums, v.itemNum)
      self.customItemIndexs[#self.rewardIds] = true
    end
    self.rewardDataList = self:GenRewardDataList(self.rewardIds)
  end
  return self
end

function CommonRewardData:SetCRItemNewDic(crItemNewDic)
  self.crItemNewDic = crItemNewDic
  return self
end

function CommonRewardData:SetCRTitle(title)
  self.title = title
  return self
end

function CommonRewardData:SetCRRewardTips(rewardTips)
  self.rewardTips = rewardTips
  return self
end

function CommonRewardData:SetCRShowOverFunc(exitAction)
  self.exitAction = exitAction
  return self
end

function CommonRewardData:SetCRShowOverBuyFunc(buyAction)
  self.buyAction = buyAction
  return self
end

function CommonRewardData:SetCRNotHandledGreat(bool)
  self.isNotHandledGreat = bool
  return self
end

function CommonRewardData:SetCRChallengeTask(fromNum, toNum, totalNum)
  self.challengeModeTaskFromNum = fromNum
  self.challengeModeTaskToNum = toNum
  self.challengeModeTaskTotalNum = totalNum
  return self
end

function CommonRewardData:SetCRBattlePassTip(index, ...)
  self.battlePassTipIndex = index
  self.battlePassTipValues = {
    ...
  }
  for index, value in ipairs(self.battlePassTipValues) do
    self.battlePassTipValues[index] = tostring(value)
  end
end

function CommonRewardData:GetCRBattlePassTip()
  return self.battlePassTipIndex or 0, table.unpack(self.battlePassTipValues or table.emptytable)
end

function CommonRewardData:SetCRBattlePassBuy(index, ...)
  self.battlePassBuyIndex = index
  self.battlePassBuyValues = {
    ...
  }
  for index, value in ipairs(self.battlePassBuyValues) do
    self.battlePassBuyValues[index] = tostring(value)
  end
end

function CommonRewardData:GetCRBattlePassBuy()
  return self.battlePassBuyIndex or 0, table.unpack(self.battlePassBuyValues or table.emptytable)
end

function CommonRewardData:SetCRBeforeMergeItemDic(rewardDic)
  self._beforeMergeItemDic = rewardDic
  return self
end

function CommonRewardData:SetCRMonthCardTimeTips(monthCardType, isShow)
  self._monthCardTimeTips = self._monthCardTimeTips or {}
  self._monthCardTimeTips[monthCardType] = isShow
  return self
end

function CommonRewardData:ClearCRMonthCardTimeTips()
  self._monthCardTimeTips = nil
  return self
end

function CommonRewardData:SetCutCRStaminaReward(show)
  self._cutCRStaminaReward = show
  return self
end

function CommonRewardData:SetBpSpRewardPreview(ids, nums)
  self._hasBpSpReward = true
  self._bpSpRewardIds = ids
  self._bpSpRewardNums = nums
  self._bpSpRewardList = self:GenRewardDataList(self._bpSpRewardIds)
  return self
end

function CommonRewardData:SetVowFavourLevelChange(fromLevel, toLevel)
  self._vowFromLevel = fromLevel
  self._vowToLevel = toLevel
  return self
end

function CommonRewardData:SetDownInfo(title, content)
  self.downTitle = title
  self.downContent = content
end

function CommonRewardData:GetCRBeforeMergeItemDic()
  if self:HasCRQZ() then
    if self._beforeMergeItemDic ~= nil then
      return self._beforeMergeItemDic
    end
    local itemDic = {}
    for k, id in ipairs(self.rewardIds) do
      itemDic[id] = self.rewardNums[k]
    end
    return itemDic
  end
  return self._beforeMergeItemDic or table.emptytable
end

function CommonRewardData:CutOutGreatRewards()
  if self.rewardIds == nil then
    return nil
  end
  local greatCRData
  if not self.isNotHandledGreat then
    local isHaveGreatRewards = false
    local greatItems, greatNums
    for index = #self.rewardIds, 1, -1 do
      local itemId = self.rewardIds[index]
      if ConfigData.game_config.itemWithGreatFxDic[itemId] then
        if not isHaveGreatRewards then
          isHaveGreatRewards = true
          greatItems = {}
          greatNums = {}
        end
        table.insert(greatItems, 1, itemId)
        table.insert(greatNums, 1, self.rewardNums[index])
        table.remove(self.rewardIds, index)
        table.remove(self.rewardNums, index)
        table.remove(self.rewardDataList, index)
      end
    end
    if isHaveGreatRewards then
      greatCRData = CommonRewardData.CreateCRDataUseList(greatItems, greatNums):SetCRTitle(self.title):SetCRRewardTips(self.rewardTips):SetCRBeforeMergeItemDic(self._beforeMergeItemDic)
      greatCRData:SetCRMonthCardTimeTips(EPeriodicCardType.MonthCard, self:HasCRMonthCardTimeTips(EPeriodicCardType.MonthCard))
      greatCRData:SetCRMonthCardTimeTips(EPeriodicCardType.WeekCard, self:HasCRMonthCardTimeTips(EPeriodicCardType.WeekCard))
    end
  end
  self.isCRCutted = true
  return greatCRData
end

function CommonRewardData:TryCutOutStaminaRewards()
  if self.rewardIds == nil or not self._cutCRStaminaReward then
    return nil
  end
  for index = #self.rewardIds, 1, -1 do
    local itemId = self.rewardIds[index]
    if itemId == ConstGlobalItem.SKey then
      local itemIds = {itemId}
      local itemNums = {
        self.rewardNums[index]
      }
      table.remove(self.rewardIds, index)
      table.remove(self.rewardNums, index)
      table.remove(self.rewardDataList, index)
      local greatCRData = CommonRewardData.CreateCRDataUseList(itemIds, itemNums):SetCRTitle(self.title):SetCRRewardTips(self.rewardTips):SetCRBeforeMergeItemDic(self._beforeMergeItemDic):SetCutCRStaminaReward(self._cutCRStaminaReward)
      greatCRData:SetCRMonthCardTimeTips(EPeriodicCardType.StaminaCard, self:HasCRMonthCardTimeTips(EPeriodicCardType.StaminaCard))
      return greatCRData
    end
  end
end

function CommonRewardData:IsCRDHasCouldShow()
  if #self.rewardIds == 0 then
    return false
  end
  return true
end

function CommonRewardData:HasCRQZ()
  for k, itemId in ipairs(self.rewardIds) do
    if itemId == ConstGlobalItem.PaidQZ or itemId == ConstGlobalItem.PaidItem then
      return true
    end
  end
  return false
end

function CommonRewardData:HasCRMonthCardTimeTips(monthCardType)
  if self._monthCardTimeTips == nil then
    return false
  end
  return self._monthCardTimeTips[monthCardType]
end

function CommonRewardData:GetBpSpRewardPreview()
  return self._hasBpSpReward, self._bpSpRewardIds, self._bpSpRewardNums
end

function CommonRewardData:GetBpSpRewardCount()
  if self._hasBpSpReward and self._bpSpRewardIds ~= nil then
    return #self._bpSpRewardIds
  end
  return 0
end

function CommonRewardData:GetVowFavourLevelChange()
  return self._vowFromLevel or 0, self._vowToLevel or 0
end

function CommonRewardData:GetBpSpRewardList()
  return self._bpSpRewardList
end

function CommonRewardData:Delete()
end

return CommonRewardData
