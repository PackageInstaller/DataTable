local UIEventBattlePassPurchase = class("UIEventBattlePassPurchase", UIBaseWindow)
local base = UIBaseWindow
local UINBattlePassPurchaseItem1 = require("Game.BattlePass.UI.UINBattlePassPurchaseItem1")
local UINBattlePassPurchaseItem2 = require("Game.BattlePass.UI.UINBattlePassPurchaseItem2")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")

function UIEventBattlePassPurchase:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnBtnCloseClick)
  UIUtil.SetTopStatus(self, self.OnReturnClick, nil, nil, nil, true)
  self.__battlepassBuyAction = BindCallback(self, self.OnBattlepassBuyClicked)
  self.resloader = CS.ResLoader.Create()
end

function UIEventBattlePassPurchase:InitBattlePassPurchaseUI(passInfo)
  self.passInfo = passInfo
  self:InitBattlePassPurchaseStaticUI()
  self.passPurchaseList = {}
  self:CreateSeniorPurchaseItem()
  self:CreateUltimatePurchaseItem()
end

function UIEventBattlePassPurchase:InitBattlePassPurchaseStaticUI()
end

function UIEventBattlePassPurchase:CreateSeniorPurchaseItem()
  local purchaseItem = UINBattlePassPurchaseItem1.New()
  purchaseItem:Init(self.ui.normalPurchaseItem)
  local purchaseType = BattlePassEnum.BuyQuality.Senior
  local hasBuy = self.passInfo.unlockSenior
  purchaseItem:InitPassPurchaseItem1(purchaseType, self.passInfo, self.__battlepassBuyAction, hasBuy)
  self.passPurchaseList[purchaseType] = purchaseItem
end

function UIEventBattlePassPurchase:CreateUltimatePurchaseItem()
  local purchaseItem = UINBattlePassPurchaseItem2.New()
  purchaseItem:Init(self.ui.seniorPurchaseItem)
  local hasDiscount = false
  local purchaseType = BattlePassEnum.BuyQuality.Ultimate
  if self.passInfo.unlockSenior and not self.passInfo.unlockUltimate then
    purchaseType = BattlePassEnum.BuyQuality.SupplyUltimate
    hasDiscount = true
  end
  purchaseItem:InitPassPurchaseItem2(purchaseType, self.passInfo, self.__battlepassBuyAction, hasDiscount)
  self.passPurchaseList[purchaseType] = purchaseItem
end

function UIEventBattlePassPurchase:OnBattlepassBuyClicked(passId, purchaseType)
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  battlepassCtrl:BuyBattlePass(passId, purchaseType)
end

function UIEventBattlePassPurchase:OnBtnCloseClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEventBattlePassPurchase:OnReturnClick()
  self:Delete()
end

function UIEventBattlePassPurchase:OnDelete()
  if self._styleNode ~= nil then
    self._styleNode:Delete()
  end
  base.OnDelete(self)
end

return UIEventBattlePassPurchase
