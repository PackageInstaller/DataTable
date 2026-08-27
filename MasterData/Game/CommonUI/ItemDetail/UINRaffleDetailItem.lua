local UINRaffleDetailItem = class("UINRaffleDetailItem", UIBaseNode)
local base = UIBaseNode

function UINRaffleDetailItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINRaffleDetailItem:InitRaffleDetailItem(itemCfg, count, weight)
  self.ui.tex_DropInfo:SetIndex(0, LanguageUtil.GetLocaleText(itemCfg.name), count)
  self.ui.tex_Rate.text = tostring(weight) .. "%"
end

return UINRaffleDetailItem
