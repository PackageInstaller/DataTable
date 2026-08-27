local UINWarChessCoinDetail = class("UINWarChessCoinDetail", UIBaseNode)
local base = UIBaseNode

function UINWarChessCoinDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessCoinDetail:InitCoinDetail(itemCfg)
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.tex_Desc.text = LanguageUtil.GetLocaleText(itemCfg.describe)
end

function UINWarChessCoinDetail:OnDelete()
  base.OnDelete(self)
end

return UINWarChessCoinDetail
