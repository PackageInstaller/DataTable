local MonthCardData = class("MonthCardData")
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType

function MonthCardData:ctor()
end

function MonthCardData.CreateNewMonthCardData(monthCardId)
  local cardData = MonthCardData.New()
  cardData:InitMonthCardData(monthCardId)
  return cardData
end

function MonthCardData:InitMonthCardData(monthCardId)
  self.monthCardCfg = ConfigData.month_card[monthCardId]
  self.monthCardId = monthCardId
  self.expireAt = 0
  self.monthCardLeftCount = 0
  self.discountDuration = 0
  self.isHaveMonthCard = false
  return self
end

function MonthCardData:GetIsHaveMonthCard()
  return self.isHaveMonthCard
end

function MonthCardData:GetMonthCardPrivilegeIdList()
  return self.monthCardCfg.privilege_id
end

function MonthCardData:GetMonthCardTipsDay()
  return self.monthCardCfg.remind_time
end

return MonthCardData
