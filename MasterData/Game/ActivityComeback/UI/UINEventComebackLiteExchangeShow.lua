local UINEventComebackExchangeShow = require("Game.ActivityComeback.UI.UINEventComebackExchangeShow")
local UINEventComebackLiteExchangeShow = class("UINEventComebackLiteExchangeShow", UINEventComebackExchangeShow)
local base = UINEventComebackExchangeShow
local UINEventComebackLiteExchangeShowTitle = require("Game.ActivityComeback.UI.UINEventComebackLiteExchangeShowTitle")
local UINAct21SumExcgRewardItem = require("Game.ActivitySummer.UI.ActSum21Exchange.UINAct21SumExcgRewardItem")

function UINEventComebackLiteExchangeShow:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseShow)
  UIUtil.AddButtonListener(self.ui.closeBg, self, self.OnClickCloseShow)
  self.titlePool = UIItemPool.New(UINEventComebackLiteExchangeShowTitle, self.ui.groupItems)
  self.ui.groupItems:SetActive(false)
  self._itemPool = UIItemPool.New(UINAct21SumExcgRewardItem, self.ui.exchangeItem)
  self.ui.exchangeItem:SetActive(false)
end

return UINEventComebackLiteExchangeShow
