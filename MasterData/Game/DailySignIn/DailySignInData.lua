local DailySignInData = class("DailySignInData")
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType
local MonthCardData = require("Game.DailySignIn.MonthCardData")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")

function DailySignInData:ctor()
  self.__monthCardDataDic = {}
  self:InitMonthCardDataDic()
  self._dailyBonusIdIdx = 1
  self._cardExpireTimerIdDic = {}
end

function DailySignInData:InitMonthCardDataDic()
  self.__monthCardDataDic = self.__monthCardDataDic or {}
  for monthCardId, monthCardCfg in pairs(ConfigData.month_card) do
    if not self.__monthCardDataDic[monthCardId] ~= nil then
      self.__monthCardDataDic[monthCardId] = MonthCardData.CreateNewMonthCardData(monthCardId)
    else
      local cardData = self.__monthCardDataDic[monthCardId]
      cardData:InitMonthCardData(monthCardId)
    end
  end
end

function DailySignInData:UpdDailySignInBonusId()
  local dailyBonusId
  for i = self._dailyBonusIdIdx, #ConfigData.daily_bonus_time.startTimeIdList do
    local id = ConfigData.daily_bonus_time.startTimeIdList[i]
    local cfg = ConfigData.daily_bonus_time[id]
    local startOk = cfg.start_time == -1 or cfg.start_time <= PlayerDataCenter.timestamp
    local endOk = cfg.end_time == -1 or cfg.end_time >= PlayerDataCenter.timestamp
    if startOk and endOk then
      dailyBonusId = id
      self._dailyBonusIdIdx = i
      break
    end
  end
  if dailyBonusId == nil then
    error("Cant get dailyBonusId")
    return
  end
  self._dailyBonusId = dailyBonusId
end

function DailySignInData:UpadteMonthCardData(diffMsgDic)
  if diffMsgDic == nil or table.IsEmptyTable(diffMsgDic) then
    for monthCardId, cardData in pairs(self.__monthCardDataDic) do
      self:_ExpireCardData(monthCardId)
    end
    return
  end
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local cardMsgDic = {}
  for monthCardId, cardMsg in pairs(diffMsgDic) do
    cardMsgDic[monthCardId] = cardMsg
    local cardData = self.__monthCardDataDic[monthCardId]
    cardData.expireAt = cardMsg.expireAt
    cardData.discountDuration = cardMsg.discountDuration
    local lastTime = cardData.expireAt - PlayerDataCenter.timestamp
    local leftDayNum = math.ceil(lastTime / 86400)
    if 0 < leftDayNum then
      if cardData.isHaveMonthCard == false then
        self:_UpdCardBonus(monthCardId, true)
      end
      cardData.isHaveMonthCard = true
      cardData.monthCardLeftCount = leftDayNum
      timePassCtrl:RemoveEventTimer(self._cardExpireTimerIdDic[monthCardId])
      self._cardExpireTimerIdDic[monthCardId] = timePassCtrl:AddEventTimer(cardData.expireAt, function()
        self:_ExpireCardData(monthCardId)
        MsgCenter:Broadcast(eMsgEventId.MonthCardRefresh)
      end)
    else
      self:_ExpireCardData(monthCardId)
    end
  end
  local isCardDiscount = self:IsCardDiscount(EPeriodicCardType.MonthCard) or self:IsCardDiscount(EPeriodicCardType.WeekCard)
  ControllerManager:GetController(ControllerTypeId.Shop, true):AddMonthCardRedDot(isCardDiscount)
  MsgCenter:Broadcast(eMsgEventId.MonthCardRefresh)
end

function DailySignInData:_ExpireCardData(monthCardId)
  local cardData = self.__monthCardDataDic[monthCardId]
  if cardData == nil then
    return
  end
  if cardData.isHaveMonthCard == true then
    self:_UpdCardBonus(monthCardId, false)
  end
  cardData.isHaveMonthCard = false
  cardData.monthCardLeftCount = 0
end

