local UINFairyLtrPoolDetailItem = class("UILtrPoolDetailRateReward", UIBaseNode)
local base = UIBaseNode

function UINFairyLtrPoolDetailItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFairyLtrPoolDetailItem:InitFairyLtrPoolDetailItem(data)
  if data.isItem then
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(data.itemCfg.name)
  elseif data.isFairy then
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(data.fairyCfg.name)
  end
  self.ui.tex_Rate:SetIndex(0, GetPreciseDecimalStr(data.rate / 100, 2))
  self.ui.obj_IsUP:SetActive(false)
end

function UINFairyLtrPoolDetailItem:OnDelete()
  base.OnDelete(self)
end

return UINFairyLtrPoolDetailItem
