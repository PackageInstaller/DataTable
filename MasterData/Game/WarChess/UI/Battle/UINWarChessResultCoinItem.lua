local base = UIBaseNode
local UINWarChessResultCoinItem = class("UINWarChessResultCoinItem", base)

function UINWarChessResultCoinItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessResultCoinItem:InitResultCoinItem(itemCfg, itemCount)
  self.ui.tex_Title:SetIndex(0, LanguageUtil.GetLocaleText(itemCfg.name))
  self.ui.img_Coin.sprite = CRH:GetSprite(itemCfg.icon)
  self.ui.tex_CoinCount.text = tostring(itemCount)
end

function UINWarChessResultCoinItem:OnDelete()
  base.OnDelete(self)
end

return UINWarChessResultCoinItem