function DailySignInData:_UpdCardBonus(monthCardId, isInstall)
  local uninstallLogicDic = not isInstall and {}
  local cardData = self.__monthCardDataDic[monthCardId]
  local privilegeIdList = cardData:GetMonthCardPrivilegeIdList()
  for k, id in ipairs(privilegeIdList) do
    local cfg = ConfigData.month_card_privilege[id]
    for k, logic in ipairs(cfg.logic) do
      local para1 = cfg.para1[k]
      local para2 = cfg.para2[k]
      local para3 = cfg.para3[k]
      local moduleId = proto_csmsg_SystemFunctionID.SystemFunctionID_SignIn
      if isInstall then
        PlayerDataCenter.playerBonus:InstallPlayerBonus(moduleId, monthCardId, logic, para1, para2, para3)
      elseif not uninstallLogicDic[logic] then
        PlayerDataCenter.playerBonus:UninstallPlayerBonus(moduleId, monthCardId, logic)
        uninstallLogicDic[logic] = true
      end
    end
  end
end

function DailySignInData:GetMonthCardData(cardType)
  return self.__monthCardDataDic[cardType]
end

function DailySignInData:GetIsMonthCardUnlock(cardType)
  local cardCfg = ConfigData.month_card[cardType]
  if cardCfg == nil then
    return false
  end
  return cardCfg ~= nil and CheckCondition.CheckLua(cardCfg.pre_condition, cardCfg.pre_para1, cardCfg.pre_para2)
end

function DailySignInData:IsCardDiscount(cardType)
  local cardData = self.__monthCardDataDic[cardType]
  if cardData == nil then
    return false
  end
  if cardData.discountDuration == nil then
    return false
  end
  return cardData.discountDuration > PlayerDataCenter.timestamp, cardData.discountDuration
end

function DailySignInData:IsHaveCard(cardType)
  local cardData = self.__monthCardDataDic[cardType]
  if cardData == nil then
    return false
  end
  return cardData.expireAt > PlayerDataCenter.timestamp and cardData.isHaveMonthCard
end

function DailySignInData:SingInNum()
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleMonthDailyBounsTimes, 0)
  if counterElem == nil then
    error("can't get counterElem for daily signIn return 1 as default")
    return 1
  end
  return counterElem.times
end

function DailySignInData:GetMonthCardLeftCount(cardType)
  local cardData = self.__monthCardDataDic[cardType]
  if cardData == nil then
    return 0
  end
  return cardData.expireAt > PlayerDataCenter.timestamp and cardData.monthCardLeftCount or 0
end

function DailySignInData:IsLimitMonthCardBuy(cardType)
  local cardData = self.__monthCardDataDic[cardType]
  if cardData == nil then
    return true
  end
  if cardData.monthCardCfg.max_days < cardData.monthCardLeftCount + cardData.monthCardCfg.duration_days then
    return true
  end
  return false
end

function DailySignInData:GetRewardByDayNum(dayNum)
  local itemDic = {}
  local bonusCfg = ConfigData.daily_bonus[self._dailyBonusId][dayNum]
  for index, id in ipairs(bonusCfg.award_ids) do
    if itemDic[id] == nil then
      itemDic[id] = bonusCfg.award_nums[index]
    else
      itemDic[id] = itemDic[id] + bonusCfg.award_nums[index]
    end
  end
  for _, cardData in pairs(self.__monthCardDataDic) do
    for index, id in ipairs(cardData.monthCardCfg.daily_award_ids) do
      if itemDic[id] == nil then
        itemDic[id] = cardData.monthCardCfg.daily_award_nums[index]
      else
        itemDic[id] = itemDic[id] + cardData.monthCardCfg.daily_award_nums[index]
      end
    end
  end
  return itemDic
end

function DailySignInData:GetSingInRewardByDayNum(dayNum)
  local bonusCfg = ConfigData.daily_bonus[self._dailyBonusId][dayNum]
  if bonusCfg == nil then
    return nil, nil
  end
  return bonusCfg.award_ids, bonusCfg.award_nums
end

function DailySignInData:GetMonthCardRewardBm(cardType)
  local cardCfg = ConfigData.month_card[cardType]
  if cardCfg == nil then
    return
  end
  return cardCfg.daily_award_ids, cardCfg.daily_award_nums
end

function DailySignInData:GetMonthCardPrivilegeDes(privilegeId)
  local cfg = ConfigData.month_card_privilege[privilegeId]
  if cfg == nil then
    error("Cant get month_card_privilege,id:" .. tostring(privilegeId))
    return
  end
  for k, logic in ipairs(cfg.logic) do
    local para1 = cfg.para1[k]
    local para2 = cfg.para2[k]
    local para3 = cfg.para3[k]
    local infoStr = CommonLogicUtil.GetDesString(logic, para1, para2, para3, eLogicDesType.StaminaCard)
    return infoStr
  end
end

return DailySignInData
