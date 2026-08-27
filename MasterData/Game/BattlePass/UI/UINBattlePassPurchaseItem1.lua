local UINBattlePassPurchaseItem1 = class("UINBattlePassPurchaseItem1", UIBaseNode)
local base = UIBaseNode
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")

function UINBattlePassPurchaseItem1:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnBtnPassBuyClicked)
end

function UINBattlePassPurchaseItem1:InitPassPurchaseItem1(purchaseType, passInfo, buyEvent, hasBuy)
  self.purchaseType = purchaseType
  self.passInfo = passInfo
  self.buyEvent = buyEvent
  self.ui.tex_Desc.text = LanguageUtil.GetLocaleText(self.passInfo.passCfg.describe2)
  self.ui.btn_Buy.gameObject:SetActive(not hasBuy)
  self.ui.img_HasPurchased:SetActive(hasBuy)
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  local payId = BattlePassEnum.GetPassPayId(purchaseType, self.passInfo.passCfg)
  self.ui.tex_Price.text = payCtrl:GetPayPriceShow(payId)
end

function UINBattlePassPurchaseItem1:OnBtnPassBuyClicked()
  if self.buyEvent ~= nil then
    self.buyEvent(self.passInfo.id, self.purchaseType)
  end
end

function UINBattlePassPurchaseItem1:OnDelete()
  base.OnDelete(self)
end

return UINBattlePassPurchaseItem1
