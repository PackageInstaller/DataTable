local UINHeroLevelUpAttrItem = class("UINHeroLevelUpAttrItem", UIBaseNode)
local base = UIBaseNode

function UINHeroLevelUpAttrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHeroLevelUpAttrItem:InitAttrItem(attrId)
  self.attrId = attrId
  self.ui.img_Icon:SetIndex(attrId)
  self.ui.tex_attrName.text = LanguageUtil.GetLocaleText(ConfigData.attribute[attrId].name)
end

function UINHeroLevelUpAttrItem:SetValue(lastValue, newValue)
  self.ui.tex_Num.text = tostring(lastValue)
  if newValue == nil then
    self.ui.tex_Add.gameObject:SetActive(false)
  elseif newValue - lastValue < 1 then
    self.ui.tex_Add.gameObject:SetActive(false)
  else
    self.ui.tex_Add.gameObject:SetActive(true)
    self.ui.tex_Add:SetIndex(0, tostring(newValue - lastValue))
  end
end

function UINHeroLevelUpAttrItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroLevelUpAttrItem
