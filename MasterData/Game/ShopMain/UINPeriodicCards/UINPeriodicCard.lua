local UINPeriodicMonthCard = require("Game.ShopMain.UINPeriodicCards.UINPeriodicMonthCard")
local UINPeriodicWeekCard = require("Game.ShopMain.UINPeriodicCards.UINPeriodicWeekCard")
local UINPeriodicCard = class("UINPeriodicCard", UIBaseNode)
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType

function UINPeriodicCard:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.monthCard = UINPeriodicMonthCard.New()
  self.monthCard:Init(self.ui.obj_MonthCard)
  self.weekCard = UINPeriodicWeekCard.New()
  self.weekCard:Init(self.ui.obj_WeekCard)
end

function UINPeriodicCard:ShopCommonInit(uiShop)
  self.monthCard:ShopCommonInit(uiShop)
  self.weekCard:ShopCommonInit(uiShop)
end

function UINPeriodicCard:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  self.monthCard:InitMonthCardCfg(EPeriodicCardType.MonthCard)
  self.monthCard:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  self.weekCard:InitMonthCardCfg(EPeriodicCardType.WeekCard)
  self.weekCard:RefreshShopNode(shopId, pageId, autoSelectShelfId)
end

function UINPeriodicCard:OnDelete()
  self.monthCard:Delete()
  self.weekCard:Delete()
end

return UINPeriodicCard
